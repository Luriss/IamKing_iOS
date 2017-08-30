//
//  IKShowPhotoVc.m
//  IamKing
//
//  Created by Luris on 2017/8/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKShowPhotoVc.h"
#import "IKShowPhotoCollectionViewCell.h"

@interface IKShowPhotoVc ()<UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation IKShowPhotoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popVc)];
//    
//    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.countLabel];
    [self.view bringSubviewToFront:self.countLabel];
    
    [self.view addSubview:self.deleteBtn];
    [self.view bringSubviewToFront:self.deleteBtn];
    // Do any additional setup after loading the view.
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 180);
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 180) collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[IKShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"IKShowPhotoCollectionViewCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}


- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH *0.5 - 30, 30, 60, 24)];
        _countLabel.font = [UIFont systemFontOfSize:15.0f];
        _countLabel.textColor = [UIColor whiteColor];
//        _countLabel.text = @"上传证书";
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}


- (UIButton *)deleteBtn
{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(IKSCREEN_WIDTH *0.5 - 30, IKSCREENH_HEIGHT - 100, 60, 30);
        [_deleteBtn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _deleteBtn.layer.cornerRadius = 6;
        _deleteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _deleteBtn.layer.borderWidth = 1.0f;
    }
    
    return _deleteBtn;
}


- (void)setImageArray:(NSArray *)imageArray
{
    if (IKArrayIsNotEmpty(imageArray)) {
        _imageArray = imageArray;
    }
}


-(void)setSelectedIndex:(NSInteger )selectedIndex
{
    _selectedIndex = selectedIndex;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",selectedIndex + 1,self.imageArray.count];
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"self.imageArray.count = %ld",self.imageArray.count);
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKShowPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKShowPhotoCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    NSInteger count = self.imageArray.count;
    if (count > 0 && indexPath.row < count) {
        [cell setupImageWithUrlString:self.imageArray[indexPath.row]];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath indexPath.row = %ld",indexPath.row);

    [self popVc];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    _selectedIndex = offsetX/IKSCREEN_WIDTH;
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",_selectedIndex+1,self.imageArray.count];
}



- (void)deleteButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(deletePhotoAtIndex:)]) {
        [self.delegate deletePhotoAtIndex:_selectedIndex];
    }
    
    [self popVc];
}



- (void)popVc
{
    [self.navigationController popViewControllerAnimated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
