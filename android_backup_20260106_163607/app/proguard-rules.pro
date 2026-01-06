# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/local/Cellar/android-sdk/24.3.3/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# react-native-reanimated
-keep class com.swmansion.reanimated.** { *; }
-keep class com.facebook.react.turbomodule.** { *; }

# Expo modules
-keep class expo.modules.** { *; }
-keepclassmembers class expo.modules.** { *; }

# SQLite - CRITICAL for database operations
-keep class org.sqlite.** { *; }
-keep class org.sqlite.database.** { *; }
-keepclassmembers class org.sqlite.** { *; }
-keep class net.sqlcipher.** { *; }
-keep class net.sqlcipher.database.** { *; }

# expo-sqlite
-keep class expo.modules.sqlite.** { *; }
-keepclassmembers class expo.modules.sqlite.** { *; }

# expo-location
-keep class expo.modules.location.** { *; }
-keepclassmembers class expo.modules.location.** { *; }

# expo-task-manager - CRITICAL for background location
-keep class expo.modules.taskManager.** { *; }
-keepclassmembers class expo.modules.taskManager.** { *; }

# React Native Maps
-keep class com.google.android.gms.maps.** { *; }
-keep class com.airbnb.android.react.maps.** { *; }
-keepclassmembers class com.airbnb.android.react.maps.** { *; }

# AsyncStorage
-keep class com.reactnativecommunity.asyncstorage.** { *; }
-keepclassmembers class com.reactnativecommunity.asyncstorage.** { *; }

# Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Hermes
-keep class com.facebook.hermes.unicode.** { *; }
-keep class com.facebook.jni.** { *; }

# Keep React Native
-keep,allowobfuscation @interface com.facebook.proguard.annotations.DoNotStrip
-keep,allowobfuscation @interface com.facebook.proguard.annotations.KeepGettersAndSetters
-keep @com.facebook.proguard.annotations.DoNotStrip class *
-keepclassmembers class * {
    @com.facebook.proguard.annotations.DoNotStrip *;
}

# JSR 305 annotations
-dontwarn javax.annotation.**

# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# Add any project specific keep options here:
