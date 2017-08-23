//
//  IKSkillTypeVc.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSkillTypeVc.h"
#import "IKTagsCollectionViewCell.h"

@interface IKSkillTypeVc ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong,nullable) NSMutableArray *tagsData;//传入的标签数组 字符串数组
@property (nonatomic,strong,nullable) NSMutableDictionary *tagsIdDict;//传入的标签数组 字符串数组
@end

@implementation IKSkillTypeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];

    [self initCollectionView];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"编辑认证技能";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationView.titleView = title;
    
}


- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    self.navigationView.leftButton = button;
}

- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(80, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10.0f; // 列间距
    layout.minimumLineSpacing = 20.0f; //行间距
    layout.sectionInset = UIEdgeInsetsMake(20.0f, 15.0f, 20.0f, 15.0f);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-70) collectionViewLayout:layout];
    _collectionView.tag = 101;
    _collectionView.bounces = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[IKTagsCollectionViewCell class] forCellWithReuseIdentifier:@"IKTagsCollectionViewCell"];
    
    [self.view addSubview:_collectionView];
}

- (NSMutableArray *)tagsData
{
    if (_tagsData == nil) {
        _tagsData = [[NSMutableArray alloc] init];
    }
    return _tagsData;
}

- (NSMutableDictionary *)tagsIdDict
{
    if (_tagsIdDict == nil) {
        _tagsIdDict = [[NSMutableDictionary alloc] init];
    }
    return _tagsIdDict;
}

- (void)setChildTypeDict:(NSDictionary *)childTypeDict
{
    if (IKDictIsNotEmpty(childTypeDict)) {
        [self.tagsData removeAllObjects];
        [self.tagsIdDict removeAllObjects];

        NSArray *skillList = (NSArray *)[childTypeDict objectForKey:@"skillList"];
        for (NSDictionary *dict in skillList) {
            NSString *name = [dict objectForKey:@"name"];
            
            [self.tagsData addObject:name];
            [self.tagsIdDict setObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] forKey:name];
        }
    }
}


- (void)setDelegate:(id<IKSkillTypeVcDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
    }
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
    IKTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKTagsCollectionViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = _tagsData[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
    
    IKTagsCollectionViewCell *cell = (IKTagsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    NSString*str = cell.titleLabel.text;
    NSString *textID = [self.tagsIdDict objectForKey:str];
    
    if ([self.delegate respondsToSelector:@selector(selectedJobTypeName:typeId:)]) {
        [self.delegate selectedJobTypeName:str typeId:textID];
    }
    
    [self backButtonClick:nil];
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
