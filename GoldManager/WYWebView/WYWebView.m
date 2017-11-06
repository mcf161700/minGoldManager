//
//  WYWebView.m
//  RedSunProperty
//
//  Created by WuShiHai'sMac on 8/5/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import "WYWebView.h"

NSString *const WYRefreshKeyPathContentOffsetContext = @"WYRefreshKeyPathContentOffsetContext";

@interface WYWebView ()

@property (nonatomic, assign) CGSize lastContentSize;
@property (nonatomic, assign) long long lastResopnseDelegateTime;

@end

@implementation WYWebView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addObservers];
    }
    return self;
}

- (void)addObservers{
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void *)(WYRefreshKeyPathContentOffsetContext)];
}
- (void)removeObservers{

    [self.scrollView removeObserver:self forKeyPath:@"contentSize" context:(__bridge void *)(WYRefreshKeyPathContentOffsetContext)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    NSLog(@"fasnfasnfansf,ansf:%.f",self.scrollView.contentSize.height);
//    if (CGSizeEqualToSize(self.lastContentSize, self.scrollView.contentSize)) {
//        return;
//    }
//    
////    NSLog(@"asdfasfd%.f",self.scrollView.contentSize.height);
//    
//    long long time = [NSDate date].timeIntervalSince1970 * 1000;
//    if (time - self.lastResopnseDelegateTime <= 500) {
//        [self performSelector:@selector(appendChangeSize) withObject:nil afterDelay:0.5];
//        return;
//    }
//    self.lastResopnseDelegateTime = time;
//    
//    self.lastContentSize = self.scrollView.contentSize;

    if ([_wy_delegate respondsToSelector:@selector(webViewDidContentSizeChange:)]) {
        [_wy_delegate webViewDidContentSizeChange:self];
    }
}

- (void)appendChangeSize{
    
    long long time = [NSDate date].timeIntervalSince1970 * 1000;
    //说明有遗漏通知的
    if (self.lastResopnseDelegateTime < time) {
        self.lastResopnseDelegateTime = time;
        if ([_wy_delegate respondsToSelector:@selector(webViewDidContentSizeChange:)]) {
            [_wy_delegate webViewDidContentSizeChange:self];
        }
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc{
    [self removeObservers];
}


@end
