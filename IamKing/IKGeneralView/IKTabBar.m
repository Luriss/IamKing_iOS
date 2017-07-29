//
//  IKTabBar.m
//  IamKing
//
//  Created by Luris on 2017/7/28.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTabBar.h"
NSString *const kIKTabBarItemTitle = @"kIKTabBarItemTitle";
NSString *const kIKTabBarItemNormalImageName = @"kIKTabBarItemNormalImageName";
NSString *const kIKLTabBarItemSelectedImageName = @"kIKLTabBarItemSelectedImageName";




@interface IKTabBarItem : UIButton

@end

@implementation IKTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (void)config
{
    self.adjustsImageWhenHighlighted = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize titleSize = self.titleLabel.frame.size;
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;

    NSInteger titleTopInset = CGRectGetHeight(self.frame) - titleSize.height;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(titleTopInset - 10, -30, 0, 0)];
    CGFloat imageViewLeftRightInset = (CGRectGetWidth(self.frame) - imageSize.width) / 2;
   
    [self setImageEdgeInsets:UIEdgeInsetsMake(CGRectGetHeight(self.frame) - titleSize.height - imageSize.height - 2, imageViewLeftRightInset + 2,titleSize.height + 8, imageViewLeftRightInset + 4)];
}

@end

@interface IKTabBar ()

@property (strong, nonatomic) NSMutableArray *tabBarItems;

@end

@implementation IKTabBar

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        line.backgroundColor = IKLineColor;
        [self addSubview:line];
    }
    
    return self;
}

#pragma mark - Private Method


- (void)setSelectedIndex:(NSInteger)index {
    for (IKTabBarItem *item in self.tabBarItems) {
        if (item.tag == index) {
            item.selected = YES;
            item.backgroundColor = IKGeneralLightGray;
        } else {
            item.selected = NO;
            item.backgroundColor = [UIColor whiteColor];
        }
    }
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    UITabBarController *tabBarController = (UITabBarController *)keyWindow.rootViewController;
    if (tabBarController) {
        tabBarController.selectedIndex = index;
    }
}

#pragma mark - Touch Event

- (void)itemSelected:(IKTabBarItem *)sender {
    [self setSelectedIndex:sender.tag];
}

#pragma mark - Setter

- (void)setTabBarItemAttributes:(NSArray<NSDictionary *> *)tabBarItemAttributes {
    _tabBarItemAttributes = tabBarItemAttributes.copy;
    
//    NSAssert(_tabBarItemAttributes.count > 2, @"TabBar item count must greet than two.");
    
    CGFloat normalItemWidth = (IKSCREEN_WIDTH/_tabBarItemAttributes.count);
    CGFloat tabBarHeight = CGRectGetHeight(self.frame);
    
    NSInteger itemTag = 0;
    
    _tabBarItems = [NSMutableArray arrayWithCapacity:_tabBarItemAttributes.count];
    
    for (id item in _tabBarItemAttributes) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            NSDictionary *itemDict = (NSDictionary *)item;
            
            CGRect frame = CGRectMake(itemTag * normalItemWidth, 0,normalItemWidth, tabBarHeight);
            
            IKTabBarItem *tabBarItem = [self tabBarItemWithFrame:frame title:itemDict[kIKTabBarItemTitle] normalImageName:itemDict[kIKTabBarItemNormalImageName] selectedImageName:itemDict[kIKLTabBarItemSelectedImageName]];
            
            if (itemTag == 0) {
                tabBarItem.selected = YES;
                tabBarItem.backgroundColor = IKGeneralLightGray;
            }
            
            [tabBarItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            tabBarItem.tag = itemTag;
            itemTag++;
            
            [_tabBarItems addObject:tabBarItem];
            [self addSubview:tabBarItem];
        }
    }
}

- (IKTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName{
   
    IKTabBarItem *item = [[IKTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    [item setTitleColor:IKGeneralBlue forState:UIControlStateSelected];
    return item;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
