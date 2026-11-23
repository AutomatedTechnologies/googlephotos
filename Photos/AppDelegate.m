// AppDelegate.m
// Photos — Academy Build
// Detroit Automation Academy. Academy-original code; no Google code or assets.

#import "AppDelegate.h"
#import "PhotosWebViewController.h"
#import "WelcomeWindowController.h"

static NSString * const kPhotosAcademyWelcomeShownKey = @"PhotosAcademyWelcomeShown";

@interface AppDelegate ()

@property (nonatomic, retain) NSWindow *mainWindow;
@property (nonatomic, retain) PhotosWebViewController *photosController;
@property (nonatomic, retain) WelcomeWindowController *welcomeController;

@end

@implementation AppDelegate

@synthesize mainWindow = _mainWindow;
@synthesize photosController = _photosController;
@synthesize welcomeController = _welcomeController;

- (void)dealloc {
    [_mainWindow release];
    [_photosController release];
    [_welcomeController release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    (void)notification;
    [self installMainMenu];

    NSRect frame = NSMakeRect(0.0, 0.0, 1100.0, 760.0);
    NSWindowStyleMask style = NSWindowStyleMaskTitled |
                              NSWindowStyleMaskClosable |
                              NSWindowStyleMaskMiniaturizable |
                              NSWindowStyleMaskResizable;
    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame
                                                     styleMask:style
                                                       backing:NSBackingStoreBuffered
                                                         defer:NO];
    [window setTitle:@"Academy Photos"];
    [window setMinSize:NSMakeSize(720.0, 480.0)];

    PhotosWebViewController *controller = [[PhotosWebViewController alloc] init];
    [window setContentViewController:controller];
    [self setPhotosController:controller];
    [controller release];

    [window center];
    [window makeKeyAndOrderFront:nil];
    [self setMainWindow:window];
    [window release];

    [NSApp activateIgnoringOtherApps:YES];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:kPhotosAcademyWelcomeShownKey]) {
        [defaults setBool:YES forKey:kPhotosAcademyWelcomeShownKey];
        [defaults synchronize];
        [self showWelcome:nil];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    (void)sender;
    return YES;
}

- (void)showWelcome:(id)sender {
    (void)sender;
    if ([self welcomeController] == nil) {
        WelcomeWindowController *controller = [[WelcomeWindowController alloc] init];
        [self setWelcomeController:controller];
        [controller release];
    }
    [[self welcomeController] showWindow:nil];
}

- (void)reloadPhotos:(id)sender {
    (void)sender;
    [[self photosController] reloadPage];
}

#pragma mark - Menus

- (void)installMainMenu {
    NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@"MainMenu"];

    // Application menu.
    NSMenuItem *appItem = [[NSMenuItem alloc] initWithTitle:@"Academy Photos" action:nil keyEquivalent:@""];
    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"Academy Photos"];
    [appMenu addItemWithTitle:@"About Academy Photos" action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
    [appMenu addItem:[NSMenuItem separatorItem]];
    NSMenuItem *welcomeItem = [[NSMenuItem alloc] initWithTitle:@"Welcome" action:@selector(showWelcome:) keyEquivalent:@""];
    [welcomeItem setTarget:self];
    [appMenu addItem:welcomeItem];
    [welcomeItem release];
    [appMenu addItem:[NSMenuItem separatorItem]];
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit Academy Photos" action:@selector(terminate:) keyEquivalent:@"q"];
    [appMenu addItem:quitItem];
    [quitItem release];
    [appItem setSubmenu:appMenu];
    [appMenu release];
    [mainMenu addItem:appItem];
    [appItem release];

    // Edit menu (standard responder-chain actions; WebKit text fields use these).
    NSMenuItem *editItem = [[NSMenuItem alloc] initWithTitle:@"Edit" action:nil keyEquivalent:@""];
    NSMenu *editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];
    [editMenu addItemWithTitle:@"Undo" action:@selector(undo:) keyEquivalent:@"z"];
    NSMenuItem *redoItem = [[NSMenuItem alloc] initWithTitle:@"Redo" action:@selector(redo:) keyEquivalent:@"Z"];
    [editMenu addItem:redoItem];
    [redoItem release];
    [editMenu addItem:[NSMenuItem separatorItem]];
    [editMenu addItemWithTitle:@"Cut" action:@selector(cut:) keyEquivalent:@"x"];
    [editMenu addItemWithTitle:@"Copy" action:@selector(copy:) keyEquivalent:@"c"];
    [editMenu addItemWithTitle:@"Paste" action:@selector(paste:) keyEquivalent:@"v"];
    [editMenu addItemWithTitle:@"Select All" action:@selector(selectAll:) keyEquivalent:@"a"];
    [editItem setSubmenu:editMenu];
    [editMenu release];
    [mainMenu addItem:editItem];
    [editItem release];

    // View menu.
    NSMenuItem *viewItem = [[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""];
    NSMenu *viewMenu = [[NSMenu alloc] initWithTitle:@"View"];
    NSMenuItem *reloadItem = [[NSMenuItem alloc] initWithTitle:@"Reload Page" action:@selector(reloadPhotos:) keyEquivalent:@"r"];
    [reloadItem setTarget:self];
    [viewMenu addItem:reloadItem];
    [reloadItem release];
    [viewItem setSubmenu:viewMenu];
    [viewMenu release];
    [mainMenu addItem:viewItem];
    [viewItem release];

    // Window menu.
    NSMenuItem *windowItem = [[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""];
    NSMenu *windowMenu = [[NSMenu alloc] initWithTitle:@"Window"];
    [windowMenu addItemWithTitle:@"Minimize" action:@selector(performMiniaturize:) keyEquivalent:@"m"];
    [windowMenu addItemWithTitle:@"Zoom" action:@selector(performZoom:) keyEquivalent:@""];
    [windowMenu addItem:[NSMenuItem separatorItem]];
    [windowMenu addItemWithTitle:@"Bring All to Front" action:@selector(arrangeInFront:) keyEquivalent:@""];
    [windowItem setSubmenu:windowMenu];
    [windowMenu release];
    [mainMenu addItem:windowItem];
    [windowItem release];
    [NSApp setWindowsMenu:windowMenu];

    // Help menu.
    NSMenuItem *helpItem = [[NSMenuItem alloc] initWithTitle:@"Help" action:nil keyEquivalent:@""];
    NSMenu *helpMenu = [[NSMenu alloc] initWithTitle:@"Help"];
    NSMenuItem *helpWelcomeItem = [[NSMenuItem alloc] initWithTitle:@"Welcome" action:@selector(showWelcome:) keyEquivalent:@""];
    [helpWelcomeItem setTarget:self];
    [helpMenu addItem:helpWelcomeItem];
    [helpWelcomeItem release];
    [helpItem setSubmenu:helpMenu];
    [helpMenu release];
    [mainMenu addItem:helpItem];
    [helpItem release];
    [NSApp setHelpMenu:helpMenu];

    [NSApp setMainMenu:mainMenu];
    [mainMenu release];
}

@end
