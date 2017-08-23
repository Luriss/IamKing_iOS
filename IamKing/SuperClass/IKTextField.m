//
//  IKTextField.m
//  IamKing
//
//  Created by Luris on 2017/8/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTextField.h"

@implementation IKTextField

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        self.font = [UIFont systemFontOfSize:13];
    }
    
    return self;
}


- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    return iconRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super textRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    iconRect.size.width -= 20;
    return iconRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super editingRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    iconRect.size.width -= 20;
    return iconRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
