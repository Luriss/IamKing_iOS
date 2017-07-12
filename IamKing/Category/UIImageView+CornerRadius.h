//
//  UIImageView+CornerRadius.h
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)


/**
 给 ImageView 设置圆角,结合 SDWebImage,将下载好的图片绘制成圆角图片,再进行缓存

 @param urlStr 图片 url
 @param placeHolderStr 占位图
 @param radius 圆角系数
 
 */
- (void)lwb_loadImageWithUrl:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius;

@end
