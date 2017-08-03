//
//  IKGeneralMacro.h
//  IamKing
//
//  Created by Luris on 2017/7/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#ifndef IKGeneralMacro_h
#define IKGeneralMacro_h


/************************************Size********************************************/
#define IKSCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define IKSCREENH_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/************************************Size********************************************/


/***********************************Color********************************************/

//3.设置随机颜色
#define IKRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//4.设置RGB颜色/设置RGBA颜色
#define IKRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define IKRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

// rgb颜色转换（16进制->10进制）
#define IKColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IKGeneralBlue (IKColorFromRGB(0x40c4ff))
#define IKButtonClickColor (IKColorFromRGB(0x00aaee))
#define IKGeneralLightGray (IKColorFromRGB(0xf2f2f5))
#define IKGeneralWhite (IKColorFromRGB(0xffffff))
#define IKGeneralRed (IKColorFromRGB(0xff0000))

#define IKMainTitleColor   (IKColorFromRGB(0x707070))
#define IKSubHeadTitleColor   (IKColorFromRGB(0xaaaaaa))
#define IKPlaceHolderColor (IKColorFromRGB(0xbabac0))
#define IKSeachBarBgColor (IKColorFromRGB(0xeeeeee))

#define IKLineColor (IKColorFromRGB(0xf2f2f5))
#define IKDefaultAlpha (0.8f)

#define IKButtonClickBgImage ([UIImage GetImageWithColor:IKLineColor size:CGSizeMake(1, 1)])
#define IKButtonCkickBlueImage ([UIImage GetImageWithColor:IKButtonClickColor size:CGSizeMake(1, 1)])
/***********************************Color********************************************/


/***********************************Font********************************************/
#define IKMainTitleFont   (16.0f)
#define IKSubTitleFont   (13.0f)
/***********************************Font********************************************/

/***********************************Log**********************************************/

//5.自定义高效率的 NSLog
#ifdef DEBUG
#define IKLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define IKLog(...)

#endif
/***********************************Log**********************************************/

/***********************************Version******************************************/

//判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断是否为 iPhone 5SE
#define iPhone5SE ([[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f)

// 判断是否为iPhone 6/6s
#define iPhone6_6s ([[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f)

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6P_6sP ([[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f)

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/***********************************Version******************************************/

/***********************************Empty********************************************/

// 判断字符串是否为空
#define IKStringIsEmpty(str) (([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 )? YES:NO)

#define IKStringIsNotEmpty(str) (!IKStringIsEmpty(str))

// 判断数组是否为空
#define IKArrayIsEmpty(array) ((array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)? YES:NO)

#define IKArrayIsNotEmpty(array) (!IKArrayIsEmpty(array))


// 判断字典是否为空
#define IKDictIsEmpty(dic) ((dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)? YES:NO)

#define IKDictIsNotEmpty(dic) (!IKDictIsEmpty(dic))

/***********************************Empty********************************************/


/***********************************Method*******************************************/

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
//2.获取通知中心
#define IKNotificationCenter [NSNotificationCenter defaultCenter]
//NSUserDefaults 实例化
#define IKUSERDEFAULT [NSUserDefaults standardUserDefaults]
/***********************************Method*******************************************/


/***********************************AnimationTime**********************************/

#define IKLoadImageTime (0.1)



/***********************************AnimationTime**********************************/



#endif /* IKGeneralMacro_h */
