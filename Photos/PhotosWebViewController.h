// PhotosWebViewController.h
// Photos — Academy Build
// Detroit Automation Academy. Academy-original code; no Google code or assets.

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface PhotosWebViewController : NSViewController <WKNavigationDelegate>

@property (nonatomic, retain, readonly) WKWebView *webView;

- (void)reloadPage;

@end
