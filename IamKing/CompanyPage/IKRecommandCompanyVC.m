//
//  IKRecommandCompanyVC.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKRecommandCompanyVC.h"
#import "IKRecommandCoCollectionViewCell.h"

@interface IKRecommandCompanyVC ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation IKRecommandCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLeftBackItem];
    [self initNavTitle];

    [self initCollectionView];
    
    
    // Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(recommandVcDismissSelf) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back"] forState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"推荐公司";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1)];
    lineView.backgroundColor = IKLineColor;
    [self.view addSubview:lineView];
}

- (void)recommandVcDismissSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(IKSCREEN_WIDTH * 0.2933, IKSCREENH_HEIGHT*0.2249);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 4.0f; // 列间距
    layout.minimumLineSpacing = 13.0f; //行间距
    layout.sectionInset = UIEdgeInsetsMake(0.0f, 15.0f, 30.0f, 15.0f);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64) collectionViewLayout:layout];
    _collectionView.tag = 101;
    _collectionView.bounces = YES;
    _collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[IKRecommandCoCollectionViewCell class] forCellWithReuseIdentifier:@"IKRecommandCoCollectionViewCell"];
    
    [self.view addSubview:_collectionView];
}



#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;//self.dataArray.count;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 根据文字计算尺寸.
//    CGFloat w = [self widthForLabel:_tagsData[indexPath.row] fontSize:15];
//    return CGSizeMake(w, 24);
//}



- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    // 根据文字计算尺寸.
    CGRect frame = [text boundingRectWithSize:CGSizeMake(_collectionView.frame.size.width, 24) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    
    // item 默认的最小宽度为 40;
    CGFloat width = frame.size.width + 15;
    
    if (width < 40) {
        width = 40;
    }
    
    // 超过最大宽度显示为最大宽度
    CGFloat maxWidth = CGRectGetWidth(self.view.bounds) - 20;
    if (width > maxWidth){
        width = maxWidth;
    }
    
    return width;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKRecommandCoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKRecommandCoCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row < self.dataArray.count) {
//        [cell addRecommendCellData:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
    
    IKRecommandCoCollectionViewCell *cell = (IKRecommandCoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

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
