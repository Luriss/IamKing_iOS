//
//  LRTagsCollectionViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "LRTagsCollectionViewCell.h"

@implementation LRTagsCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.cornerRadius = 12;
        _titleLabel.layer.borderColor = IKSubHeadTitleColor.CGColor;
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.textColor = IKSubHeadTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}


@end
