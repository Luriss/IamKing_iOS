//
//  IKTypeTableView.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTypeTableView.h"
#import "IKTypeTableViewCell.h"


@interface IKTypeTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *logoArray;


@end



@implementation IKTypeTableView


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
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 0.213*IKSCREEN_WIDTH;
    [self addSubview:tableView];
    self.tableView = tableView;
}

- (void)setJobTypeData:(NSArray *)jobTypeData
{
    if (IKArrayIsNotEmpty(jobTypeData)) {
        _jobTypeData = jobTypeData;
    }
}

- (void)setDelegate:(id<IKTypeTableViewDelegate>)delegate
{
    _delegate = delegate;
}

- (NSArray *)logoArray
{
    if (_logoArray == nil) {
        _logoArray = [NSArray arrayWithObjects:@"IK_cocah",@"IK_sellPerformance",@"IK_operationManage",@"IK_bulb",@"IK_trainTeacher",@"IK_presellProject", nil];
    }
    return _logoArray;
}

- (void)reloadTableViewData
{
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobTypeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"IKTypeCellId";
    IKTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell==nil)
    {
        cell=[[IKTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
//    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (indexPath.row < self.logoArray.count) {
        [cell addCellDataWithLogo:self.logoArray[indexPath.row] data:[self.jobTypeData objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKLog(@"self.delegate = %@",self.delegate);
    if ([self.delegate respondsToSelector:@selector(typeTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate typeTableView:tableView didSelectRowAtIndexPath:indexPath];
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
