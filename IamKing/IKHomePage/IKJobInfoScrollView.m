//
//  IKJobInfoScrollView.m
//  IamKing
//
//  Created by Luris on 2017/7/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobInfoScrollView.h"

@interface IKJobInfoScrollView ()<UIScrollViewDelegate>

@end



@implementation IKJobInfoScrollView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubViews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubViews];
    }
    return self;
}


- (void)addSubViews
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor redColor];
    
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    
    
    [self addSubview:self.infoScrollView];
}

- (UIScrollView *)infoScrollView
{
    if (_infoScrollView == nil) {
        _infoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, IKSCREEN_WIDTH, CGRectGetHeight(self.bounds))];
        _infoScrollView.delegate = self;
        _infoScrollView.scrollEnabled = YES;
        _infoScrollView.showsHorizontalScrollIndicator = NO;
        _infoScrollView.showsVerticalScrollIndicator = YES;
        _infoScrollView.contentSize = CGSizeMake(1000, CGRectGetHeight(self.bounds) + 10);
        _infoScrollView.backgroundColor = [UIColor purpleColor];
    }
    
    return _infoScrollView;
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll x = %.0f",scrollView.contentOffset.x);

    NSLog(@"scrollViewDidScroll y = %.0f",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y <= 0) {
        scrollView.scrollEnabled = NO;
        if ([self.delegate respondsToSelector:@selector(jobInfoScrollViewVerticalScroll)]) {
            [self.delegate jobInfoScrollViewVerticalScroll];
        }
    }
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
