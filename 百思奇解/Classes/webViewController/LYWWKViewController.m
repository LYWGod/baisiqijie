//
//  LYWWKViewController.m
//  百思奇解
//
//  Created by Leo的Mac on 16/11/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWWKViewController.h"
#import <WebKit/WebKit.h>

@interface LYWWKViewController ()

/** webView */
@property (weak, nonatomic)WKWebView *webView;
/** progresslayer */
@property (weak, nonatomic)CALayer *progresslayer;

@end

@implementation LYWWKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = self.title;

    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    self.webView = webView;
    
    [webView addObserver:self forKeyPath:WkwebView options:NSKeyValueObservingOptionNew context:nil];
    UIView *progress = [[UIView alloc] initWithFrame:CGRectMake(0, 70, LYWKscreenWidth, 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:WkwebView]) {
        NSLog(@"%@", change);
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:WkwebView];
}



@end
