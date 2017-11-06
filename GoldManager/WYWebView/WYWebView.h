//
//  WYWebView.h
//  RedSunProperty
//
//  Created by WuShiHai'sMac on 8/5/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYWebView;
@protocol WYWebViewProtocol <NSObject>

@optional
- (void)webViewDidContentSizeChange:(WYWebView *)webView;

@end

//解决加载完成后contentSize不对问题,采用KVO
@interface WYWebView : UIWebView

@property (nonatomic, weak) id<WYWebViewProtocol> wy_delegate;

@end
