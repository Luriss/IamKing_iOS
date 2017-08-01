//
//  UIImage+GetImage.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "UIImage+GetImage.h"
#import <Accelerate/Accelerate.h>

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
    
    CGImageRef imageRef = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    
//    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
#else
    
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
    
#endif
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, ceilf(4 * size.width), colorSpace, 1);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), imageRef);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *reImage = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return reImage;
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


+ (UIImage *)getImageApplyingAlpha:(CGFloat )alpha  imageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIImage *newImage = [[self class] imageByApplyingAlpha:alpha image:image];
    
    return newImage;
}

//- (UIImage *)blurImageWithCoreImage:(UIImage *)image
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        CIContext *context = [CIContext contextWithOptions:nil];
//        CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
//        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//        [filter setValue:ciImage forKey:kCIInputImageKey];
//        //设置模糊程度
//        [filter setValue:@30.0f forKey: @"inputRadius"];
//        CIImage *result = [filter valueForKey:kCIOutputImageKey];
//        CGRect frame = [ciImage extent];
//        NSLog(@"%f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
//        CGImageRef outImage = [context createCGImage: result fromRect:ciImage.extent];
//        UIImage * blurImage = [UIImage imageWithCGImage:outImage];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            coreImgv.image = blurImage;
//        });
//    });
//    
//}


+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (image==nil)
    {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片");
        
        return nil;
        
    }
    
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
//    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
//    vImage_Buffer outBuffer2;
//    outBuffer2.data = pixelBuffer2;
//    outBuffer2.width = CGImageGetWidth(img);
//    outBuffer2.height = CGImageGetHeight(img);
//    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
//    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    //CGColorSpaceRelease(colorSpace);   //多余的释放
    CGImageRelease(imageRef);
    
    return returnImage;
}


/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}



@end
