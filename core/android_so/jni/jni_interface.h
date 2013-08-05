#ifndef jni_interface_h
#define jni_interface_h

class JniInterface {
public:
    static void callStaticVoidMethod(jmethodID &method_id,
                                     const char * method,
                                     const char * signature,
                                     ...);
};

#endif
