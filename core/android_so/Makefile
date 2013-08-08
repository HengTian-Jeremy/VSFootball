all:
	${NDK_ROOT}/ndk-build -j6
	cp libs/armeabi/libvsfootball.so ../../android/VsFootball/libs/armeabi/libvsfootball.so
	cp libs/armeabi-v7a/libvsfootball.so ../../android/VsFootball/libs/armeabi-v7a/libvsfootball.so

clean:
	rm -rf obj
	rm -rf libs
