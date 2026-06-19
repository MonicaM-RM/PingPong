# Gradle settings for PingPong game
# These settings optimize the build for Play Store

# Enable minification and optimization
android.enableR8=true

# Performance settings
org.gradle.jvmargs=-Xmx4096m
org.gradle.parallel=true
org.gradle.caching=true

# AndroidX support
android.useAndroidX=true
android.enableJetifier=true
