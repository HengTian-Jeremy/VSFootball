#include <stdio.h>
#include "include/com_engagemobile_vsfootball_natives_Core.h"
#include <fcntl.h>
#include <sys/stat.h>
#include "jni_interface.h"
#include <android/asset_manager_jni.h>
#include <fstream>
#include <EGL/egl.h>
#include <GLES/gl.h>
#include <android/log.h>
#include <sys/time.h>
#include <string.h>
#include "Threads.h"
#include <vsfMain.h>

#define EngageLog(...) EngageLogTag(1 << 31, __VA_ARGS__)
#define EngageLogTag(tag, ...) do { if((tag) != 0) { \
        __android_log_print(ANDROID_LOG_DEBUG,"engagemobile",__VA_ARGS__); \
    } } while(0)


// Global env ref (for callbacks)
/*static*/ JavaVM *g_VM;
Mutex mutex;

// Global Reference to the native Java class
static jclass jNativesCls;

#define CB_CLASS "com/engagemobile/vsfootball/natives/Core"

//Mapping EvpProcessor to Natives.java

//    Signature  Java Type
//    Z  boolean
//    B  byte
//    C  char
//    S  short
//    I  int
//    J  long
//    F  float
//    D  double
//    L fully-qualified-class ;  fully-qualified-class
//    [ type     type[]
//     ( arg-types ) ret-type    method type

#define CB_CLASS_HTTP_SEND_CB  "handleSendOverHttp"
#define CB_CLASS_HTTP_SEND_SIG  "(ILjava/lang/String;Ljava/lang/String;)V"
static jmethodID jniHandleSendOverHttp;

class VSF : public vsf::VsfMain {
public:
    VSF();
    virtual void handleSendOverHttp(int method, string url, string payload);

private:
    EGLDisplay display;
    EGLConfig config;
};


VSF::VSF() : VsfMain()
{
    display = 0;
    config= 0;
}

void VSF::handleSendOverHttp(int method, string url, string payload) {
    if (!g_VM || !jNativesCls) {
        return;
    }
    JNIEnv* env = 0;
    g_VM->AttachCurrentThread(&env, 0);
    jstring jUrl = env->NewStringUTF(url.c_str());
    jstring jPayload = env->NewStringUTF(payload.c_str());
    JniInterface::callStaticVoidMethod(jniHandleSendOverHttp, CB_CLASS_HTTP_SEND_CB, CB_CLASS_HTTP_SEND_SIG, 3, jUrl, jPayload);
}


extern "C" {

    VSF* vsfootball = NULL;

    JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved)
    {
        EngageLog("JNI_OnLoad called for vsfootball android");
        return JNI_VERSION_1_4;
    }

    JNIEXPORT jint JNICALL Java_com_engagemobile_vsfootball_natives_Core_LibMain
    (JNIEnv * env, jclass, jobjectArray jargv, jobject assetMgr)
    {
        EngageLog("LibMain start");
        int pid = getpid();
        char cmdline[100];
        sprintf(cmdline, "/proc/%d/cmdline", pid);

        char app_dir[256];
        strcpy(app_dir, ".");
        std::ifstream cmd_in(cmdline);
        if (cmd_in) {
            char line[256];
            cmd_in.getline(line, 256);
            sprintf(app_dir, "/data/data/%s", line);
        }

        AAssetManager* asset_manager = AAssetManager_fromJava(env, assetMgr);

        // obtain a global ref to the caller jclass
        env->GetJavaVM(&g_VM);

        // Extract char ** args from Java array
        jsize clen = env->GetArrayLength(jargv);

        char * args[(int)clen];

        int i;
        jstring jrow;
        for (i = 0; i < clen; i++) {
            // Get C string from Java String[i]
            jrow = (jstring)env->GetObjectArrayElement(jargv, i);
            const char *row  = env->GetStringUTFChars(jrow, 0);

            //args[i] = malloc( strlen(row) + 1);
            //strcpy (args[i], row);
            // print args
            //jni_printf("Main argv[%d]=%s", i, args[i]);

            // free java string jrow
            env->ReleaseStringUTFChars(jrow, row);
        }

        // Load the Natives Java class
        jNativesCls = env->FindClass(CB_CLASS);
        if ( jNativesCls == 0 ) {
            EngageLog("Unable to find class: %s", CB_CLASS);
            return -1;
        }
        jNativesCls = jclass(env->NewGlobalRef(jNativesCls));

        vsfootball = new VSF();

        EngageLog("LibMain end");
        return 0;
    }

    JNIEXPORT void JNICALL Java_com_engagemobile_vsfootball_natives_Core_start
    (JNIEnv * env, jclass cls)
    {
        EngageLog("Core Start");

        if (vsfootball != NULL) {
            vsfootball->handleSendOverHttp(1, "testUrl", "testpayload");
        }

        EngageLog("Core Started");
    }

    JNIEXPORT void JNICALL Java_com_engagemobile_vsfootball_natives_Core_stop
    (JNIEnv * env, jclass cls)
    {
        EngageLog("Core Stop");

        if (vsfootball != NULL) {
            delete vsfootball;
            vsfootball = NULL;
        }

        EngageLog("Core Stopped");
    }
}

void JniInterface::callStaticVoidMethod(jmethodID &method_id, const char * method, const char * signature, ...)
{
    if (!g_VM || !jNativesCls) {
        return;
    }

    JNIEnv* env = 0;
    g_VM->AttachCurrentThread(&env, 0);

    if (!method_id) {
        method_id = env->GetStaticMethodID(jNativesCls, method, signature);
    }
    if (method_id) {
        EngageLog("Calling %s %s\n", method, signature);

        va_list args;
        va_start(args, signature);
        env->CallStaticVoidMethodV(jNativesCls, method_id, args);
        va_end(args);
    }
    else {
        EngageLog("Unable to find method: %s, signature: %s\n",
              method, signature );
    }
}
