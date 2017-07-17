//
//  IKTagsCollectionViewFlowLayout.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTagsCollectionViewFlowLayout.h"



@interface IKTagsCollectionViewFlowLayout()

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (nonatomic, assign) CGFloat contentWidth;//滑动宽度 水平
@property (nonatomic, assign) CGFloat contentHeight;//滑动高度 垂直

@end

@implementation IKTagsCollectionViewFlowLayout


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 
        
    }
    
    return self;
}


- (void)prepareLayout
{
    [super prepareLayout];
    
    // 清空缓存中的 itemAttributes 不清空会保留之前的 itemAttributes,存在崩溃风险
    [self.itemAttributes removeAllObjects];
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    
    //滑动的宽度 = 左边
    self.contentWidth = originX;
    
    //cell的高度 = 顶部 + 高度
    self.contentHeight = originY + self.itemSize.height;
    
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 取到 item 的尺寸
        CGSize itemSize = [self itemSizeForIndexPath:indexPath];
        
        // 起始位置(即 section 的左偏移量) + item 的宽度 + section 的右偏移量,如果大于collectionView的宽度,则另起一行.
        if ((originX + itemSize.width + self.sectionInset.right) > self.collectionView.frame.size.width) {
            
            // 重新设置x起点为 section 的左偏移量
            originX = self.sectionInset.left;
            // y 的起点 = 原先的起点 + item 的高度加上 + 行高
            originY += itemSize.height + self.minimumLineSpacing;
            
            // 内容高度自加.
            self.contentHeight += itemSize.height + self.minimumLineSpacing;
        }
        
        // 给当前 item 设置 布局属性.
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        //添加到布局属性数组
        [self.itemAttributes addObject:attributes];
        
        // 如果 collectionView 能显示当前 item, 则开始下一个.起始 x = 当前 item 的width + 列宽 + section 偏移量.
        originX += itemSize.width + self.minimumInteritemSpacing;
    }
    
    // 内容总高度加上 section 底部偏移量.
    self.contentHeight += self.sectionInset.bottom;
}


// 返回内容总高度.
- (CGSize)collectionViewContentSize
{
    IKLog(@"self.contentHeight = %.0f",self.contentHeight);
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);

}

// 返回 item 的布局属性数组
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

// 获取到当前 item 的 size

- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    return self.itemSize;
}


#pragma mark - Property

- (id<UICollectionViewDelegateFlowLayout>)delegate
{
    if (_delegate == nil) {
        _delegate =  (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    
    return _delegate;
}


- (NSMutableArray *)itemAttributes
{
    if (_itemAttributes == nil) {
        _itemAttributes = [[NSMutableArray alloc] init];
    }
    
    return _itemAttributes;
}



@end
