# Flutter wrapper
-keep class io.flutter.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

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
