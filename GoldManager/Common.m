//
//  Common.m
//  HealthCloud
//
//  Created by lihaibo on 15/10/26.
//  Copyright © 2015年 bomei. All rights reserved.
//

#import "Common.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>
#import "Constants.h"

#define  DEVICE_UUID @"DEVICE_UUID"
#define  USER_UNREADMSG_SAVE_KEY @"USER_UNREADMSG_SAVE_KEY"
@implementation Common

//获取当前手机分辨率
+ (ResolutionType) getResolutionType{
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    //6p
    if(size_screen.height==736.000000){
        return resolution4;
    }else if(size_screen.height==667.000000)//6
    {
        return resolution3;
    }else if(size_screen.height==568.000000){//5,5s
        return resolution2;
    }else if(size_screen.height==480.000000){//4s
        return resolution1;
    }else{
        return resolution3;
    }
}

+ (NSString *)getUUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    NSString *uuid = (__bridge NSString *)newUniqueIdString;
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    
    return uuid;
}

/**
 *检查是否存储唯一ID，首次登录没有存储生成一个，带着这个ID去服务端检查
 */
+(NSString *) genAndGetAppId
{

    NSString *deviceID= [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICE_UUID"];
    if([deviceID isEqualToString:@""]||IsNilOrNull(deviceID))
    {
        CFUUIDRef uuid_ref=CFUUIDCreate(nil);
        CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
        CFRelease(uuid_ref);
        NSString *uuid= (__bridge NSString *)uuid_string_ref;
        CFRelease(uuid_string_ref);
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:DEVICE_UUID];
        deviceID= [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICE_UUID"];
    }
    return deviceID;
}

+ (NSString *)getVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAlias:(NSString *) phone{
    return phone;
}

+ (NSString *)manufactureString:(NSString *)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)removeWhiteSpaceCharactersAtEnd:(NSString *)string
{
	if (IsStrEmpty(string)) {
		return nil;
	}else{
		NSUInteger count = [string length] - 1;
		for (; count >0; count--) {
			if ([string characterAtIndex:count] != ' ') {
				break;
			}
		}
		NSString *str = [string substringToIndex:count+1];
		return str;
	}
}

+ (NSString *)removeWhiteSpaceCharactersAtBeginning:(NSString *)string
{
	if (IsStrEmpty(string)) {
		return nil;
	}else{
		NSUInteger count = 0;
		for (;; count++)
		{
			if (count <string.length) {
				if ([string characterAtIndex:count] != ' ') {
					break;
				}
			}else{
				break;
			}
		}
		NSString *str = [string substringFromIndex:count];
		return str;
	}
}
+ (CGFloat)caculateWidth:(NSString *)text size:(UIFont *)font height:(CGFloat)height{
    CGSize textBlockMinSize = {CGFLOAT_MAX, height};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    
    size = [text boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                           attributes:@{
                                        NSFontAttributeName:font
                                        }
                              context:nil].size;
    
    return  size.width;
}

#pragma mark -
+ (CGFloat)caculateHeight:(NSString *)text size:(UIFont *)font width:(CGFloat)width
{
    
    CGSize textBlockMinSize = {width, CGFLOAT_MAX};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
  
    size = [text boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                         attributes:@{
                                                      NSFontAttributeName:font
                                                      }
                                            context:nil].size;

    return  size.height;
}

#pragma mark - 
//画线
+ (UIImageView *)drawLineImage:(CGRect)rect isHorizontal:(BOOL)isHorizontal lineWidth:(CGFloat)width red:(float)red green:(float)green blue:(float)blue{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), width);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, 0);
    if (isHorizontal) {
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), imageView.frame.size.width, 0);
    }else{
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, imageView.frame.size.height);
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageView;
}

#pragma mark - 硬件版本
+ (NSString *)platform
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return platform;
}

+ (NSString *)platformString
{
    NSString *platform = [self platform];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        deviceNamesByCode = @{@"iPod1,1"     :@"iPod_Touch1",
                              @"iPod2,1"     :@"iPod_Touch2",
                              @"iPod3,1"     :@"iPod_Touch3",
                              @"iPod4,1"     :@"iPod_Touch4",
                              @"iPod5,1"     :@"iPod_Touch5",
                              @"iPad1,1"     :@"iPad1",
                              @"iPad2,1"     :@"iPad2",
                              @"iPad2,2"     :@"iPad2",
                              @"iPad2,3"     :@"iPad2",
                              @"iPad2,4"     :@"iPad2",
                              @"iPad2,5"     :@"iPad_mini",
                              @"iPad2,6"     :@"iPad_mini",
                              @"iPad2,7"     :@"iPad_mini",
                              @"iPad3,1"     :@"iPad3",
                              @"iPad3,2"     :@"iPad3",
                              @"iPad3,3"     :@"iPad3",
                              @"iPad3,4"     :@"iPad4",
                              @"iPad3,5"     :@"iPad4",
                              @"iPad3,6"     :@"iPad4",
                              @"iPad4,1"     :@"iPad_Air",
                              @"iPad4,2"     :@"iPad_Air",
                              @"iPad4,3"     :@"iPad_Air",
                              @"iPad4,4"     :@"iPad_mini",
                              @"iPad4,5"     :@"iPad_mini",
                              @"iPad4,6"     :@"iPad_mini",
                              @"iPhone1,1"   :@"iPhone1G_GSM",
                              @"iPhone1,2"   :@"iPhone3G_GSM",
                              @"iPhone2,1"   :@"iPhone3GS_GSM",
                              @"iPhone3,1"   :@"iPhone4_GSM",
                              @"iPhone3,3"   :@"iPhone4_CDMA",
                              @"iPhone4,1"   :@"iPhone4S",
                              @"iPhone5,1"   :@"iPhone5",
                              @"iPhone5,2"   :@"iPhone5",
                              @"iPhone5,3"   :@"iPhone5C",
                              @"iPhone5,4"   :@"iPhone5C",
                              @"iPhone6,1"   :@"iPhone5S",
                              @"iPhone6,2"   :@"iPhone5S",
                              @"i386"        :@"iPhone_Simulator",
                              @"x86_64"      :@"iPhone_Simulator",
                              @"iPhone7,1"   :@"iPhone6_Plus",
                              @"iPhone7,2"   :@"iPhone6",
                              @"iPhone8,1"   :@"iPhone6S",
                              @"iPhone8,2"   :@"iPhone6S_Plus"
                              };
    }
    
    NSString *unknownPlatform = platform;
    
    if (platform)
    {
        platform = [deviceNamesByCode objectForKey:platform];
    }
    if ([platform length] == 0)
    {
        platform = unknownPlatform;
    }
    return platform;
}

//银行理财金额千位分割
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString

{
    digitString = [digitString substringToIndex:digitString.length-3];
    //不需要千位符分割
    if (digitString.length <= 3) {
        return  [NSString stringWithFormat:@"%@.00元",digitString];
    } else {
        NSMutableString *processString = [NSMutableString stringWithString:digitString];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0)
            {
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray)
        {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count )
            {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--)
        {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        NSString * soltStr = [NSString stringWithFormat:@"%@.00元",resultString];
        return soltStr;
    }
}

//贵金属千位分割
+ (NSString *)separatedDigitStringWithStrMetal:(NSString *)digitString
{
    //后台提供数据格式为无 .00 BigDecimal时处理
    if(digitString.length <=3)
    {
        digitString = [digitString stringByAppendingString:@".00"];
    }
    NSString * lastStr = [digitString substringFromIndex:digitString.length-3];
    digitString = [digitString substringToIndex:digitString.length-3];
    if (digitString.length <= 3) {
        return [NSString stringWithFormat:@"%@%@",digitString,lastStr];
    } else {
        NSMutableString *processString = [NSMutableString stringWithString:digitString];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0)
            {
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray)
        {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count )
            {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--)
        {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        NSString * soltStr = [NSString stringWithFormat:@"%@%@",resultString,lastStr];
        return soltStr;
    }
}
/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* comp = [calendar components:NSCalendarUnitDay
                                         fromDate:fromDate
                                           toDate:toDate
                                          options:NSCalendarWrapComponents];
    return comp.day;
}
+(UIImage *)imageWithColor:(UIColor*)color andSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [color set];
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)getFirstImageFromVideoToLocal:(NSString *)localVideoName width:(CGFloat)width height:(CGFloat)height{
    return nil;
}
+(NSString *)getLocalMsgIdKey
{
    return USER_UNREADMSG_SAVE_KEY;
}
+(NSInteger) numOfMemberOfString:(NSString *)sourceStr member:(NSString *)member
{
    NSInteger count=0;
    for(int i=0;i<sourceStr.length;i++)
    {
        if([member isEqualToString:[sourceStr substringWithRange:NSMakeRange(i, 1)]])
        {
            count++;
        }
    }
    return count;
}


@end
