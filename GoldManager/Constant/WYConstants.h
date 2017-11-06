//
//
//  HealthCloud
//
//  Created by lihaibo on 15/10/26.
//  Copyright © 2015年 bomei. All rights reserved.
//

#ifndef RedSunPropertyService_WYConstant_h
#define RedSunPropertyService_WYConstant_h

//打印日志
#ifdef kSitTest
#define WYLog(...) NSLog(__VA_ARGS__)
#else
#ifdef kTestUse
#define WYLog(...) NSLog(__VA_ARGS__)
#else
#define WYLog(...)  NSLog(__VA_ARGS__)/* 临时打开*/
#endif
#endif

//计算高度
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define WY_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define WY_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

//以下通用Block
#define WYBlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil


#define WYScaleHorizontalWidth(__ref) [UIScreen scaleHorizontalWidth:__ref]

//初始高度
#define SCREENDEFAULTHEIGHT 64
#define SCREENRESULTHEIGHT  [[UIScreen mainScreen] bounds].size.height-64
//屏幕尺寸
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

//色彩
#define kColorRGB(r,g,b) [UIColor colorWithRed: (r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]


#endif
