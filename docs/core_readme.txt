All the C++ code has been checked in - it's all in a module called core, and is a top level directory on 'VsFootball'.

You will notice that core has two directories: android_so and vsf. I like to organize C++ source code in folders by namespace, so I followed the same convention here.

• android_so is the Android shared library - it has all the JNI (Java Native Interface) code. It uses the source code from vsf in building it the shared library.

• vsf is the where the logic should reside - it is the actual shared code between iOS and Android.

To use the C++ code in Android, you have to first build the android shared library, use terminal, and run make in the directory VsFootball/core/android_so
• There is a top level makefile, which invokes ndk-build -j6 (uses 6 CPU cores for faster compilation) and if the compilation is successful, installs the ARM shared libraries into the libs/ directory of the VsFootball android project.
To use this in eclipse, please Refresh the project (in the Package explorer or the Project explorer) so eclipse loads all files from disk again, and then run it on the device.
• Running make clean in this directory will clean all these libraries, so when you run make again, it will re-generate everything.

To use the C++ code in iOS, drag the vsf directory into the Xcode project, and it add it as a compilation unit in the Compile Sources in the Build Phases of the iOS project.

There are also a couple of utility functions/classes.
• The EngageLog() function should spit stuff out to Logcat, and has the same syntax as printf().
• The Thread.h file has a threading class that helps you deal with all threading related stuff in core.

Here are some tutorials you might find useful for using the NDK: http://mobile.tutsplus.com/tutorials/android/ndk-tutorial/ http://mindtherobot.com/blog/452/android-beginners-ndk-setup-step-by-step/ 

This blog has a lot of resources on Game Development, and talks about where to use C++ and how: http://sbcgamesdev.blogspot.com/ (This particular blog post if resourceful as well: http://sbcgamesdev.blogspot.com/2012/12/using-jnionload-in-adroid-ndk.html)

We'd like to leverage as much shared code as we can between iOS and Android - and this is in my opinion the most elegant way to achieve that.
