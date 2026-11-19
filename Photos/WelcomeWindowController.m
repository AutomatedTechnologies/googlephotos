// WelcomeWindowController.m
// Photos — Academy Build
// Detroit Automation Academy. Academy-original code; no Google code or assets.

#import "WelcomeWindowController.h"

@implementation WelcomeWindowController

- (instancetype)init {
    NSRect frame = NSMakeRect(0.0, 0.0, 520.0, 360.0);
    NSWindowStyleMask style = NSWindowStyleMaskTitled |
                              NSWindowStyleMaskClosable;
    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame
                                                   styleMask:style
                                                     backing:NSBackingStoreBuffered
                                                       defer:NO];
    [window setTitle:@"Welcome"];
    [window setReleasedWhenClosed:NO];
    self = [super initWithWindow:window];
    [window release];
    if (self) {
        [self buildContent];
    }
    return self;
}

- (void)buildContent {
    NSWindow *window = [self window];
    NSView *content = [window contentView];

    NSTextField *titleField = [[NSTextField alloc] initWithFrame:NSMakeRect(40.0, 268.0, 440.0, 44.0)];
    [titleField setStringValue:@"Photos — Academy Build"];
    [titleField setFont:[NSFont boldSystemFontOfSize:24.0]];
    [titleField setBezeled:NO];
    [titleField setDrawsBackground:NO];
    [titleField setEditable:NO];
    [titleField setSelectable:NO];
    [content addSubview:titleField];
    [titleField release];

    NSTextField *bodyField = [[NSTextField alloc] initWithFrame:NSMakeRect(40.0, 96.0, 440.0, 156.0)];
    [bodyField setStringValue:
        @"A Detroit Automation Academy application for Google Photos.\n\n"
         "Sign in with your Google account in the main window and your "
         "library opens here, in a window of its own. Your session is "
         "kept on this Mac, so you stay signed in between launches.\n\n"
         "Links that leave Google open in your default browser. "
         "This window returns any time from the Help menu."];
    [bodyField setFont:[NSFont systemFontOfSize:13.0]];
    [bodyField setBezeled:NO];
    [bodyField setDrawsBackground:NO];
    [bodyField setEditable:NO];
    [bodyField setSelectable:NO];
    [[bodyField cell] setWraps:YES];
    [content addSubview:bodyField];
    [bodyField release];

    NSButton *closeButton = [[NSButton alloc] initWithFrame:NSMakeRect(380.0, 28.0, 100.0, 32.0)];
    [closeButton setTitle:@"Get Started"];
    [closeButton setBezelStyle:NSBezelStyleRounded];
    [closeButton setTarget:self];
    [closeButton setAction:@selector(dismissWelcome:)];
    [closeButton setKeyEquivalent:@"\r"];
    [content addSubview:closeButton];
    [closeButton release];

    [window center];
}

- (void)dismissWelcome:(id)sender {
    (void)sender;
    [[self window] close];
}

@end
