//
//  IKCompanyListView.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyListView.h"
#import "IKSchoolTableViewCell.h"


@interface IKCompanyListView ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic, strong)UITableView *tableView;


@end


@implementation IKCompanyListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}


- (void)setDataSource:(NSArray *)dataSource
{
    if (IKArrayIsNotEmpty(dataSource)) {
        
        _dataSource = dataSource;
        [self addSubview:self.tableView];
    }
}




- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataSource[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.headerTitle.count > 0) {
        return 40;
    }
    return 0.00001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId = @"IKSchoolTableViewCellId";
    IKSchoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKSchoolTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *array = self.dataSource[indexPath.section];
    
    [cell addSchoolTableViewCellData:[array objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = IKGeneralLightGray;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 30)];
    title.text = self.headerTitle[section];
    title.textColor = IKSubHeadTitleColor;
    title.font = [UIFont systemFontOfSize:15.0f];
    title.textAlignment = NSTextAlignmentLeft;
    [view addSubview:title];
    
    return view;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = self.dataSource[indexPath.section];

    if ([self.delegate respondsToSelector:@selector(companyListViewdidSelectData:)]) {
        [self.delegate companyListViewdidSelectData:[array objectAtIndex:indexPath.row]];
    }
    
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
