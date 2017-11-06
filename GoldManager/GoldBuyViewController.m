//
//  GoldBuyViewController.m
//  GoldManager
//
//  Created by minchangfeng on 2017/6/30.
//  Copyright © 2017年 Gevent. All rights reserved.
//

#import "GoldBuyViewController.h"
#import "WYWebView.h"
#import "CustomNavigationBar.h"
#import "UINavigationController+FDFullscreenPopGesture.h"


//初始高度
#define SCREENDEFAULTHEIGHT 64
#define SCREENRESULTHEIGHT  [[UIScreen mainScreen] bounds].size.height-64
//屏幕尺寸
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

//色彩
#define kColorRGB(r,g,b) [UIColor colorWithRed: (r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]


@interface GoldBuyViewController()<CustomNavigationBarDelegate,UIWebViewDelegate>
@property(nonatomic,strong)WYWebView  *webView;
@property (nonatomic, strong) CustomNavigationBar *navigationBar;

@end

@implementation GoldBuyViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar addDefaultLeftBackButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navigationBar];
    self.navigationBar.titleLabel.text = @"黄金积存";
    _webView = [[WYWebView alloc] initWithFrame:CGRectMake(0, SCREENDEFAULTHEIGHT, SCREENWIDTH, SCREENHEIGHT)];
    [_webView setScalesPageToFit:YES];
    [self.view addSubview:_webView];
    
    [self loadWebView:_webView];
    
}
- (CustomNavigationBar *)navigationBar{
    if (_navigationBar == nil) {
        _navigationBar = [[CustomNavigationBar alloc] init];
        _navigationBar.delegate = self;
        [_navigationBar setBackgroundColor:[UIColor whiteColor]];
    }
    return _navigationBar;
}
-(void)didCustomNavigationBarBackAction
{
    if([_webView canGoBack])
    {
        [_webView goBack];
    }
    
}
/**
 webView开始加载开始loading
 
 */
- (void)webViewDidStartLoad:(WYWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    
}
-(void)loadWebView:(UIWebView *)webView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.11.117:8080/golddemo/demo/api/initBuyGold.do"]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.11.181:9080/golddemo"]];
    
    [webView loadRequest:request];

}
-(void)didReceiveMemoryWarning
{
     [super didReceiveMemoryWarning];
}

@end
