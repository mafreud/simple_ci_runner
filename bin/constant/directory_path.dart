const certificateDirectory = "~/Downloads/certificates";
const p12 = "$certificateDirectory/build_certificate.p12";
const mobileprovisionPath = "$certificateDirectory/build_pp.mobileprovision";
const keychainPath = "$certificateDirectory/app-signing.keychain-db";
const password = "mementomori";
String buildPath() =>
    "/Users/admin/Downloads/simple_runner_mobile/build/ios/ipa/simple_runner_mobile.ipa";
