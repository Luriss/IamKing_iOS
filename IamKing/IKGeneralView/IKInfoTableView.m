//
//  IKInfoTableView.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKInfoTableView.h"
#import "IKInfoTableViewCell.h"

@interface IKInfoTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *leftHeaderBtn;
@property (nonatomic,strong)UIButton *rightHeaderBtn;
@property (nonatomic,strong)IKJobInfoModel *model;

@end



@implementation IKInfoTableView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTableView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initTableView];

    }
    
    return self;
}



- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    _model = [[IKJobInfoModel alloc] init];
    _model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg";
    _model.title = @"高级营销总监";
    _model.salary = @"13~18k";
    _model.address = @"杭州";
    _model.experience = @"6~8年";
    _model.education = @"本科";
    _model.skill1 = @"销售能手好";
    _model.skill2 = @"NAFC";
    _model.skill3 = @"形象好";
    _model.introduce = @"时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.";
}

- (void)setDelegate:(id<IKInfoTableViewDelegate>)delegate
{
    _delegate = delegate;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"IKInfoCellId";
    IKInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];

    if(cell==nil)
    {
        cell=[[IKInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (indexPath.row == 1) {
        _model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg";
    }
    [cell addCellData:_model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(infoTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate infoTableView:tableView didSelectRowAtIndexPath:indexPath];
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
