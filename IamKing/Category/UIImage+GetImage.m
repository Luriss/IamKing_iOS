//
//  UIImage+GetImage.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "UIImage+GetImage.h"

@implementation UIImage (GetImage)

+ (UIImage *)getImageFromFileWithImageName:(NSString *)imageName
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resourcePath = [bundle resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}


+ (id)createRoundedRectImage:(UIImage*)image
                        size:(CGSize)size
                      radius:(NSInteger)radius
{
    
    size = CGSizeMake(size.width*2, size.height*2);
    radius = radius*2;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 4 * size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    
    fw = ceilf(CGRectGetWidth(rect) / ovalWidth);
    fh = ceilf(CGRectGetHeight(rect) / ovalHeight);
    
    //根据圆角路径绘制
    CGContextMoveToPoint(context, fw, fh/2);            // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);   // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);    // Back to lower right
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context,true);
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


//
- (void)lwb_roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque radius:(CGFloat)radius completion:(void (^)(UIImage *cornerImage))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 1. 利用绘图，建立上下文 BOOL选项为是否为不透明
        UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 2. 设置填充颜色
        if (opaque) {
            [fillColor setFill];
            UIRectFill(rect);
        }
        
        // 3. 利用 贝赛尔路径 `裁切 效果
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        
        [path addClip];
        
        // 4. 绘制图像
        if (self) {
            [self drawInRect:rect];
        }
        
        // 5. 取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        // 6. 关闭上下文
        UIGraphicsEndImageContext();
        
        // 7. 完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}


/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param size 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage *) GetImageWithColor:(UIColor*)color size:(CGSize )size
{
    //获得图形上下文
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(ctx, color.CGColor);
//    
//    CGContextFillRect(ctx,CGRectMake(0,0,size.width,size.height));
//    
//    CGRect rect = CGRectMake(0,0,size.width,size.height);
//    
//    CGContextAddEllipseInRect(ctx, rect);
//    
//    CGContextClip(ctx);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    IKLog(@"ddddd= %@",image);
//    [image drawInRect:rect];
//    
//    UIGraphicsEndImageContext();
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    addRoundedRectToPath(context, rect, 30, 30);
    CGContextFillRect(context, rect);
    
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
  
//    return ;
}


/**
 *  设置图片透明度
 * @param alpha 透明度
 * @param image 图片
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat )alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    
    CGContextSetAlpha(ctx, alpha);
    
    
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    
    UIGraphicsEndImageContext();
    
    
    
    return newImage;
    
}

@end
