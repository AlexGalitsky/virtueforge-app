# Keep Flutter / JNI / llamadart native entry points.
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# llamadart / llama.cpp JNI
-keepclasseswithmembernames class * {
    native <methods>;
}
-keep class com.llamadart.** { *; }
-dontwarn com.llamadart.**
