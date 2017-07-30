//
//  LRPageControl.m
//  IamKing
//
//  Created by Luris on 2017/7/20.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "LRPageControl.h"


@interface LRPageControl ()

@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,strong)UIView *oldView;

@end


@implementation LRPageControl


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}


- (void)addSubViews
{
    CGFloat firstOneX = 0;
    if (_numberOfPages%2 == 0) {
        NSInteger middleOne = (_numberOfPages + 1)*0.5;
        firstOneX = (CGRectGetWidth(self.bounds))*0.5 - ((middleOne - 1)*(6+5) - 2);
    }
    else{
        firstOneX = (CGRectGetWidth(self.bounds))*0.5 - ((_numberOfPages * 0.5)*(6+5));
    }
    
    
    for (int i = 0; i < _numberOfPages; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(firstOneX + i * (6+5), (CGRectGetHeight(self.bounds) - 5)*0.5, 5, 5)];
        view.layer.cornerRadius = 2.5;
        view.backgroundColor = [IKGeneralLightGray colorWithAlphaComponent:0.6];
        [self addSubview:view];
        
        [self.viewArray addObject:view];
    }
    
    [self setCurrentPage:0];
}


- (NSMutableArray *)viewArray
{
    if (_viewArray == nil) {
        _viewArray = [[NSMutableArray alloc] init];
    }
    return _viewArray;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    if (numberOfPages > 0) {
        [self addSubViews];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (currentPage < self.viewArray.count) {
        _currentPage = currentPage;
        
        if (self.oldView) {
            self.oldView.backgroundColor = [IKGeneralLightGray colorWithAlphaComponent:0.6];
            self.oldView.frame = CGRectMake(self.oldView.frame.origin.x+2, self.oldView.frame.origin.y, 5, 5);
        }
        
        UIView *currentView = (UIView *)[self.viewArray objectAtIndex:currentPage];
        currentView.backgroundColor = [UIColor whiteColor];
        currentView.frame = CGRectMake(currentView.frame.origin.x-2, currentView.frame.origin.y, 9, 5);
        
        self.oldView = currentView;
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
