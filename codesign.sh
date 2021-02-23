	codesign --sign - --force --deep /Applications/VSCodium.app
xattr -d com.apple.quarantine /Applications/VSCodium.app
deleting quarantine only solved my problem.
xattr -d com.apple.quarantine /Applications/VSCodium.app