//
//  IKTypeDetailView.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTypeDetailView.h"
#import "IKTagsView.h"
#import "IKLocationCell.h"

@interface IKTypeDetailView ()<UITableViewDelegate,UITableViewDataSource,IKTagsViewDelegate>
{
    NSIndexPath  *_oldIndexPath;

}

@property (nonatomic, strong)UITableView *leftTableView;
@property (nonatomic, strong)IKTagsView *tagsView;

@end



@implementation IKTypeDetailView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTableView];
        [self initTagsView];

    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initTableView];
        [self initTagsView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [self layoutCustomView];
    
    [super layoutSubviews];
}

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = IKRGBColor(239.0, 239.0, 243.0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.leftTableView = tableView;
}


- (void)initTagsView
{
    IKTagsView *tagsView = [[IKTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds)*0.7, CGRectGetHeight(self.bounds))];
    tagsView.backgroundColor = [UIColor whiteColor];
    tagsView.delegate = self;
    tagsView.tagsData = @[@"私人教练",@"私",@"私教经理私私",@"私教经理私私四十四"];
    [self addSubview:tagsView];
    self.tagsView = tagsView;
}


- (void)layoutCustomView
{
    __weak typeof (self) weakSelf = self;

    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.3);
    }];
    
    [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(weakSelf);
        make.left.equalTo(_leftTableView.mas_right);
    }];
}





#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"typeDetailId";
    IKLocationCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell==nil){
        cell=[[IKLocationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lineView.hidden = NO;
        _oldIndexPath = indexPath;
    }
    else{
        cell.lineView.hidden = YES;
    }

//    NSString *cityStr = [self.cityData objectAtIndex:indexPath.row];
    cell.tLabel.text = [self.detailData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_oldIndexPath != indexPath) {
        
        IKLocationCell *cell = (IKLocationCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.lineView.hidden = NO;
        
        IKLocationCell *oldCell = (IKLocationCell *)[tableView cellForRowAtIndexPath:_oldIndexPath];
        oldCell.lineView.hidden = YES;
        
        _oldIndexPath = indexPath;
    }
    
    if (indexPath.row == 1) {
        self.tagsView.tagsData = @[@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私",@"私教经",@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私",@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私",@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私",@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私",@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私",@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私",@"销售能手",@"销售",@"私教经理私私私教经理私私私教经理私私"];
    }
    else{
        self.tagsView.tagsData = @[@"私人教练",@"私",@"私教经理私私",@"私教经理私私四十四"];
    }
    
    [self.tagsView reloadCollectionViewData];
    

}


#pragma mark - IKTagsViewDelegate

- (void)tagsCollectionViewDidSelectItemWithTitle:(NSString *)title
{
    IKLog(@"tagsCollectionViewDidSelectItemWithTitle = %@",title);
    
    if ([self.delegate respondsToSelector:@selector(typeDetailViewDidSelectItemWithTitle:)]) {
        [self.delegate typeDetailViewDidSelectItemWithTitle:title];
    }
}


- (void)typeDetailViewReloadData
{
    [self.leftTableView reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
