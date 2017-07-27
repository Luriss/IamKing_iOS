//
//  IKLabel.h
//  IamKing
//
//  Created by Luris on 2017/7/8.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IKVerticalAlignment)
{
    IKVerticalAlignmentTop = 0, // default
    IKVerticalAlignmentMiddle,
    IKVerticalAlignmentBottom,
};

@interface IKLabel : UILabel


@property (nonatomic,assign) IKVerticalAlignment verticalAlignment;

@end
