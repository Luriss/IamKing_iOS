//
//  IKSearchBar.m
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchBar.h"

@implementation IKSearchBar

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self modifyTextField];
    }
    
    return self;
}

- (void)modifyTextField
{
    // 替换原有的背景图.
    [self setBackgroundImage:[UIImage imageNamed:@"IK_bg_white"]];
    // 取消放大镜
    [self setImage:[UIImage imageNamed:@"IK_bg"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    // 设置文字起始输入位置.
    self.searchTextPositionAdjustment = UIOffsetMake(5, 0);

    UITextField *searchField = [self valueForKey:@"searchField"];
    
    if (searchField) {
        [searchField setBackgroundColor:IKRGBColor(239.0, 239.0, 243.0)];
        searchField.layer.cornerRadius = 15.0f;
        searchField.layer.masksToBounds = YES;
        searchField.leftViewMode = UITextFieldViewModeNever;
        
        // 取消掉清除按钮,但预留位置给搜索按钮.
        searchField.clearButtonMode = UITextFieldViewModeAlways;
        UIButton *clearButton = [searchField valueForKey:@"clearButton"];
        [clearButton setImage:[UIImage imageNamed:@"IK_bg"] forState:UIControlStateNormal];

    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
