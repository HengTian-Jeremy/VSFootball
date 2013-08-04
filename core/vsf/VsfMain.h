#ifndef _vsfmain_h
#define _vsfmain_h

#include <stdlib.h>
#include <iostream>
#include <string.h>
using namespace std;

namespace vsf {
    class VsfMain {
    public:
        VsfMain();
        virtual void handleSendOverHttp(int method, string url, string payload) = 0;
        ~VsfMain();
    };
}
#endif
