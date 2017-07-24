//
//  IKSlideView.m
//  IamKing
//
//  Created by Luris on 2017/7/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSlideView.h"
#import "IKSlideCollectionViewCell.h"


@interface IKSlideView ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation IKSlideView

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
    [self addSubview:self.collectionView];

    
}


- (void)setDelegate:(id<IKSlideViewDelegate>)delegate
{
    _delegate = delegate;
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(100, 50);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.tag = 101;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[IKSlideCollectionViewCell class] forCellWithReuseIdentifier:@"IKSlideCollectionViewCell"];
    }
    return _collectionView;
}


- (void)setData:(NSArray *)data
{
    NSLog(@"data = %@",data);
    if (IKArrayIsNotEmpty(data)) {
        _data = nil;
        _data = data;
        [self.collectionView reloadData];
    }
}


#pragma mark - UICollectionViewDelegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@" ========== %@",self.data);
    return [self.data count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(CGRectGetWidth(self.frame)/self.data.count, CGRectGetHeight(self.frame));
    
    IKLog(@"%@",[NSValue valueWithCGSize:size]);

    return size;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IKSlideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKSlideCollectionViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = _data[indexPath.row];
    if (indexPath.row == 0) {
        cell.lineView.hidden = NO;
        cell.titleLabel.textColor = IKGeneralBlue;
        self.currentIndex = indexPath.row;
    }
    else{
        cell.lineView.hidden = YES;
        cell.titleLabel.textColor = IKSubHeadTitleColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.currentIndex != indexPath.row) {
        IKSlideCollectionViewCell *cell = (IKSlideCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.lineView.hidden = NO;
        cell.titleLabel.textColor = IKGeneralBlue;
        
        IKSlideCollectionViewCell *oldCell = (IKSlideCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
        oldCell.lineView.hidden = YES;
        oldCell.titleLabel.textColor = IKSubHeadTitleColor;
        
        self.currentIndex = indexPath.row;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(slideView:didSelectItemAtIndex:)]) {
        [self.delegate slideView:self didSelectItemAtIndex:indexPath.row];
    }
    
    
}


- (void)reloadData
{
    self.currentIndex = 0;
    [_collectionView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
