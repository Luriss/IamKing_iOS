//
//  IKSlideView.m
//  IamKing
//
//  Created by Luris on 2017/7/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSlideView.h"


@interface IKSlideView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign, readwrite) NSInteger currentIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) IKView *maskView;


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
    [self addSubview:self.maskView];
    [self addSubview:self.searchBtn];
    [self addSubview:self.moreBtn];
}


- (void)setDelegate:(id<IKSlideViewDelegate>)delegate
{
    _delegate = delegate;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutCollectionView];
    [self layoutMaskView];
    [self layoutButtons];
}


- (UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[IKView alloc] init];
        _maskView.backgroundColor = IKColorFromRGB(0xf2f2f0);
        _maskView.alpha = 0.6f;
    }
    return _maskView;
}


- (UIButton *)searchBtn
{
    if (_searchBtn == nil) {
        // 搜索按钮
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.tag = 1001;
//        _searchBtn.backgroundColor = [UIColor blueColor];
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        [_searchBtn setImage:[UIImage imageNamed:@"IK_search"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _searchBtn;
}

- (UIButton *)moreBtn
{
    if (_moreBtn == nil) {
        // 更多按钮
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.tag = 1002;
//        _moreBtn.backgroundColor = [UIColor redColor];
        _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
//        _moreBtn.layer.shadowRadius = 10;
//        _moreBtn.layer.shadowColor = IKColorFromRGB(0xf2f2f0).CGColor;
        [_moreBtn setImage:[UIImage imageNamed:@"IK_more"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreBtn;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _flowLayout = layout;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.tag = 101;
        _collectionView.bounces = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"IKCollectionViewCell"];
    }
    return _collectionView;
}



- (void)layoutMaskView
{
    __weak typeof (self) weakSelf = self;

    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(weakSelf);
        make.width.mas_equalTo(90);
    }];
}


- (void)layoutButtons
{
    __weak typeof (self) weakSelf = self;


    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(4);
//        make.bottom.equalTo(self).offset(-4);
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-5);
        make.width.and.height.mas_equalTo(CGRectGetHeight(weakSelf.bounds));
    }];
    
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.equalTo(_searchBtn);
        make.right.equalTo(_searchBtn.mas_left).offset(-5);
//        make.width.mas_equalTo(24);
    }];
    
}

- (void)layoutCollectionView
{
    _flowLayout.itemSize = CGSizeMake(60, CGRectGetHeight(self.frame));
    _collectionView.frame = CGRectMake(0, 0,CGRectGetWidth(self.frame) - 70, CGRectGetHeight(self.frame));
}



#pragma mark - UICollectionViewDelegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKCollectionViewCell" forIndexPath:indexPath];
    while (cell.contentView.subviews.count) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    label.text = [self.data objectAtIndex:indexPath.row];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:13.0];
    label.textColor = IKRGBColor(93, 93, 93);
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.right.equalTo(cell.contentView);
        make.left.mas_equalTo(5);
        
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(slideView:didSelectItemAtIndex:)]) {
        [self.delegate slideView:self didSelectItemAtIndex:indexPath.row];
    }
    
    
}


- (void)btnClick:(UIButton *)button
{
    NSLog(@"%@",button);
    if (button.tag == 1002) {
        if ([self.delegate respondsToSelector:@selector(slideViewMoreButtonClick:)]) {
            [self.delegate slideViewMoreButtonClick:button];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(slideViewSearchButtonClick:)]) {
            [self.delegate slideViewSearchButtonClick:button];
        }
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
