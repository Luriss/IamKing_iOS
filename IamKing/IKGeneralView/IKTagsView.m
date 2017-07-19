//
//  IKTagsView.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTagsView.h"
#import "IKTagsCollectionViewFlowLayout.h"
#import "IKTagsCollectionViewCell.h"
#import "IKHeaderReusableView.h"


@interface IKTagsView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) IKTagsCollectionViewFlowLayout *layout;//布局layout

@end


@implementation IKTagsView

static NSString * const reuseIdentifier = @"IKTagsCollectionViewCellId";
static NSString * const headerReuseIdentifier = @"IKCollectionViewHeader";

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configAndAddSubview];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configAndAddSubview];
    }
    
    return self;
}


- (void)configAndAddSubview
{
    [self addSubview:self.collectionView];
    
}

- (IKTagsCollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        _layout = [[IKTagsCollectionViewFlowLayout alloc] init];
    }
    
    return _layout;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        IKLog(@"===== =%@",[NSValue valueWithCGRect:self.bounds]);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = IKRGBColor(244.0, 244.0, 248.0);
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.frame = self.bounds;

        [_collectionView registerClass:[IKTagsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        [_collectionView registerClass:[IKHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
        
        _collectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, -25, 224, 30)];
//        label.backgroundColor = [UIColor redColor];
        label.text = @"职位分类/专业技能";
        label.textColor = IKRGBColor(163, 163, 163);
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textAlignment = NSTextAlignmentLeft;
        [_collectionView addSubview:label];
    }
    
    return _collectionView;
}



#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tagsData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKTagsCollectionViewFlowLayout *layout = (IKTagsCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    
    // item 能显示的最大宽度 ,collectionView的宽度 - section 的偏移 left right.
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    // 根据文字计算尺寸.
    CGRect frame = [_tagsData[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    
    // item 默认的最小宽度为 80;
    CGFloat width = frame.size.width + 20;
    if (width < 80) {
        width = 80;
    }
    
    // 超过最大宽度显示为最大宽度
    if (width > maxSize.width) {
        width = maxSize.width;
    }
    
    return CGSizeMake(width, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.textColor = [UIColor blackColor];
    
    NSString *title = self.tagsData[indexPath.item];
    cell.titleLabel.text = title;

    if (indexPath.row == 1) {
        cell.highlightLabel = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
    
    IKTagsCollectionViewCell *cell = (IKTagsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *title = cell.titleLabel.text;
    
    if ([self.delegate respondsToSelector:@selector(tagsCollectionViewDidSelectItemWithTitle:)]) {
        [self.delegate tagsCollectionViewDidSelectItemWithTitle:title];
    }
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        CGSize size = {CGRectGetWidth(self.bounds), 30};
        
        IKLog(@" ======== size = %@",[NSValue valueWithCGSize:size]);
        return size;
    }
    return CGSizeZero;
}


- (void)reloadCollectionViewData
{
    [self.collectionView reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
