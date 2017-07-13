//
//  UIImage+GetImage.h
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GetImage)

+ (UIImage *)getImageFromFileWithImageName:(NSString *)imageName;



/**
 设置圆角

 @param image 图片
 @param size 尺寸
 @param radius 圆角系数
 @return id
 
 */
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)radius;


/**
 给矩形设置圆角 (消耗内存严重)

 @param size 尺寸
 @param fillColor 填充色
 @param opaque 透明度
 @param radius 圆角系数
 @param completion  block 回调
 
 */
//- (void)lwb_roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque radius:(CGFloat)radius completion:(void (^)(UIImage *cornerImage))completion;

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;


@end
