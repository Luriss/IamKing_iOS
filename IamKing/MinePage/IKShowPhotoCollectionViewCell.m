//
//  IKShowPhotoCollectionViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKShowPhotoCollectionViewCell.h"


@interface IKShowPhotoCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation IKShowPhotoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}


- (void)setupImageWithUrlString:(NSString*)url
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
    __weak typeof (self) weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.imageView.alpha = 0.0;
        
        [UIView transitionWithView:weakSelf.imageView duration:IKLoadImageTime options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [weakSelf.imageView setImage:image];
            weakSelf.imageView.alpha = 1.0;
        }completion:NULL];
    }];
}


- (void)setupImageView
{
    [self.contentView addSubview:self.imageView];
}

- (UIImageView* )imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

@end
