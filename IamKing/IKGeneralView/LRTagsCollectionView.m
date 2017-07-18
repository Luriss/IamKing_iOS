//
//  LRTagsCollectionView.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "LRTagsCollectionView.h"
#import "LRTagsCollectionViewFlowLayout.h"
#import "LRTagsCollectionViewCell.h"


static NSString * const reuseIdentifier = @"LRTagsCollectionViewCellId";


@interface LRTagsCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) LRTagsCollectionViewFlowLayout *layout;//布局layout

@end

@implementation LRTagsCollectionView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubviews];
    }
    
    return self;
}


- (void)addSubviews
{
    [self addSubview:self.collectionView];
}



- (LRTagsCollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        _layout = [[LRTagsCollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 5.0f;
        _layout.minimumLineSpacing = 5.0f;
        _layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        _layout.itemSize = CGSizeMake(50, 24);
    }
    
    return _layout;
}


- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[LRTagsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return _collectionView;
}





#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    IKLog(@"_tagsData.count = %ld",_tagsData.count);
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = _tagsData[section];
    IKLog(@"itemsCount = %ld",arr.count);
    
    return 12;
}



- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    // 根据文字计算尺寸.
    CGRect frame = [text boundingRectWithSize:CGSizeMake(_collectionView.frame.size.width, 24) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    
    // item 默认的最小宽度为 80;
    CGFloat width = frame.size.width + 20;
    if (width < 80) {
        width = 80;
    }
    
    // 超过最大宽度显示为最大宽度
    CGFloat maxWidth = CGRectGetWidth(self.bounds) - 20;
    if (width > maxWidth){
        width = maxWidth;
    }
    
    return width;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.titleLabel.text = _tagsData[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
    
    
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
