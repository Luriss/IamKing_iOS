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
    [self setImage:[[UIImage imageNamed:@"IK_search"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, -5, -5) resizingMode:UIImageResizingModeStretch] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UITextField *searchField = [self valueForKey:@"searchField"];
    
    if (searchField) {
        [searchField setBackgroundColor:IKRGBColor(239.0, 239.0, 243.0)];
        searchField.layer.cornerRadius = 15.0f;
        searchField.layer.masksToBounds = YES;
        searchField.leftViewMode = UITextFieldViewModeAlways;
        searchField.clearButtonMode = UITextFieldViewModeAlways;
        UIImageView *search = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        [search setImage:[UIImage imageNamed:@"IK_search"]];
        searchField.leftView = search;
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
