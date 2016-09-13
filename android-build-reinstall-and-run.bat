lime build android -release
adb install -r export/android/bin/bin/RepelBall-release.apk
adb shell am start -n com.bluebirdaward.repelball/com.bluebirdaward.repelball.MainActivity
pause