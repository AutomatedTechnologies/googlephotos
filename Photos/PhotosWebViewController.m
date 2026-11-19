// PhotosWebViewController.m
// Photos — Academy Build
// Detroit Automation Academy. Academy-original code; no Google code or assets.

#import "PhotosWebViewController.h"

// Desktop Safari user agent (Safari 13.1, macOS 10.13.6) so the Google
// Photos web app serves its full desktop interface.
static NSString * const kPhotosDesktopUserAgent =
    @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/605.1.15 "
     "(KHTML, like Gecko) Version/13.1 Safari/605.1.15";

static NSString * const kPhotosHomeURLString = @"https://photos.google.com";

@interface PhotosWebViewController ()

@property (nonatomic, retain) WKWebView *webView;

@end

@implementation PhotosWebViewController

@synthesize webView = _webView;

- (void)dealloc {
    [_webView release];
    [super dealloc];
}

- (void)loadView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // Persistent default data store: cookies and site data survive
    // relaunches, so the Google session is kept.
    [configuration setWebsiteDataStore:[WKWebsiteDataStore defaultDataStore]];

    WKWebView *webView = [[WKWebView alloc] initWithFrame:NSZeroRect configuration:configuration];
    [configuration release];
    [webView setCustomUserAgent:kPhotosDesktopUserAgent];
    [webView setNavigationDelegate:self];
    [webView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];

    [self setWebView:webView];
    [self setView:webView];
    [webView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:kPhotosHomeURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[self webView] loadRequest:request];
}

- (void)reloadPage {
    if ([[self webView] URL] == nil) {
        [self viewDidLoad];
    } else {
        [[self webView] reload];
    }
}

#pragma mark - WKNavigationDelegate

// Hosts that stay inside the web view: the Photos app itself and the
// Google sign-in flow. Every other host opens in the default browser.
- (BOOL)hostStaysInWebView:(NSString *)host {
    if (host == nil) {
        return YES;
    }
    NSString *lowercaseHost = [host lowercaseString];
    return [lowercaseHost isEqualToString:@"google.com"] ||
           [lowercaseHost hasSuffix:@".google.com"];
}

- (void)webView:(WKWebView *)webView
    decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
                    decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = [[navigationAction request] URL];

    // New-window requests (target="_blank" and similar) have no target
    // frame. Google hosts load in this web view; other hosts go to the
    // default browser. Either way the policy is Cancel so WebKit does
    // not also try to load the request in a frame that does not exist.
    if ([navigationAction targetFrame] == nil) {
        if ([self hostStaysInWebView:[url host]]) {
            [webView loadRequest:[navigationAction request]];
        } else if (url != nil) {
            [[NSWorkspace sharedWorkspace] openURL:url];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }

    if ([self hostStaysInWebView:[url host]]) {
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        if (url != nil) {
            [[NSWorkspace sharedWorkspace] openURL:url];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

@end
