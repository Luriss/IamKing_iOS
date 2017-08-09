//
//  IKLoopImageViewController.m
//  IamKing
//
//  Created by Luris on 2017/8/8.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKLoopImageViewController.h"


@interface IKLoopImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

- (void)setupWithUrlString:(NSString*)url placeholderImage:(UIImage*)placeholderImage;
- (void)setupWithImageName:(NSString*)imgName placeholderImage:(UIImage*)placeholderImage;
- (void)setupWithImage:(UIImage*)img placeholderImage:(UIImage*)placeholderImage;

@end


@implementation IKLoopImageCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}


- (void)setupWithUrlString:(NSString*)url placeholderImage:(UIImage*)placeholderImage
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage];
}

- (void)setupWithImageName:(NSString*)imgName placeholderImage:(UIImage*)placeholderImage {
    UIImage* image = [UIImage imageNamed:imgName];
    if (!image) {
        image  = placeholderImage;
    }
    self.imageView.image = image;
}

- (void)setupWithImage:(UIImage*)img placeholderImage:(UIImage*)placeholderImage {
    if (img) {
        self.imageView.image = img;
    }else {
        self.imageView.image = placeholderImage;
    }
}

- (void)setupImageView {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];
}

- (UIImageView* )imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}


- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = IKMainTitleColor;
        _label.font = [UIFont systemFontOfSize:15.0f];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}


@end


@interface IKLoopImageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

@implementation IKLoopImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64);
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64) collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[IKLoopImageCollectionViewCell class] forCellWithReuseIdentifier:@"IKLoopImageCollectionViewCellId"];
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
    IKLoopImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKLoopImageCollectionViewCellId" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor blackColor];
    NSInteger count = self.imageArray.count;
    if (count > 0) {

        id object = [self.imageArray objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[NSString class]]) {
            if ([(NSString*)object hasPrefix:@"http"]) {
                [cell setupWithUrlString:(NSString*)object placeholderImage:nil];
            }
            else {
                [cell setupWithImageName:(NSString*)object placeholderImage:nil];
            }
        }
        else if ([object isKindOfClass:[UIImage class]]) {
            [cell setupWithImage:(UIImage*)object placeholderImage:nil];
        }
    }
    
    cell.label.text = [NSString stringWithFormat:@"%ld / %ld",indexPath.row+1,count];
    
    
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
