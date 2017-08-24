//
//  IKAddSchoolListVc.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAddSchoolListVc.h"

#import "IKBaseInfoTableViewCell.h"
#import "IKResumeSelfIntroductionCell.h"
#import "IKChooseCompanyTableViewCell.h"
#import "LRPickerView.h"
#import "IKAddCertTableViewCell.h"
#import "IKCompanyListView.h"


@interface IKAddSchoolListVc ()<UITableViewDelegate,UITableViewDataSource,IKBaseInfoTableViewCellDelegate,IKChooseCompanyCellDelegate,IKCompanyListViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)IKCompanyListView *companyListView;

@property(nonatomic, assign)BOOL            cellIsEditing;
@property(nonatomic, copy)NSArray           *titleArray;
@property(nonatomic, strong)NSMutableArray  *dataArray;
@property(nonatomic, copy)NSArray  *schoolListData;


@end

@implementation IKAddSchoolListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    
    
    self.titleArray = @[@"认证课程名称",@"开始时间",@"毕业时间",@"是否结业",@"是否获得证书"];
    [self.view addSubview:self.tableView];
    [self initBottomButton];
    [self getSchoolListFromServer];
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
        NSLog(@"commitButtonClick _schoolDict = %@ self.dataArray = %@ ",_schoolDict,self.dataArray);
    
        if ([self.dataArray containsObject:@""]) {
            [LRToastView showTosatWithText:@"请完成所有选项后,再点击确定" inView:self.view];
        }
        else{
            if (self.isAddSchool) {
                if ([self.delegate respondsToSelector:@selector(addSchoolAddNewRecordWithData:)]) {
                    [self.delegate addSchoolAddNewRecordWithData:_schoolDict];
                }
            }
            else{
                if ([self.delegate respondsToSelector:@selector(addSchoolChangeNeedRefreshData:)]) {
                    [self.delegate addSchoolChangeNeedRefreshData:_schoolDict];
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


- (void)setSchoolDict:(NSMutableDictionary *)schoolDict
{
    if (IKDictIsNotEmpty(schoolDict)) {
        NSLog(@"recordDict = %@",schoolDict);
        
        _schoolDict = schoolDict;
        
        [self.dataArray addObject:[self getString:[schoolDict objectForKey:@"name"]]];
        [self.dataArray addObject:[self getString:[schoolDict objectForKey:@"work_name"]]];
        NSString *startTime = [self getString:[schoolDict objectForKey:@"time_start"]];
        NSMutableString *mutableS = [startTime mutableCopy];
        [mutableS insertString:@"-" atIndex:4];
        [self.dataArray addObject:mutableS];
        
        NSString *endTime = [self getString:[schoolDict objectForKey:@"time_end"]];
        if ([endTime isEqualToString:@"-1"]) {
            [self.dataArray addObject:@"至今"];
        }
        else{
            NSMutableString *mutableE = [endTime mutableCopy];
            [mutableE insertString:@"-" atIndex:4];
            [self.dataArray addObject:mutableE];
        }
        
        if ([[schoolDict objectForKey:@"is_graduate"] isEqualToString:@"1"]) {
            [self.dataArray addObject:@"已结业"];
        }
        else{
            [self.dataArray addObject:@"未结业"];
        }
        
        if ([[schoolDict objectForKey:@"has_certificate"] isEqualToString:@"1"]) {
            [self.dataArray addObject:@"有证书"];
            [self.dataArray addObject:@"1"];
        }
        else{
            [self.dataArray addObject:@"无证书"];
            [self.dataArray addObject:@"0"];
        }
    }
}

- (void)setIsAddSchool:(BOOL)isAddSchool
{
    _isAddSchool = isAddSchool;
    
    if (isAddSchool) {
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@"0"];
        
        _schoolDict = [[NSMutableDictionary alloc] init];
        
        [_schoolDict setObject:@"" forKey:@"id"];
        [_schoolDict setObject:@"1" forKey:@"status"];
        [_schoolDict setObject:@"" forKey:@"graduateUrlDetail"];
        [_schoolDict setObject:@"" forKey:@"graduate_url"];
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
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6){
        return 100;
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
    else if (indexPath.row == 6){
        static  NSString *cellId = @"IKAddCertTableViewCellId";
        IKAddCertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKAddCertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([self.dataArray.lastObject isEqualToString:@"1"]) {
            cell.psLabel.text = @"上传证书";
            cell.lineView.hidden = NO;
        }
        else{
            cell.lineView.hidden = YES;
        }
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4 || indexPath.row == 5) {
        return YES;
    }
    else{
        return NO;
    }
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     注意：1、当rowActionWithStyle的值为UITableViewRowActionStyleDestructive时，系统默认背景色为红色；当值为UITableViewRowActionStyleNormal时，背景色默认为淡灰色，可通过UITableViewRowAction的对象的.backgroundColor设置；
     2、当左滑按钮执行的操作涉及数据源和页面的更新时，要先更新数据源，在更新视图，否则会出现无响应的情况
     */
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"是" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.row == 5) {
            NSString *str = self.dataArray[4];
            
            if ([str isEqualToString:@"已结业"]) {
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"有证书"];
                [_schoolDict setObject:@"1" forKey:@"has_certificate"];
                [self.dataArray replaceObjectAtIndex:6 withObject:@"1"];
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
            else{
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"无证书"];
                [LRToastView showTosatWithText:@"未结业时,不可选择是否获取证书" inView:self.view];
                [_schoolDict setObject:@"2" forKey:@"has_certificate"];
                
                if ([self.dataArray.lastObject isEqualToString:@"1"]) {
                    [self.dataArray replaceObjectAtIndex:6 withObject:@"0"];
                    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        }
        else{
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"已结业"];
            [_schoolDict setObject:@"1" forKey:@"is_graduate"];
        }
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        //在block中实现相对应的事件
    }];
    action1.backgroundColor = IKGeneralBlue;
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"否" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.row == 4) {
            [_schoolDict setObject:@"2" forKey:@"is_graduate"];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"未结业"];
        }
        else{
            [_schoolDict setObject:@"2" forKey:@"has_certificate"];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"无证书"];
            
            if ([self.dataArray.lastObject isEqualToString:@"1"]) {
                [self.dataArray replaceObjectAtIndex:6 withObject:@"0"];
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    //    action2.backgroundColor = IKGeneralLightGray;
    //此处UITableViewRowAction对象放入的顺序决定了对应按钮在cell中的顺序
    return@[action2,action1];
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
            
            [_schoolDict setObject:text forKey:@"time_start"];
            
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            [text insertString:@"-" atIndex:4];
            cell.textField.text = text;
            
            if (self.isAddSchool) {
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
            [_schoolDict setObject:setValue forKey:@"time_end"];
            
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            cell.textField.text = text;
            
            if (self.isAddSchool) {
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
        [_schoolDict setObject:text forKey:@"work_name"];
    }
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
        [_schoolDict setObject:text forKey:@"name"];
    }
    
}

- (IKCompanyListView *)companyListView
{
    if (_companyListView == nil) {
        _companyListView = [[IKCompanyListView alloc] initWithFrame:CGRectMake(0, 124, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 124)];
        _companyListView.headerTitle = @[@"教练培训",@"经管培训"];
        _companyListView.dataSource = self.schoolListData;
        _companyListView.delegate = self;
    }
    return _companyListView;
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


#pragma mark - IKCompanyListViewDelegate

- (void)companyListViewdidSelectData:(IKSchoolListModel *)model
{
    NSLog(@"model = %@",model);
    
    [self.dataArray replaceObjectAtIndex:0 withObject:model.name];
    
    [_schoolDict setObject:model.Id forKey:@"school_id"];
    [_schoolDict setObject:model.logoImageUrl forKey:@"school_logo"];
    [_schoolDict setObject:model.name forKey:@"school_name"];
    [_schoolDict setObject:model.name forKey:@"name"];

    IKChooseCompanyTableViewCell *cell = (IKChooseCompanyTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.textField.text = model.name;
    
}

- (void)getSchoolListFromServer
{
    [[IKNetworkManager shareInstance] getMyResumeSchoolListDataWithType:@"4,5" backData:^(NSArray *dataArray, BOOL success) {
        self.schoolListData = [NSArray arrayWithObjects:dataArray[3],dataArray[4], nil];
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
