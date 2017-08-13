//
//  LRTabBar.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "LRTabBar.h"

#define TabBarButtonImageRatio 0.5

@interface LRTabBarButton : UIButton

@property(nonatomic, strong)UITabBarItem *tabBarItem;


- (void)setButtonTitle:(NSString *)title
                 image:(UIImage *)image
         selectedImage:(UIImage *)selectedImage;

@end



@implementation LRTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //只需要设置一次的放置在这里
        self.imageView.contentMode = UIViewContentModeBottom;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [self setTitleColor:IKGeneralBlue forState:UIControlStateSelected];
        [self setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
                
    }
    return self;
}


//重写该方法可以去除长按按钮时出现的高亮效果
- (void)setHighlighted:(BOOL)highlighted
{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height*TabBarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height*TabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}


- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
}


- (void)setButtonTitle:(NSString *)title
                 image:(UIImage *)image
         selectedImage:(UIImage *)selectedImage
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:selectedImage forState:UIControlStateSelected];
}


@end


@interface LRTabBar ()

@property(nonatomic, strong)NSMutableArray *tabbarBtnArray;
@property(nonatomic, weak)LRTabBarButton *selectedButton;


@end

@implementation LRTabBar

- (NSMutableArray *)tabbarBtnArray
{
    if (!_tabbarBtnArray) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return  _tabbarBtnArray;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int i = 0; i < self.tabbarBtnArray.count; i++) {
        CGFloat btnX = btnW * i;
        LRTabBarButton *tabBarBtn = self.tabbarBtnArray[i];
//        if (i > 1) {
//            btnX += btnW;
//        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = i;
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem
{
    LRTabBarButton *tabBarBtn = [[LRTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;

    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}


- (void)changeButtonTitle:(NSString *)newTitle image:(UIImage *)newImage selectedImage:(UIImage *)newSelectedImage
{
    LRTabBarButton *tabBarBtn = [self.tabbarBtnArray objectAtIndex:3];
    [tabBarBtn setTitle:newTitle forState:UIControlStateNormal];
    [tabBarBtn setImage:newImage forState:UIControlStateNormal];
    [tabBarBtn setImage:newSelectedImage forState:UIControlStateSelected];

    [self ClickTabBarButton:(LRTabBarButton *)self.tabbarBtnArray.lastObject];
}


- (void)addTabBarButtonWithTitle:(NSString *)title
                           image:(UIImage *)image
                   selectedImage:(UIImage *)selectedImage
{
    LRTabBarButton *tabBarBtn = [[LRTabBarButton alloc] init];
    
    [tabBarBtn setButtonTitle:title image:image selectedImage:selectedImage];
    
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabBarBtn];
    
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}


- (void)ClickTabBarButton:(LRTabBarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    tabBarBtn.backgroundColor = IKGeneralLightGray;
    self.selectedButton.backgroundColor = [UIColor whiteColor];
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
