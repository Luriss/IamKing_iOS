//
//  IKTableView.m
//  IamKing
//
//  Created by Luris on 2017/7/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTableView.h"

@implementation IKTableView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
