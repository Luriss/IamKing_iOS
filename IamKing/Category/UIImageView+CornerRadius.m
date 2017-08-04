//
//  UIImageView+CornerRadius.m
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UIImageView+CornerRadius.h"
#import <objc/runtime.h>
#import "SDImageCache.h"

const char kProcessedImage;

@interface UIImageView ()

@property (assign, nonatomic) CGFloat zyRadius;
@property (assign, nonatomic) UIRectCorner roundingCorners;
@property (assign, nonatomic) CGFloat zyBorderWidth;
@property (strong, nonatomic) UIColor *zyBorderColor;
@property (assign, nonatomic) BOOL zyHadAddObserver;
@property (assign, nonatomic) BOOL zyIsRounding;

@end





@implementation UIImageView (CornerRadius)


- (void)lwb_loadImageWithUrl:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius {

    
    NSURL *url;
    if (placeHolderStr == nil) {
        placeHolderStr = @"";
    }
    
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    
    url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheurlStr];
            
            
            // 从缓存中取出该图片,缓存的图片已做过圆角处理
            if (cacheImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadImageWithAnimation:cacheImage];
                });
            }
            else {
                // 缓存中没有,调用 SD 下载
                [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (!error) {
                        
                        
                        [image lwb_roundRectImageWithSize:self.frame.size  fillColor:nil opaque:NO radius:radius completion:^(UIImage *cornerImage) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self loadImageWithAnimation:cornerImage];
                            });
                            //清除原有非圆角图片缓存
                            [[SDImageCache sharedImageCache] removeImageForKey:urlStr withCompletion:^{
                            }];
                            
                            // 保存设置后的圆角图片
                            [[SDImageCache sharedImageCache] storeImage:cornerImage forKey:cacheurlStr completion:^{
                                
                            }];
                        }];//createRoundedRectImage:image size:radius:radius];
                    }
                }];
            }
        });
    }
    else {
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:nil];
    }
}


- (void)lwb_blurImage:(UIImage *)image completed:(void (^)(UIImage *image))completed
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        //设置模糊程度
        [filter setValue:@30.0f forKey: @"inputRadius"];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect frame = [ciImage extent];
        NSLog(@"%f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
        CGImageRef outImage = [context createCGImage: result fromRect:ciImage.extent];
        UIImage * blurImage = [UIImage imageWithCGImage:outImage];
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.image = blurImage;
            
        });
    });
}

- (void)lwb_loadBlurImageWithUrl:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr blur:(CGFloat)blur completed:(void (^)(UIImage *image))completed
{
    NSURL *url;
    
    UIImage *placeImage = nil;
    if (placeHolderStr) {
        placeImage = [UIImage imageNamed:placeHolderStr];
    }
    
    url = [NSURL URLWithString:urlStr];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheurlStr];
        
        // 从缓存中取出该图片,缓存的图片已做过圆角处理
        if (cacheImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self setImage:cacheImage];
                if (completed) {
                    completed(cacheImage);
                }
            });
        }
        else {
            // 缓存中没有,调用 SD 下载
            [self sd_setImageWithURL:url placeholderImage:placeImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    UIImage *blurImage = [UIImage boxblurImage:image withBlurNumber:blur];
                    
                    UIImage *newImage = [blurImage rt_tintedImageWithColor:[UIColor blackColor] level:0.2];
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self setImage:newImage];
                        if (completed) {
                            completed(newImage);
                        }
                    });
                    
                    //清除原有非圆角图片缓存
                    [[SDImageCache sharedImageCache] removeImageForKey:urlStr withCompletion:^{
                    }];
                    
                    // 保存设置后的圆角图片
                    [[SDImageCache sharedImageCache] storeImage:newImage forKey:cacheurlStr completion:^{
                        
                    }];
                }
            }];
        }
    });
}





- (void)loadImageWithAnimation:(UIImage *)image
{
    self.alpha = 0;
    [UIView transitionWithView:self duration:IKLoadImageTime options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self setImage:image];
        self.alpha = 1.0;
    }completion:NULL];
}


@end








//ZYCornerRadius is available under the MIT license.
//Please visit https://github.com/liuzhiyi1992/ZYCornerRadius for details.
