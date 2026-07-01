# Flutter wrapper
-keep class io.flutter.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep all Flutter plugin registrant + registered plugin classes (GeneratedPluginRegistrant)
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class io.flutter.plugins.pathprovider.** { *; }
-keep class io.flutter.plugins.urllauncher.** { *; }
-keep class dev.fluttercommunity.plus.packageinfo.** { *; }
-keep class dev.fluttercommunity.plus.share.** { *; }

# Lottie (lottie package)
-keep class com.airbnb.lottie.** { *; }
-dontwarn com.airbnb.lottie.**

# Prevent R8 from removing classes accessed via reflection in plugins
-keepclassmembers class * implements io.flutter.plugin.common.MethodChannel$MethodCallHandler {
    public void onMethodCall(io.flutter.plugin.common.MethodCall, io.flutter.plugin.common.MethodChannel$Result);
}
-keepclassmembers class * implements io.flutter.plugin.common.EventChannel$StreamHandler {
    public void onListen(java.lang.Object, io.flutter.plugin.common.EventChannel$EventSink);
    public void onCancel(java.lang.Object);
}

# Play Core — referenced by Flutter deferred component support
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Google Fonts
-keep class com.google.fonts.** { *; }
-dontwarn com.google.fonts.**

# OkHttp (used by http package)
-dontwarn okhttp3.**
-dontwarn okio.**
-keepnames class okhttp3.** { *; }

# Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Retain annotations and line numbers for stack traces
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# Keep Dart native bindings
-keep class dart.** { *; }
-dontwarn dart.**
