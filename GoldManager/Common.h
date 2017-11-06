//
//  Common.h
//  HealthCloud
//
//  Created by lihaibo on 15/10/26.
//  Copyright © 2015年 bomei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSInteger,ResolutionType) {
    resolution1 = 1,//4s
    resolution2 = 2,// 5 , 5s
    resolution3 = 3,// 6
    resolution4 = 4 // 6p
};

@interface Common : NSObject

//获取当前手机分辨率
+ (ResolutionType) getResolutionType;

+ (NSString*)getUUID;
+ (NSString *)getVersion;
+ (NSString *) genAndGetAppId;

+ (NSString *)getAlias:(NSString *) phone;

//去掉字符串空格和回车
+ (NSString *)manufactureString:(NSString *)string;
//去掉尾部空格
+ (NSString *)removeWhiteSpaceCharactersAtEnd:(NSString *)string;
//去除头部空格
+ (NSString *)removeWhiteSpaceCharactersAtBeginning:(NSString *)string;

//
+ (CGFloat)caculateWidth:(NSString *)text size:(UIFont *)font height:(CGFloat)height;
+ (CGFloat)caculateHeight:(NSString *)text size:(UIFont *)font width:(CGFloat)width;
+ (UIImageView *)drawLineImage:(CGRect)rect isHorizontal:(BOOL)isHorizontal lineWidth:(CGFloat)width red:(float)red green:(float)green blue:(float)blue;

+ (NSString *)platform;
+ (NSString *)platformString;

+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;
+ (NSString *)separatedDigitStringWithStrMetal:(NSString *)digitString;
+ (NSInteger)numberOfDaysWithFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate;


//图片颜色
+(UIImage *)imageWithColor:(UIColor*)color andSize:(CGSize)size;
/**
 *  截取视频第一帧
 *
 *  @param localVideoName
 *  @param width
 *  @param height
 *
 *  @return
 */
+ (UIImage *)getFirstImageFromVideoToLocal:(NSString *)localVideoName width:(CGFloat)width height:(CGFloat)height;

/**
 获取本地保存维度消息的ID的数组的key

 @return <#return value description#>
 */
+(NSString *)getLocalMsgIdKey;

/**
 计算一段文本中某个元素的个数

 @param sourceStr 源文本
 @param member 元素
 @return 个数
 */
+(NSInteger) numOfMemberOfString:(NSString *)sourceStr member:(NSString *)member;


@end
