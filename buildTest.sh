xcodebuild clean build \
	-project Demo/Demo.xcodeproj \
	-configuration Debug \
	-target Demo \
	-sdk iphonesimulator \
	ONLY_ACTIVE_ARCH=NO
