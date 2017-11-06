//
//  CustomNavigationBar.h
//  CustomNavigationControllerStudy
//
//  Created by WuShiHai on 12/1/15.
//  Copyright © 2015 WuShiHai. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomNavigationBarDelegate <NSObject>

- (void)didCustomNavigationBarBackAction;

@end

/**
 *  暂不支持横屏
 */
@interface CustomNavigationBar : UIView

@property (nonatomic ,weak) id<CustomNavigationBarDelegate> delegate;

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
/**
 *  default e2e2e2
 */
@property (nonatomic, strong) UIColor *bottomLineColor;

//默认初始化函数
- (instancetype)init;

- (void)setRightViews:(NSArray *)views;
- (void)setLeftViews:(NSArray *)views;
- (void)setTitle:(NSString *)title;
/**
 * 返回按钮带文字 未做间距处理
 */
- (void)addDefaultLeftBackButton;
- (void)removeDefaultLeftBackButton;
- (UIButton *)addRightButton:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:(SEL)selector;
- (UIButton *)addLeftButton:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:(SEL)selector;
- (UIButton *)addButton:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:(SEL)selector isLeft:(BOOL)isLeft;

@end
