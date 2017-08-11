//
//  IKRecommandCompanyVC.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKRecommandCompanyVC.h"
#import "IKRecommandCoCollectionViewCell.h"
#import "IKCompanyDetailVC.h"


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
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    self.navigationView.leftButton = button;
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"推荐公司";
    title.textColor = IKGeneralWhite;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationView.titleView = title;
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
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64) collectionViewLayout:layout];
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
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKRecommandCoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKRecommandCoCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row < self.dataArray.count) {
        [cell addRecommendCellData:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
    
    IKCompanyRecommendListModel *model = (IKCompanyRecommendListModel *)self.dataArray[indexPath.row];
    
    IKCompanyDetailVC *companyDetail = [[IKCompanyDetailVC alloc] init];
    
    IKCompanyInfoModel *companyInfoModel = [[IKCompanyInfoModel alloc] init];
    companyInfoModel.companyID = model.companyID;
    companyDetail.companyInfoModel = companyInfoModel;
    
    [self.navigationController pushViewController:companyDetail animated:YES];
    

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
