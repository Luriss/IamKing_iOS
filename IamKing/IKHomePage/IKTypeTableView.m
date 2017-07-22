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


- (void)setDelegate:(id<IKTypeTableViewDelegate>)delegate
{
    _delegate = delegate;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
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
    [cell addCellData];
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
