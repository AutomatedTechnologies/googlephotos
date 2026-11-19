// main.m
// Photos — Academy Build
// Detroit Automation Academy. Academy-original code; no Google code or assets.

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char *argv[]) {
    (void)argc;
    (void)argv;
    @autoreleasepool {
        NSApplication *application = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        [application setDelegate:delegate];
        [application run];
        [delegate release];
    }
    return 0;
}
