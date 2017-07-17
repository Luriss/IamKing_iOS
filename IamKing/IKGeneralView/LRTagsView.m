//
//  LRTagsView.m
//  IamKing
//
//  Created by Luris on 2017/7/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "LRTagsView.h"
#import "LRTagsCollectionViewFlowLayout.h"
#import "LRTagsCollectionViewCell.h"
#import "IKImageWordView.h"


static NSString * const reuseIdentifier = @"LRTagsCollectionViewCellId";


@interface LRTagsView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation LRTagsView


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
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    [self addSubview:self.bottomLine];

}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 3, 20, 20)];
    }
    return _imageView;
}


- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 30)];
        _label.font = [UIFont boldSystemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = IKSubHeadTitleColor;
    }
    
    return _label;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 1, CGRectGetWidth(self.bounds), 1)];
        _bottomLine.backgroundColor = IKLineColor;
    }
    return _bottomLine;
}

- (void)setTitleImageName:(NSString *)titleImageName
{
    if (IKStringIsNotEmpty(titleImageName)) {
        _titleImageName = titleImageName;
        [_imageView setImage:[UIImage imageNamed:titleImageName]];
    }
}

- (void)setTitle:(NSString *)title
{
    if (IKStringIsNotEmpty(title)) {
        _title = title;
        _label.text = title;
    }
}


- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

        flowLayout.minimumInteritemSpacing = 5.0f;
        flowLayout.minimumLineSpacing = 5.0f;
        flowLayout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        flowLayout.itemSize = CGSizeMake(50, 24);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 32, CGRectGetWidth(self.bounds) - 5,CGRectGetHeight(self.bounds) - 40) collectionViewLayout:flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tagsData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 根据文字计算尺寸.
    CGFloat w = [self widthForLabel:_tagsData[indexPath.row] fontSize:15];
    return CGSizeMake(w, 24);
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
//    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
//    return size.width;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    

    cell.titleLabel.text = _tagsData[indexPath.row];
    
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
