# By default, the flags in this file are appended to flags specified
# in /Applications/Android Studio.app/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:


# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify
-dontoptimize
-verbose



# Basic elements
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.BroadcastReceiver
#-keep public class * extends com.reactnativenavigation.NavigationApplication
#-keep public class com.google.gson.Gson
-keep class com.facebook.hermes.unicode.** { *; }
-keep class com.facebook.jni.** { *; }

-keep class android.support.v4.app.** { *; }
-keep interface android.support.v4.app.** { *; }
-keep class android.support.v7.app.** { *; }
-keep interface android.support.v7.app.** { *; }
-keep class io.sqlc.** {*; }
-keep class com.westernunion.moneytransferr3app.** {*; }
-keep class com.wurnmobile.** {*; }
-keep class com.pdf.generator.** {*; }
-keep class com.wu.widget.** {*; }
-keep public class com.horcrux.svg.** {*;}
-dontwarn com.google.firebase.messaging.**
-keep class com.facebook.react.devsupport.** { *; }
-dontwarn com.facebook.react.devsupport.**

# for views
#-keep public class * extends View {
#public <init>(android.content.Context);
#public <init>(android.content.Context, android.util.AttributeSet);
#public <init>(android.content.Context, android.util.AttributeSet, int);
#public void set*(...);
#}

# Enumerations
-keepclassmembers enum  * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep our interfaces so they can be used by other ProGuard rules.
# See https://sourceforge.net/p/proguard/bugs/466/
-keep,allowobfuscation @interface com.facebook.proguard.annotations.DoNotStrip
-keep,allowobfuscation @interface com.facebook.proguard.annotations.KeepGettersAndSetters
-keep,allowobfuscation @interface com.facebook.common.internal.DoNotStrip

# Do not strip any method/class that is annotated with @DoNotStrip
-keep @com.facebook.proguard.annotations.DoNotStrip class *
-keep @com.facebook.common.internal.DoNotStrip class *
-keepclassmembers class * {
    @com.facebook.proguard.annotations.DoNotStrip *;
    @com.facebook.common.internal.DoNotStrip *;
}

-keepclassmembers @com.facebook.proguard.annotations.KeepGettersAndSetters class * {
  void set*(***);
  *** get*();
}

-keep class * extends com.facebook.react.bridge.JavaScriptModule { *; }
-keep class * extends com.facebook.react.bridge.NativeModule { *; }
-keepclassmembers,includedescriptorclasses class * { native <methods>; }
-keepclassmembers class *  { @com.facebook.react.uimanager.annotations.ReactProp <methods>; }
-keepclassmembers class *  { @com.facebook.react.uimanager.annotations.ReactPropGroup <methods>; }

-dontwarn com.facebook.react.**
-keep,includedescriptorclasses class com.facebook.react.bridge.** { *; }

# okhttp

-keepattributes Signature
-keepattributes *Annotation*
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# okio

#-keep class sun.misc.Unsafe { *; }
-dontwarn java.nio.file.*
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-dontwarn okio.**

# react-native-config
#-keep class com.wurnmobile.BuildConfig { *; }

-keep class io.invertase.firebase.messaging.** { *; }
-dontwarn io.invertase.firebase.messaging.**

# Google Play Services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# DEBUG MODE: set line numbers and also stacktrace
-printmapping outputfile.txt

-dontwarn org.jboss.**
-dontwarn com.ning.http.**
-dontwarn org.apache.http.**
-dontwarn com.fasterxml.jackson.databind.**
-dontwarn retrofit.**
-dontwarn com.squareup.okhttp.**
-dontwarn org.w3c.dom.bootstrap.DOMImplementationRegistry
-dontwarn org.slf4j.**
-dontwarn fm.**
-dontwarn org.bouncycastle.**
-dontwarn okio.**
-dontwarn okhttp3.**
-dontwarn com.google.**
-dontwarn avp8.**
-dontwarn aopus.**
-dontwarn aaudioprocessing.**
-dontwarn com.idmission.fingerprintcapture.**



-keep class retrofit.** { *; }
-keepclasseswithmembers class * {
    @retrofit.http.* <methods>;
}

-dontwarn org.joda.time.**
-keep class org.joda.time.** { *; }

#-keep class sun.misc.Unsafe { *; }

-keep class com.squareup.okhttp.** { *; }
-keep interface com.squareup.okhttp.** { *; }

-keep class com.quantummetric.** { *; }
-keep class de.idnow.sdk.**{ *; }
-keep class com.opentok.** { *; }
-keep class org.webrtc.** { *; }
-keep class com.fasterxml.jackson.** { *; }
-keep class com.ning.http.** { *; }
-keep class fm.** { *; }
-keep class org.bouncycastle.** { *; }
-keep class com.google.** { *; }
-keep class avp8.** { *; }
-keep class aopus.** { *; }
-keep class aaudioprocessing.** { *; }
-keep class com.apiguard3.** { *; }
-keep class com.iovation.mobile.android.** { *; }

-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile, LineNumberTable

# Keep `Companion` object fields of serializable classes.
# This avoids serializer lookup through `getDeclaredClasses` as done for named companion objects.
-if @kotlinx.serialization.Serializable class **
-keepclassmembers class <1> {
    static <1>$Companion Companion;
}

# Keep `serializer()` on companion objects (both default and named) of serializable classes.
-if @kotlinx.serialization.Serializable class ** {
    static **$* *;
}
-keepclassmembers class <2>$<3> {
    kotlinx.serialization.KSerializer serializer(...);
}

# Keep `INSTANCE.serializer()` of serializable objects.
-if @kotlinx.serialization.Serializable class ** {
    public static ** INSTANCE;
}
-keepclassmembers class <1> {
    public static <1> INSTANCE;
    kotlinx.serialization.KSerializer serializer(...);
}

# @Serializable and @Polymorphic are used at runtime for polymorphic serialization.
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault

# Serializer for classes with named companion objects are retrieved using `getDeclaredClasses`.
# If you have any, uncomment and replace classes with those containing named companion objects.
#-keepattributes InnerClasses # Needed for `getDeclaredClasses`.
#-if @kotlinx.serialization.Serializable class
#com.example.myapplication.HasNamedCompanion, # <-- List serializable classes with named companions.
#com.example.myapplication.HasNamedCompanion2
#{
#    static **$* *;
#}
#-keepnames class <1>$$serializer { # -keepnames suffices; class is kept when serializer() is kept.
#    static <1>$$serializer INSTANCE;
#}
