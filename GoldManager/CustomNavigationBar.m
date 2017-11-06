//
//  CustomNavigationBar.m
//  CustomNavigationControllerStudy
//
//  Created by WuShiHai on 12/1/15.
//  Copyright © 2015 WuShiHai. All rights reserved.
//

#import "CustomNavigationBar.h"

const CGFloat CustomNavigationBarStatusBarDefaultHeight = 20;
const CGFloat CustomNavigationBarDefaultHeight = 44 + CustomNavigationBarStatusBarDefaultHeight;

const CGFloat CustomNavigationBarViewsDefaultWidth = 60;
const CGFloat CustomNavigationBarButtonDefaultWidth = 45;
const CGFloat CustomNavigationBarViewsDefaultPadding = 5;
const CGFloat CustomNavigationBarViewsDefaultMargin = 5;

@interface CustomNavigationBar()

@property (nonatomic, strong) NSArray *leftViews;
@property (nonatomic, strong) NSArray *rightViews;
@property (nonatomic, strong) NSString *title;


@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *titleLabel;

/** 判断是否在当前配置下已经计算过布局*/
@property (nonatomic, assign) BOOL didLayoutSubviews;

@end

@implementation CustomNavigationBar

#pragma mark - mark Override
- (instancetype)init{
    if (self = [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CustomNavigationBarDefaultHeight)]) {
        self.layer.borderColor=[UIColor clearColor].CGColor;
        self.layer.borderWidth=1.0f;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self configureSubviews];
}
#pragma mark - LayoutSubviews
- (void)configureSubviews{
    //当前View还没有加载到父View，或者已经布局过的 不需要重新布局
    if (self.superview == nil || self.didLayoutSubviews == YES){
        return;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //底部线颜色与位置
    CGFloat lineHeight = 0.5;
    self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.frame) - lineHeight, CGRectGetWidth(self.frame), lineHeight);
    self.bottomLine.backgroundColor = self.bottomLineColor?:[UIColor colorWithRed:0xe2/255. green:0xe2/255. blue:0xe2/255. alpha:1.0];
    
    //布局计算
    /**
     *  先布局title，然后左边第一个 ，然后右边第一个，然后左边第二个，右边第二个...
     */
    CGFloat limitWidthNumber = MIN(1, self.leftViews.count + self.rightViews.count) * 2;
    UIView *titleView = [self realTitleView];

    CGFloat width = CGRectGetWidth(self.frame);
    
    if (limitWidthNumber > 0) {
        //先布局titleView
        if (titleView == self.titleLabel) {
            [self.titleLabel sizeToFit];
        }
        //titleView 最多让一个位置，否则titleView 优先
        CGFloat limitWidthNumber = MIN(1, self.leftViews.count + self.rightViews.count) * 2;
        CGFloat titleViewMaxWidth = width - limitWidthNumber * (CustomNavigationBarViewsDefaultWidth + CustomNavigationBarViewsDefaultPadding + CustomNavigationBarViewsDefaultMargin);
        CGFloat titleViewWidth = MIN(titleViewMaxWidth, CGRectGetWidth(titleView.frame));
        if (CGRectGetWidth(titleView.frame) > 0 ) {
            CGFloat titleViewHeight = CGRectGetHeight(titleView.frame) > 0 ? CGRectGetHeight(titleView.frame):(CustomNavigationBarDefaultHeight - CustomNavigationBarStatusBarDefaultHeight);
            titleView.frame = CGRectMake(width/2 - titleViewWidth/2, CustomNavigationBarStatusBarDefaultHeight/2 + CustomNavigationBarDefaultHeight/2 - titleViewHeight/2, titleViewWidth, titleViewHeight);
            [self addSubview:titleView];
        }
        
        [self layoutSubviews:self.leftViews isLeft:YES];
        [self layoutSubviews:self.rightViews isLeft:NO];
        
    }else{
        //左右都没有视图，只有title的时候
        if (CGRectGetWidth(titleView.frame) <= 0 || CGRectGetWidth(titleView.frame) > CGRectGetWidth(self.frame)) {
            titleView.frame = CGRectMake(0, CustomNavigationBarStatusBarDefaultHeight, CGRectGetWidth(self.frame), CustomNavigationBarDefaultHeight - CustomNavigationBarStatusBarDefaultHeight);
        }
        [self addSubview:titleView];
    }
    
    //线始终放在最上面
    [self addSubview:self.bottomLine];
    
    self.didLayoutSubviews = YES;
}
- (void)layoutSubviews:(NSArray *)views isLeft:(BOOL)isLeft{
    //前提 titleView已经计算完
    UIView *titleView = [self realTitleView];
    CGFloat titleViewMinX = (self.titleView || self.title)?CGRectGetMinX(titleView.frame):CGRectGetMidX(self.frame);
    CGFloat titleViewMaxX = (self.titleView || self.title)?CGRectGetMaxX(titleView.frame):CGRectGetMidX(self.frame);
    CGFloat minPointX = isLeft ? CustomNavigationBarViewsDefaultMargin : titleViewMaxX + CustomNavigationBarViewsDefaultPadding;
    CGFloat maxPointX = isLeft ? titleViewMinX - CustomNavigationBarViewsDefaultPadding : CGRectGetWidth(self.frame) - CustomNavigationBarViewsDefaultMargin;
    __block CGFloat lastViewMaxPoiontX = isLeft? minPointX:maxPointX;
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        //ok
        if (isLeft) {
            if (lastViewMaxPoiontX + CGRectGetWidth(view.frame) + CustomNavigationBarViewsDefaultPadding < maxPointX) {
                view.frame = CGRectMake(0, CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
                lastViewMaxPoiontX += (CGRectGetWidth(view.frame) + CustomNavigationBarViewsDefaultPadding);
            }else{
                //说明空间不够下次布局了，而且这次布局要压缩
                view.frame = CGRectMake(lastViewMaxPoiontX, CGRectGetMinY(view.frame), maxPointX - lastViewMaxPoiontX - CustomNavigationBarViewsDefaultPadding, CGRectGetHeight(view.frame));
                *stop = YES;
            }
        }else{
            if (lastViewMaxPoiontX - CGRectGetWidth(view.frame) - CustomNavigationBarViewsDefaultPadding > minPointX) {
                view.frame = CGRectMake(lastViewMaxPoiontX+10 -  CGRectGetWidth(view.frame), CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
                lastViewMaxPoiontX -= (CGRectGetWidth(view.frame) + CustomNavigationBarViewsDefaultPadding);
            }else{
                //说明空间不够下次布局了，而且这次布局要压缩
                view.frame = CGRectMake(minPointX, CGRectGetMinY(view.frame), lastViewMaxPoiontX - minPointX ,CGRectGetHeight(view.frame));
                *stop = YES;
            }
        }
        [self addSubview:view];
    }];
}
- (void)resetLayoutSubviewsFlagThenConfigure{
    self.didLayoutSubviews = NO;
    [self configureSubviews];
}
- (UIView *)realTitleView{
    return self.titleView?:self.titleLabel;
}
#pragma mark - Setter Methods
- (void)setRightViews:(NSArray *)views{
    _rightViews = views;
    [self resetLayoutSubviewsFlagThenConfigure];
}
- (void)setLeftViews:(NSArray *)views{
    //说明要有返回按钮，不能直接替换
    if (self.backButton && [views containsObject:self.backButton] == NO) {
        NSMutableArray *mutableArray = [(views?:@[]) mutableCopy];
        [mutableArray addObject:self.backButton];
        _leftViews = mutableArray;
    }else{
        _leftViews = views;
    }
    [self resetLayoutSubviewsFlagThenConfigure];
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    [self resetLayoutSubviewsFlagThenConfigure];
}
- (void)setTitleView:(UIView *)titleView{
    _titleView = titleView;
    [self resetLayoutSubviewsFlagThenConfigure];
}
#pragma mark - Action
- (void)backAction:(id)sender{
    if ([_delegate respondsToSelector:@selector(didCustomNavigationBarBackAction)]) {
        [_delegate didCustomNavigationBarBackAction];
    }
}
#pragma mark - Public
- (void)addDefaultLeftBackButton{
    if (self.backButton == nil) {
        self.backButton = [self addButton:nil imageName:@"navigationBarBack" target:self selector:@selector(backAction:) isLeft:YES];
        [self resetLayoutSubviewsFlagThenConfigure];
    }
}
- (void)removeDefaultLeftBackButton{
    if (self.backButton != nil) {
        self.backButton.hidden = YES;
        [self resetLayoutSubviewsFlagThenConfigure];
    }
}
- (UIButton *)addRightButton:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:(SEL)selector{
    return [self addButton:title imageName:imageName target:target selector:selector isLeft:NO];
}
- (UIButton *)addLeftButton:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:(SEL)selector{
    return [self addButton:title imageName:imageName target:target selector:selector isLeft:YES];
}
- (UIButton *)addButton:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:(SEL)selector isLeft:(BOOL)isLeft{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, CustomNavigationBarStatusBarDefaultHeight, CustomNavigationBarViewsDefaultWidth, CustomNavigationBarDefaultHeight - CustomNavigationBarStatusBarDefaultHeight)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (title) {
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:RGB(252, 101, 0) forState:UIControlStateNormal];
    }else{
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(0, CustomNavigationBarStatusBarDefaultHeight, CustomNavigationBarButtonDefaultWidth, CustomNavigationBarDefaultHeight - CustomNavigationBarStatusBarDefaultHeight);
    }
    
    if (isLeft) {
        NSMutableArray *mutableArray = [(self.leftViews?:@[]) mutableCopy];
        [mutableArray addObject:button];
        self.leftViews = mutableArray;
    }else{
        NSMutableArray *mutableArray = [(self.rightViews?:@[]) mutableCopy];
        [mutableArray addObject:button];
        self.rightViews = mutableArray;
    }
    return button;
}

#pragma mark - Init
- (UIView *)bottomLine{
    if (_bottomLine){
        return _bottomLine;
    }
    
    _bottomLine = [[UIView alloc] init];
    
    return _bottomLine;
}
- (UILabel *)titleLabel{
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor=RGB(50, 50, 50);
    return _titleLabel;
}

@end
