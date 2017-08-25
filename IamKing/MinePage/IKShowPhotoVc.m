//
//  IKShowPhotoVc.m
//  IamKing
//
//  Created by Luris on 2017/8/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKShowPhotoVc.h"
#import "IKShowPhotoCollectionViewCell.h"

@interface IKShowPhotoVc ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

@implementation IKShowPhotoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popVc)];
    
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.collectionView];
    
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
        flowLayout.itemSize = CGSizeMake(IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64 - 100);
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64) collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[IKShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"IKShowPhotoCollectionViewCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}


- (void)setImageArray:(NSArray *)imageArray
{
    if (IKArrayIsNotEmpty(imageArray)) {
        _imageArray = imageArray;
    }
}


-(void)setSelectedIndex:(NSString *)selectedIndex
{
    if (IKStringIsNotEmpty(selectedIndex)) {
        _selectedIndex = selectedIndex;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[selectedIndex integerValue] inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
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
    IKShowPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKLoopImageCollectionViewCellId" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    NSInteger count = self.imageArray.count;
    if (count > 0 && indexPath.row < count) {
        [cell setupImageWithUrlString:self.imageArray[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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
