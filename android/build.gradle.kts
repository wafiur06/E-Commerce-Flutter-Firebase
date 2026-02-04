// android/build.gradle.kts

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // --- FIX FOR TWITTER_LOGIN NAMESPACE ERROR ---
    afterEvaluate {
        if (project.name == "twitter_login") {
            // We use the fully qualified class name to avoid import errors
            project.extensions.configure<com.android.build.gradle.LibraryExtension> {
                namespace = "com.maru.twitter_login"
            }
        }
    }
    // ---------------------------------------------
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}