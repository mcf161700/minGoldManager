//
//  Constants.h
//  HealthCloud
//
//  Created by lihaibo on 15/10/26.
//  Copyright © 2015年 bomei. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import "Common.h"
//#import "SwitchForProduct.h"

#define OBJC_CLASS(_ref) NSClassFromString(NSStringFromClass(_ref))

//app
#define MainBundle()                                ([NSBundle mainBundle])
#define PathForBundleResource(resName, resType)     [MainBundle() pathForResource:(resName) ofType:(resType)]
#define URLForBundleResource(resName, resType)      [MainBundle() URLForResource:(resName) \
withExtension:(resType)]
#define APPDisplayName()                            [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define AppBundleIdentifier()                       [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define AppReleaseVersionNumber()                   [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define AppBuildVersionNumber()                     [MainBundle() objectForInfoDictionaryKey:@"CFBundleVersion"]
//
#define shareViewHeight 200
//判断系统
#define IsIOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0 &&[[[UIDevice currentDevice] systemVersion] floatValue] <7.0) ? YES : NO)
#define IsIOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 &&[[[UIDevice currentDevice] systemVersion] floatValue] <8.0) ? YES : NO)
#define IsIOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 &&[[[UIDevice currentDevice] systemVersion] floatValue] <9.0) ? YES : NO)

#define IOS8_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
//环信颜色
#define TEXT_COLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
//判断是否是6P
#define IsIphone6Plus  ([[Common platformString] isEqualToString:@"iPhone6_Plus"]||[[Common platformString] isEqualToString:@"iPhone6_PlusS"])

#define IsIphone6  ([[Common platformString] isEqualToString:@"iPhone6"]||[[Common platformString] isEqualToString:@"iPhone6S"])

#define IsIphone5s  ([[Common platformString] isEqualToString:@"iPhone5S"])

#define iPhone5C    ([[Common platformString] isEqualToString:@"iPhone5C"])

#define iPhone4S    ([[Common platformString] isEqualToString:@"iPhone4S"]||[[Common platformString] isEqualToString:@"iPhone5"])

#define IsIphone6Or6P  ([[Common platformString] isEqualToString:@"iPhone6"] || [[Common platformString] isEqualToString:@"iPhone6_Plus"])

#define Not6PParse(_ref)  [Common parseWhenNot6P:_ref]
//断言加返回
#define SitAbort       HCAbort();return;
#define SitAbortNil    HCAbort();return nil;
//打印相关
#define MOCLogDebug(_ref)  NSLog(@"%@ %@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd),_ref);

//主题色
#define COMMON_COLOR [UIColor colorWithRed:37/255.0 green:193/255.0 blue:206/255.0 alpha:1.0]
//#define NAVIGATION_BAR_ITEMS_COLOR [UIColor colorWithRed:68/255.0f green:184/255.0f blue:159/255.0f alpha:1.0]

//定义keyWindow宏
#define KEYWINDOWS [UIApplication sharedApplication].keyWindow

//定义rootViewController宏
#define ROOTVIEWCONTROLLER [UIApplication sharedApplication].keyWindow.rootViewController

//定义最顶层的DISPLAYVIEWCONTROLLER，如果是present出来的Viewcontroller，windows栈中展示给用户看的rootviewcontroller
#define DISPLAYVIEWCONTROLLER ((UIWindow *)[[UIApplication sharedApplication].windows lastObject]).rootViewController


//计算颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//Use HEX color value with 0x000000 format
#define RGBColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#ifndef judgeEmpty
#define judgeEmpty
///是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
///字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//NSString为空返回
#define StrEmptyReturn(_ref,_message)    if(((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""])) {[self alertMessage:_message];return;}

//组装String
#define MontageStr(_a,_b)  [NSString stringWithFormat:@"%@/%@",_a,_b]

///数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#define	__STRINGNOTNIL( __x )   (__x?__x:@"")

#endif

///线程执行方法 GCD
#define PERFORMSEL_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define PERFORMSEL_SYNC_BACK(block) dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define PERFORMSEL_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//图片
#define BundleImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]


//CoreData
#define main_managed_object_context [NSManagedObjectContext MR_defaultContext]
#define main_managed_object_context_save() [main_managed_object_context MR_saveToPersistentStoreAndWait]
#define non_main_managed_object_context_save(context)  [context MR_saveToPersistentStoreAndWait]

#define DEVICE_TOKEN @"DEVICE_TOKEN"

typedef void (^VoidBlock) (void);

static inline void  mainBlock(VoidBlock block){
    
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        block();
    });
    
}

//异步操作
static inline void  asynchronousBlock(VoidBlock block){
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        block();
    });
}


#endif /* Constants_h */
