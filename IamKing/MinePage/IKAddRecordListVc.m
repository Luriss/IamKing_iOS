//
//  IKAddRecordListVc.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAddRecordListVc.h"
#import "IKBaseInfoTableViewCell.h"
#import "IKResumeSelfIntroductionCell.h"
#import "IKChooseCompanyTableViewCell.h"
#import "LRPickerView.h"
#import "IKCompanyListView.h"


@interface IKAddRecordListVc ()<UITableViewDelegate,UITableViewDataSource,IKBaseInfoTableViewCellDelegate,IKResumeSelfIntroductionCellDelegate,IKChooseCompanyCellDelegate,IKCompanyListViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)BOOL         cellIsEditing;
@property(nonatomic, copy)NSArray       *titleArray;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)IKCompanyListView *companyListView;
@property(nonatomic, copy)NSArray  *schoolListData;


@end

@implementation IKAddRecordListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    
    
    self.titleArray = @[@"担任的职位",@"入职时间",@"离职时间",@"工作内容"];
    [self.view addSubview:self.tableView];
    [self initBottomButton];
    
    [self getRecordSchoolListFromServer];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"编辑工作经历";
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


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64 - 60) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.rowHeight = 50;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1)];
        line.backgroundColor= IKLineColor;
        [_tableView addSubview:line];
    }
    return _tableView;
}


- (void)initBottomButton
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, IKSCREENH_HEIGHT - 60, IKSCREEN_WIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1)];
    line.backgroundColor = IKLineColor;
    [view addSubview:line];
    
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(20, 10, 110, 40);
    [cancel addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    [cancel setTitleColor:IKButtonClickColor forState:UIControlStateHighlighted];
    cancel.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    cancel.layer.cornerRadius = 6;
    cancel.layer.masksToBounds = YES;
    cancel.layer.borderColor = IKGeneralBlue.CGColor;
    cancel.layer.borderWidth = 1.0f;
    
    [view addSubview:cancel];
    
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(150, cancel.frame.origin.y, IKSCREEN_WIDTH - 170, 40);
    [commit addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [commit setTitle:@"确定" forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commit.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    commit.layer.cornerRadius = 6;
    commit.layer.masksToBounds = YES;
    commit.backgroundColor = IKGeneralBlue;
    [commit setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    
    [view addSubview:commit];
}


- (void)cancelButtonClick:(UIButton *)button
{
    [self backButtonClick:nil];
}


- (void)commitButtonClick:(UIButton *)button
{
    NSLog(@"commitButtonClick  = %@ isAddRecord = %d",_recordDict,self.isAddRecord);

    if ([self.dataArray containsObject:@""]) {
        [LRToastView showTosatWithText:@"请完成所有选项后,再点击确定" inView:self.view];
    }
    else{
        if (self.isAddRecord) {
            if ([self.delegate respondsToSelector:@selector(addRecordAddNewRecordWithData:)]) {
                [self.delegate addRecordAddNewRecordWithData:_recordDict];
            }
        }
        else{
            if ([self.delegate respondsToSelector:@selector(addRecordChangeNeedRefreshData:)]) {
                [self.delegate addRecordChangeNeedRefreshData:_recordDict];
            }
        }
        
        [self backButtonClick:nil];
    }
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}

- (void)setRecordDict:(NSMutableDictionary *)recordDict
{
    if (IKDictIsNotEmpty(recordDict)) {
        NSLog(@"recordDict = %@",recordDict);
        
        _recordDict = recordDict;
        
        [self.dataArray addObject:[self getString:[recordDict objectForKey:@"company_name"]]];
        [self.dataArray addObject:[self getString:[recordDict objectForKey:@"work_name"]]];
        NSString *startTime = [self getString:[recordDict objectForKey:@"time_start"]];
        NSMutableString *mutableS = [startTime mutableCopy];
        [mutableS insertString:@"-" atIndex:4];
        [self.dataArray addObject:mutableS];
        
        NSString *endTime = [self getString:[recordDict objectForKey:@"time_end"]];
        if ([endTime isEqualToString:@"-1"]) {
            [self.dataArray addObject:@"至今"];
        }
        else{
            NSMutableString *mutableE = [endTime mutableCopy];
            [mutableE insertString:@"-" atIndex:4];
            [self.dataArray addObject:mutableE];
        }
        
        
        [self.dataArray addObject:[self getString:[recordDict objectForKey:@"content"]]];
    }
}

- (void)setIsAddRecord:(BOOL)isAddRecord
{
    _isAddRecord = isAddRecord;
    
    if (isAddRecord) {
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        
        _recordDict = [[NSMutableDictionary alloc] init];
        
        [_recordDict setObject:@"" forKey:@"id"];
        [_recordDict setObject:@"1" forKey:@"status"];
    }
}


- (NSString *)getString:(id)object
{
    NSString *str = [NSString stringWithFormat:@"%@",object];
    
    if (IKStringIsEmpty(str)) {
        return @"";
    }
    else{
        return str;
    }
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4){
        return 200;
    }
    else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        static  NSString *cellId = @"IKChooseCompanyTableViewCellId";
        IKChooseCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKChooseCompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.text = self.dataArray.firstObject;
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.row == 4){
        IKResumeSelfIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IKResumeSelfIntroductionCellId"];
        
        if(cell == nil){
            cell = [[IKResumeSelfIntroductionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IKResumeSelfIntroductionCellId"];
        }
        cell.textViewText = self.dataArray.lastObject;
        cell.textViewTextColor = IKMainTitleColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = self.titleArray.lastObject;
        cell.delegate = self;
        return cell;
    }
    else{
        IKBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IKBaseInfoTableViewCellId"];
        
        if(cell == nil){
            cell = [[IKBaseInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IKBaseInfoTableViewCellId"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.text = self.titleArray[indexPath.row-1];
        cell.textField.text = self.dataArray[indexPath.row];
        cell.textField.textAlignment = NSTextAlignmentRight;
        cell.textField.textColor = IKMainTitleColor;

        if (row == 1) {
            cell.textField.userInteractionEnabled = YES;
        }
        else{
            cell.textField.userInteractionEnabled = NO;
        }
        cell.delegate = self;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.cellIsEditing) {
        [IKNotificationCenter postNotificationName:@"IKBaseInfoCellNeedHideKeyborad" object:nil];
        self.cellIsEditing = NO;
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (indexPath.row == 0) {

    }
    else if (indexPath.row == 1){
        
    }
    else if (indexPath.row == 2){
        NSArray *data1 = @[@"2000",@"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017"];
        NSArray *data2 = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
        LRPickerView *pickerView = [[LRPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
        pickerView.dataSource = @[data1,data2];
        
        
        [pickerView showWithSelectedResultBlock:^(NSString *value1, NSString *value2) {
            NSMutableString *text = [NSMutableString stringWithFormat:@"%@%@",value1,value2];
            
            [_recordDict setObject:text forKey:@"time_start"];
            
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            [text insertString:@"-" atIndex:4];
            cell.textField.text = text;
            
            if (self.isAddRecord) {
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:text];
            }
        }];
    }
    else if (indexPath.row == 3){
        NSArray *data1 = @[@"2000",@"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"至今"];
        NSArray *data2 = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];

        LRPickerView *pickerView = [[LRPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
        pickerView.dataSource = @[data1,data2];
        
        [pickerView showWithSelectedResultBlock:^(NSString *value1, NSString *value2) {
            NSString *text = nil;
            NSString *setValue = nil;
            if ([value1 isEqualToString:@"至今"]) {
                text = @"至今";
                setValue = @"-1";
            }
            else{
                setValue = [NSString stringWithFormat:@"%@%@",value1,value2];
                text = [NSString stringWithFormat:@"%@-%@",value1,value2];
            }
            [_recordDict setObject:setValue forKey:@"time_end"];
            
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            cell.textField.text = text;

            if (self.isAddRecord) {
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:text];
            }
            
        }];
    }
    else{
        
    }
}



#pragma mark - IKBaseInfoTableViewCellDelegate

- (void)textFieldBeginEditingNeedAjustkeyBorad:(BOOL)isNeed
{
    self.cellIsEditing = YES;
}

- (void)textFieldEndEditingWithText:(NSString *)text
{
    if (IKStringIsNotEmpty(text)) {
        [self.dataArray replaceObjectAtIndex:1 withObject:text];
        [_recordDict setObject:text forKey:@"work_name"];
    }
}

#pragma mark - IKResumeSelfIntroductionCellDelegate

- (void)textViewBeginEditingNeedAjustkeyBorad:(BOOL)isNeed
{
    [self.tableView setContentOffset:CGPointMake(0, 100) animated:YES];

    self.cellIsEditing = YES;
}

- (void)textViewDidEndEditingWithText:(NSString *)text
{
    NSLog(@"texttt = %@",text);
    if (IKStringIsNotEmpty(text)) {
        [_dataArray replaceObjectAtIndex:4 withObject:text];
        [_recordDict setObject:text forKey:@"content"];
    }
    
}

- (void)textViewShouldReturnButtonClick
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - IKChooseCompanyCellDelegate

- (void)textFieldBeginEditing
{
    self.cellIsEditing = YES;
}

- (void)textFieldEditingChangedWithText:(NSString *)text
{
    NSLog(@"text = %@",text);
}

- (void)companyTextFieldEndEditingWithText:(NSString *)text
{
    NSLog(@"texttext = %@",text);
    if (IKStringIsNotEmpty(text)) {
        [_dataArray replaceObjectAtIndex:0 withObject:text];
        [_recordDict setObject:text forKey:@"company_name"];
    }
    
}


- (void)showCompanyListView:(BOOL)isShow
{
    if (isShow) {
        NSLog(@"schoolListData = %ld",self.schoolListData.count);
        [self.view addSubview:self.companyListView];
        [self.view bringSubviewToFront:self.companyListView];
    }
    else{
        [self.companyListView removeFromSuperview];
        self.companyListView = nil;
    }
}

- (IKCompanyListView *)companyListView
{
    if (_companyListView == nil) {
        _companyListView = [[IKCompanyListView alloc] initWithFrame:CGRectMake(0, 124, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 124)];
        _companyListView.headerTitle = @[@"大型连锁健身俱乐部",@"小型连锁特色健身房",@"新型健身工作室",@"教练培训",@"经管培训",@"器械设备供应商",@"媒体资讯",@"会展/活动/赛事",@"互联网",@"其他"];
        _companyListView.dataSource = self.schoolListData;
        _companyListView.delegate = self;
    }
    return _companyListView;
}

- (void)companyListViewdidSelectData:(IKSchoolListModel *)model
{
    NSLog(@"model = %@",model);
    
    [self.dataArray replaceObjectAtIndex:0 withObject:model.name];

    [_recordDict setObject:model.Id forKey:@"school_id"];
    [_recordDict setObject:model.logoImageUrl forKey:@"school_logo"];
    [_recordDict setObject:model.name forKey:@"school_name"];
    [_recordDict setObject:model.name forKey:@"company_name"];
    
    IKChooseCompanyTableViewCell *cell = (IKChooseCompanyTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.textField.text = model.name;
    
}

- (void)getRecordSchoolListFromServer
{
    [[IKNetworkManager shareInstance] getMyResumeSchoolListDataWithType:@"" backData:^(NSArray *dataArray, BOOL success) {
        self.schoolListData = [NSArray arrayWithArray:dataArray];
    }];
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
