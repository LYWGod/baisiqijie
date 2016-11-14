//
//  LYWWebViewController.m
//  百思奇解
//
//  Created by LYW on 2016/10/29.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWWebViewController.h"

@interface LYWWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forWard;

@end

@implementation LYWWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = self.title;
    
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:requst];
}



- (IBAction)backBarButtonItem:(id)sender
{
    [self.webView goBack];
}

- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}

- (IBAction)forwardBarButtonItem:(id)sender
{
    [self.webView goForward];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.back.enabled = webView.canGoBack;
    self.forWard.enabled = webView.canGoForward;
}











@end
