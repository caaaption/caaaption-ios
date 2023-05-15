open:
	open caaaption.xcworkspace

clean:
	rm -rf ./.swiftpm
	rm -rf ./.build

test: test-color-hex

build: build-caaaption

PLATFORM_IOS = iOS Simulator,name=iPhone 13 Pro,OS=16.2

test-color-hex:
	@xcodebuild test \
		-workspace caaaption.xcworkspace \
		-scheme "ColorHexTests" \
		-destination platform="$(PLATFORM_IOS)"

build-caaaption:
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Staging project)" \
		-sdk iphonesimulator
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Production project)" \
		-sdk iphonesimulator

format:
	@swift build -c release --package-path ./BuildTools/SwiftFormatTool --product swiftformat
	./BuildTools/SwiftFormatTool/.build/release/swiftformat ./

install-template:
	@swift build -c release --package-path ./BuildTools/XCTemplateInstallerTool --product XCTemplateInstaller
	./BuildTools/XCTemplateInstallerTool/.build/release/XCTemplateInstaller --xctemplate-path XCTemplates/TCA.xctemplate

apollo-cli-install:
	@swift package --package-path ./caaaption --allow-writing-to-package-directory apollo-cli-install

apollo-generate:
	./caaaption/apollo-ios-cli generate