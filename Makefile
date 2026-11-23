# Photos — Academy Build: file manifest + build rules.
#
# This Makefile is the build's bill of materials: SOURCES and HEADERS
# are the complete file list.
#
#   make check   syntax-check every source against the MacOSX10.13 SDK
#                (Linux VM recipe per estate TOOLS.md; no link, no run)
#   make app     assemble Academy Photos.app (macOS only)
#
# Memory model is manual reference counting (the sources retain/release
# explicitly), so neither target passes -fobjc-arc.

SOURCES = \
	Photos/main.m \
	Photos/AppDelegate.m \
	Photos/PhotosWebViewController.m \
	Photos/WelcomeWindowController.m

HEADERS = \
	Photos/AppDelegate.h \
	Photos/PhotosWebViewController.h \
	Photos/WelcomeWindowController.h

SDK ?= $(HOME)/workspace/tools/sdks/MacOSX10.13.sdk
CLANG ?= clang
OBJCFLAGS = -target x86_64-apple-darwin17 -isysroot $(SDK) \
	-fobjc-runtime=macosx-10.13 -fsyntax-only -IPhotos

.PHONY: check app
check:
	@for src in $(SOURCES); do \
		echo "== $$src"; $(CLANG) $(OBJCFLAGS) $$src || exit 1; \
	done
	@echo "ALL SYNTAX OK"

app:
	@if [ "$$(uname)" != "Darwin" ]; then \
		echo "make app requires macOS (system clang + AppKit/WebKit)" >&2; exit 1; \
	fi
	rm -rf "Academy Photos.app"
	mkdir -p "Academy Photos.app/Contents/MacOS" "Academy Photos.app/Contents/Resources"
	$(CLANG) -target x86_64-apple-macos10.13 -IPhotos \
		-framework AppKit -framework Foundation -framework WebKit \
		-o "Academy Photos.app/Contents/MacOS/Academy Photos" $(SOURCES)
	cp Photos/Info.plist "Academy Photos.app/Contents/Info.plist"
	@echo "Academy Photos.app assembled — launch with: open \"Academy Photos.app\""
