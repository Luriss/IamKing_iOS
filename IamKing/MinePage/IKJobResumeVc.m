//
//  IKJobResumeVc.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobResumeVc.h"
#import "IKResumeModel.h"
#import "IKResumeLogoTableViewCell.h"
#import "IKBaseInfoTableViewCell.h"
#import "IKPickerView.h"
#import "IKAlertView.h"
#import "IKResumeSelfIntroductionCell.h"
#import "IKProvinceModel.h"
#import "IKMultiPickerView.h"
#import "IKJobTypeModel.h"
#import "IKChildJobTypeModel.h"
#import "IKResumeSkillTableViewCell.h"
#import "IKAlertView.h"
#import "IKResumeAddSkillTableViewCell.h"
#import "IKAddSkillVc.h"
#import "IKWorkListTableViewCell.h"
#import "IKAddRecordListVc.h"
#import "IKSchoolListTableViewCell.h"
#import "IKAddSchoolListVc.h"
#import "IKAddPhotoTableViewCell.h"


extern NSString * loginUserId;

@interface IKJobResumeVc ()<UITableViewDelegate,UITableViewDataSource,IKBaseInfoTableViewCellDelegate,IKAlertViewDelegate,IKResumeSelfIntroductionCellDelegate,IKResumeSkillTableViewCellDelegate,IKAddSkillVcDelegate,IKWorkListTableViewCellDelegate,IKAddRecordListVcDelegate,IKSchoolListTableViewCellDelegate,IKAddSchoolListVcDelegate>
{
    BOOL            _isShowAddTag;
    NSIndexPath    *_editSelectedSkillIP;
    NSIndexPath    *_editSelectedRecordIP;
    NSIndexPath    *_editSelectedSchoolIP;

}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray       *headerTitle;
@property(nonatomic, copy)NSArray       *baseInfoTitle;
@property(nonatomic, copy)NSArray       *baseInfoData;
@property(nonatomic, copy)NSArray       *hopeWorkTitle;
@property(nonatomic, copy)NSArray       *hopeWorkData;
@property(nonatomic, copy)NSMutableDictionary       *cityIdDict;
@property(nonatomic, copy)NSArray       *provinceCityArray;
@property(nonatomic, copy)NSArray       *jobTypeArray;
@property(nonatomic, copy)NSArray       *workList;
@property(nonatomic, strong)NSMutableArray       *tagList;
@property(nonatomic, strong)NSMutableArray       *recordList;
@property(nonatomic, strong)NSMutableArray       *schoolList;

@property(nonatomic, assign)BOOL         cellIsEditing;

@property(nonatomic, strong)IKResumeModel     *resumeModel;
@property(nonatomic, strong)IKJobTypeModel    *selectedJobTypeModel;
@property(nonatomic, strong)NSDictionary       *selectedchildJobTypeDict;

@end

@implementation IKJobResumeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavTitle];
    [self initLeftBackItem];
    
    _isShowAddTag = NO;

    // Do any additional setup after loading the view.
    self.headerTitle = @[@"基本信息",@"期望工作",@"认证/技能",@"工作履历",@"学习经历",@"职业形象"];
    self.baseInfoTitle = @[@"真实姓名",@"性别",@"出生年份",@"最高学历",@"健身行业从业时间",@"手机号码",@"任职状态"];
    self.hopeWorkTitle = @[@"公司类型",@"期望职位",@"期望城市",@"期望薪资"];
    
    [self getDataFromServer];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"我的简历";
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

- (NSMutableDictionary *)cityIdDict
{
    if (_cityIdDict == nil) {
        _cityIdDict = [[NSMutableDictionary alloc] init];
    }
    return _cityIdDict;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64 - 60) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = IKGeneralLightGray;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
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
    IKAlertView *alert = [[IKAlertView alloc] initWithTitle:@"放弃完善简历" message:@"确定要放弃完善您的简历吗？点击确定后您所填写的所有资料将不保存，请谨慎操作。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}


- (void)commitButtonClick:(UIButton *)button
{
    
}

- (void)alertView:(IKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self backButtonClick:nil];
    }
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    }
    else if (section == 1){
        return 4;
    }
    else if (section == 2){
        NSInteger count = self.tagList.count;
        NSLog(@"count = %ld",count);
        if (count == 3) {
            _isShowAddTag = NO;
            return 4;
        }
        else{
            _isShowAddTag = YES;
            return count + 1;
        }
    }
    else if (section == 3){
        NSInteger count = self.recordList.count;
        if (count == 3) {
            return 4;
        }
        else{
            return count + 1;
        }
    }
    else if (section == 4){
        NSInteger count = self.schoolList.count;
        if (count == 3) {
            return 4;
        }
        else{
            return count + 1;
        }
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            return 80;
        }
        else if (row == 8){
            return 200;
        }
        else{
            return 50;
        }
    }
    else if (section == 1){
        return 50;
    }
    else if (section == 2){
        NSInteger count = self.tagList.count;
        if (count == 3) {
            if (indexPath.row == 3) {
                return 0;
            }
            return 80;
        }
        else {
            if (row < count) {
                return 80;
            }
            else{
                return 50;
            }
        }
    }
    else if (section == 3){
        NSInteger count = self.recordList.count;
        if (count == 3) {
            if (indexPath.row == 3) {
                return 0;
            }
            return 130;
        }
        else {
            if (row < count) {
                return 130;
            }
            else{
                return 50;
            }
        }
    }
    else if (section == 4){
        NSInteger count = self.schoolList.count;
        if (count == 3) {
            if (indexPath.row == 3) {
                return 0;
            }
            return 110;
        }
        else {
            if (row < count) {
                return 110;
            }
            else{
                return 50;
            }
        }
    }
    else if (section == 5){
        return 180;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static  NSString *logoCellId = @"IKResumeLogoTableViewCellId";
    static  NSString *selfIntroCellId = @"IIKResumeSelfIntroductionCellId";
    static  NSString *baseInfoCellId = @"IKBaseInfoTableViewCellId";
    static  NSString *sikllCellId = @"IKResumeSkillTableViewCell";

    if (section == 0) {
        if (row == 0) {
            IKResumeLogoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:logoCellId];
            
            if(cell == nil){
                cell = [[IKResumeLogoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logoCellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addLogoTableViewCellData:_resumeModel.headerImageUrl];
            return cell;
        }
        else if (row == 8){
            IKResumeSelfIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:selfIntroCellId];
            
            if(cell == nil){
                cell = [[IKResumeSelfIntroductionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selfIntroCellId];
            }
            cell.textViewText = _resumeModel.introduce;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
        else{
            IKBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseInfoCellId];
            
            if(cell == nil){
                cell = [[IKBaseInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseInfoCellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.text = self.baseInfoTitle[row-1];
            cell.textField.text = self.baseInfoData[row-1];
            if (row == 1 || row == 6) {
                cell.textField.userInteractionEnabled = YES;
            }
            else{
                cell.textField.userInteractionEnabled = NO;
            }
            cell.delegate = self;
            return cell;
        }
    }
    else if (section == 1){
        IKBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseInfoCellId];
        
        if(cell == nil){
            cell = [[IKBaseInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseInfoCellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.text = self.hopeWorkTitle[row];
        cell.textField.text = self.hopeWorkData[row];
        cell.textField.userInteractionEnabled = NO;
//        cell.delegate = self;
        return cell;
    }
    else if (section == 2){
        NSInteger count = self.tagList.count;
        if (row < count) {
            IKResumeSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sikllCellId];
            
            if(cell == nil){
                cell = [[IKResumeSkillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sikllCellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell addResumeSkillCellData:[self.tagList objectAtIndex:row]];
            return cell;
        }
        else{
            static  NSString *cellId = @"IKResumeAddSkillTableViewCellId";
            IKResumeAddSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKResumeAddSkillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.psLabel.text = @"添加认证/技能";
            return cell;
        }
    }
    else if (section == 3){
        NSInteger count = self.recordList.count;
        if (row < count) {
            static  NSString *cellId = @"IKWorkListTableViewCellId";
            IKWorkListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKWorkListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell addResumeWorkListCellData:self.recordList[row]];
            return cell;
        }
        else{
            static  NSString *cellId = @"IKResumeAddSkillTableViewCellId";
            IKResumeAddSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKResumeAddSkillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.psLabel.text = @"添加工作履历";

            return cell;
        }
    }
    else if (section == 4){
        NSInteger count = self.schoolList.count;
        if (row < count) {
            static  NSString *cellId = @"IKSchoolListTableViewCellId";
            IKSchoolListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKSchoolListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell addResumeSchoolListCellData:self.schoolList[row]];
            return cell;
        }
        else{
            static  NSString *cellId = @"IKResumeAddSkillTableViewCellId";
            IKResumeAddSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKResumeAddSkillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.psLabel.text = @"添加学习经历";
            
            return cell;
        }
    }
    else{
        static  NSString *cellId = @"IKAddPhotoTableViewCellId";
        IKAddPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKAddPhotoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataArray = _resumeModel.showUrl;
        return cell;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 50)];
    view.backgroundColor = IKGeneralLightGray;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, (section == 2)?75:70, 50)];
    titleLabel.text = self.headerTitle[section];
    titleLabel.textColor = IKMainTitleColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLabel];
    
    CGFloat psW = 50;
    NSString *psString = @"非必填";
    if (section == 0 || section == 1) {
        psW = 40;
        psString = @"必填";
    }
    
    UILabel *psLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + titleLabel.frame.size.width,17, psW, 16)];
    psLabel.text = psString;
    psLabel.textColor = IKGeneralRed;
    psLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    psLabel.textAlignment = NSTextAlignmentCenter;
    psLabel.layer.cornerRadius = 8;
    psLabel.layer.borderColor = IKGeneralRed.CGColor;
    psLabel.layer.borderWidth = 1;
    psLabel.layer.masksToBounds = YES;
    [view addSubview:psLabel];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.cellIsEditing) {
        [IKNotificationCenter postNotificationName:@"IKBaseInfoCellNeedHideKeyborad" object:nil];
        self.cellIsEditing = NO;
    }
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 2) {
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSArray *data = @[@"男",@"女"];
            IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.dataSource = data;
            pickerView.defaultSelectedRow = [data indexOfObject:cell.textField.text];

            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
                cell.textField.text = selectedValue;
            }];
        }
        else if (row == 3) {
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSArray *data = @[@"2000",@"1999",@"1998",@"1997",@"1996",@"1995",@"1994",@"1993",@"1992",@"1991",@"1990",@"1989",@"1988",@"1987",@"1986",@"1985",@"1984",@"1983",@"1982",@"1981",@"1980",@"1979",@"1978",@"1977", @"1976",@"1975", @"1974",@"1973",@"1972",@"1971",@"1970",@"1969",@"1968",@"1967",@"1966",@"1965",@"1964",@"1963",@"1962",@"1961",@"1960"];
            IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.dataSource = data;
            pickerView.defaultSelectedRow = [data indexOfObject:cell.textField.text];

            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
                cell.textField.text = selectedValue;
            }];
        }
        else if (row == 4) {
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSArray *data = @[@"大专",@"本科",@"硕士",@"博士",@"其他"];
            IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.dataSource = data;
            pickerView.defaultSelectedRow = [data indexOfObject:cell.textField.text];

            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
                cell.textField.text = selectedValue;
            }];
        }
        else if (row == 5){
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSArray *data = @[@"1年以下",@"1~2年",@"3~5年",@"6~8年",@"8~10年",@"10年以上"];
            IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.dataSource = data;
            pickerView.defaultSelectedRow = [data indexOfObject:cell.textField.text];

            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
                cell.textField.text = selectedValue;
            }];
        }
        else if (row == 7){
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSArray *data = @[@"离职",@"在职"];
            IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.dataSource = data;
            pickerView.defaultSelectedRow = [data indexOfObject:cell.textField.text];

            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
                cell.textField.text = selectedValue;
            }];
        }
    }
    else if (section == 1){
        if (row == 0) {
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSArray *data = @[@"俱乐部",@"工作室",@"瑜伽馆",@"教育培训",@"器械设备",@"媒体资讯",@"会展/活动/赛事",@"互联网",@"其他"];
            IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.dataSource = data;
            pickerView.defaultSelectedRow = [data indexOfObject:cell.textField.text];

            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
                cell.textField.text = selectedValue;
            }];
        }
        else if (row == 1){
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            IKMultiPickerView *pickerView = [[IKMultiPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.numberOfComponents = 3;
            pickerView.dataSource = self.jobTypeArray.firstObject;
            pickerView.dataSource2 = self.jobTypeArray[1];
            pickerView.dataSource3 = self.jobTypeArray.lastObject;
            
            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue, NSInteger component1, NSInteger component2, NSInteger component3) {
                if (selectedValue.length > 0) {
                    cell.textField.text = selectedValue;
                }
                
                self.selectedJobTypeModel = (IKJobTypeModel *)self.workList[component1];
                
                self.selectedchildJobTypeDict = self.selectedJobTypeModel.childType[component2];

            }];
        }
        else if (row == 2){
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            IKMultiPickerView *pickerView = [[IKMultiPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.numberOfComponents = 2;
            pickerView.dataSource = self.provinceCityArray.firstObject;
            pickerView.dataSource2 = self.provinceCityArray.lastObject;
            
            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue, NSInteger component1, NSInteger component2, NSInteger component3) {
                if (selectedValue.length > 0) {
                    cell.textField.text = selectedValue;
                }
                NSLog(@"component1 = %ld,component2 = %ld,component3 = %ld",component1,component2,component3);
            }];
        }
        else if (row == 3){
            IKBaseInfoTableViewCell *cell = (IKBaseInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSArray *data = @[@"3~5K",@"6~8K",@"9~12K",@"13~18K",@"19~25K",@"26~30K",@"31~40K",@"41~50K",@"50K以上"];
            IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
            pickerView.dataSource = data;
            pickerView.defaultSelectedRow = [data indexOfObject:cell.textField.text];
            
            [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
                cell.textField.text = selectedValue;
            }];
        }

    }
    else if (section == 2){
        if (row == self.tagList.count) {
            IKAddSkillVc *addSkill = [[IKAddSkillVc alloc] init];
            addSkill.isAddSkill = YES;
            addSkill.childTypeDict = self.selectedchildJobTypeDict;
            addSkill.delegate = self;
            [self.navigationController pushViewController:addSkill animated:YES];
        }
    }
    else if (section == 3){
        if (row == self.recordList.count) {
            IKAddRecordListVc *addRecord = [[IKAddRecordListVc alloc] init];
            addRecord.isAddRecord = YES;
            addRecord.delegate = self;
            [self.navigationController pushViewController:addRecord animated:YES];
        }
    }
    else if (section == 4){
        if (row == self.schoolList.count) {
            IKAddSchoolListVc *addSchool = [[IKAddSchoolListVc alloc] init];
            addSchool.isAddSchool = YES;
            addSchool.delegate = self;
            [self.navigationController pushViewController:addSchool animated:YES];
        }
    }
    
    NSLog(@"didSelectRowAtIndexPath");
}


#pragma mark - IKBaseInfoTableViewCellDelegate

- (void)textFieldBeginEditingNeedAjustkeyBorad:(BOOL)isNeed
{
    if (isNeed) {
        [self.tableView setContentOffset:CGPointMake(0, 200) animated:YES];
    }
    self.cellIsEditing = YES;
}

- (void)textFieldEndEditingWithText:(NSString *)text
{
    
}

#pragma mark - IKResumeSelfIntroductionCellDelegate

- (void)textViewBeginEditingNeedAjustkeyBorad:(BOOL)isNeed
{
    if (isNeed) {
        [self.tableView setContentOffset:CGPointMake(0, 400) animated:YES];
    }
    self.cellIsEditing = YES;
}

- (void)textViewDidEndEditingWithText:(NSString *)text
{
    
}

- (void)textViewShouldReturnButtonClick
{
    
}

#pragma mark - IKResumeSkillTableViewCellDelegate

- (void)resumeSkillCellEditButtonClickWithData:(NSDictionary *)dict cell:(IKResumeSkillTableViewCell *)cell
{
    NSLog(@"resumeSkillCellEditButtonClick");
    dispatch_async(dispatch_get_main_queue(), ^{
        _editSelectedSkillIP = [self.tableView indexPathForCell:cell];
        IKAddSkillVc *addSkill = [[IKAddSkillVc alloc] init];
        addSkill.isAddSkill = NO;
        addSkill.skillDict = [dict mutableCopy];
        addSkill.childTypeDict = self.selectedchildJobTypeDict;
        addSkill.delegate = self;
        [self.navigationController pushViewController:addSkill animated:YES];
    });
}

- (void)resumeSkillCellDeleteButtonClick:(IKResumeSkillTableViewCell *)cell
{
    NSLog(@"resumeSkillCellDeleteButtonClick");
    
    IKAlertView *alert = [[IKAlertView alloc] initWithTitle:@"删除技能" message:@"确定删除该技能?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showWithCallBack:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                
                [self.tagList removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
    }];
    

}

#pragma mark - IKAddSkillVcDelegate

- (void)addSkillChangeNeedRefreshData:(NSDictionary *)dict
{
    [self.tagList replaceObjectAtIndex:_editSelectedSkillIP.row withObject:dict];
    
    [self.tableView reloadRowsAtIndexPaths:@[_editSelectedSkillIP] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)addSkillAddNewSkillWithData:(NSDictionary *)dict
{
    [self.tagList addObject:dict];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - IKWorkListTableViewCellDelegate

- (void)resumeWorkListCellDeleteButtonClick:(IKWorkListTableViewCell *)cell
{
    IKAlertView *alert = [[IKAlertView alloc] initWithTitle:@"删除履历" message:@"确定删除该履历?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showWithCallBack:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                
                [self.recordList removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
    }];
}


- (void)resumeWorkListCellEditButtonClickWithData:(NSDictionary *)dict cell:(IKWorkListTableViewCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _editSelectedRecordIP = [self.tableView indexPathForCell:cell];

        IKAddRecordListVc *addRecord = [[IKAddRecordListVc alloc] init];
        addRecord.recordDict = [dict mutableCopy];
        addRecord.isAddRecord = NO;
        addRecord.delegate = self;
        [self.navigationController pushViewController:addRecord animated:YES];
    });
}

#pragma mark - IKWorkListTableViewCellDelegate
- (void)resumeSchoolListCellDeleteButtonClick:(IKSchoolListTableViewCell *)cell
{
    IKAlertView *alert = [[IKAlertView alloc] initWithTitle:@"删除学习经历" message:@"确定删除该学习经历?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showWithCallBack:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                
                [self.schoolList removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
    }];

}

- (void)resumeSchoolListCellEditButtonClickWithData:(NSDictionary *)dict cell:(IKSchoolListTableViewCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _editSelectedSchoolIP = [self.tableView indexPathForCell:cell];

        IKAddSchoolListVc *addSchool = [[IKAddSchoolListVc alloc] init];
        addSchool.schoolDict = [dict mutableCopy];
        addSchool.isAddSchool = NO;
        addSchool.delegate = self;
        [self.navigationController pushViewController:addSchool animated:YES];
    });
}

#pragma mark - IKAddRecordListVcDelegate

- (void)addRecordAddNewRecordWithData:(NSDictionary *)dict
{
    [self.recordList addObject:dict];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)addRecordChangeNeedRefreshData:(NSDictionary *)dict
{
    [self.recordList replaceObjectAtIndex:_editSelectedRecordIP.row withObject:dict];
    
    [self.tableView reloadRowsAtIndexPaths:@[_editSelectedRecordIP] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - IKAddSchoolListVcDelegate

- (void)addSchoolAddNewRecordWithData:(NSDictionary *)dict
{
    [self.schoolList addObject:dict];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addSchoolChangeNeedRefreshData:(NSDictionary *)dict
{
    [self.schoolList replaceObjectAtIndex:_editSelectedSchoolIP.row withObject:dict];
    
    [self.tableView reloadRowsAtIndexPaths:@[_editSelectedSchoolIP] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Network

- (void)getDataFromServer
{
    [[IKNetworkManager shareInstance] getMyResumeDataWithId:loginUserId backData:^(IKResumeModel *model, BOOL success) {
        if (success && model) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.resumeModel = model;
                self.baseInfoData = @[model.name,model.sex,model.birthYear,model.educationTypeName,model.experienceTypeName,model.tel,model.workStatus];
                self.hopeWorkData = @[model.companyTypeName,model.workName,model.cityName,model.salaryTypeName];
                self.tagList = [NSMutableArray arrayWithArray:_resumeModel.tagList];
                self.recordList = [NSMutableArray arrayWithArray:_resumeModel.workList];
                self.schoolList = [NSMutableArray arrayWithArray:_resumeModel.schoolList];
                if (_tableView == nil) {
                    [self.view addSubview:self.tableView];
                    [self initBottomButton];
                    
                    [self getHomePageWorkListData];
                }
            });
        }
    }];
    
    [[IKNetworkManager shareInstance] getHotCityDataAndProvinceDataFromChahe:^(NSArray *hotCity, NSArray *province) {
        
        NSMutableArray *pro = [NSMutableArray arrayWithCapacity:province.count];
        NSMutableArray *city = [NSMutableArray arrayWithCapacity:province.count];
        
        for (IKProvinceModel *model in province) {
            [pro addObject:model.provinceName];
            
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:model.childCity.count];
            
            for (int i = 0; i < model.childCity.count; i ++) {
                NSDictionary *dict = (NSDictionary *)[model.childCity objectAtIndex:i];
                NSString *city = [dict objectForKey:@"text"];
                [data addObject:city];
                [self.cityIdDict setObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"value"]] forKey:city];
            }
            [city addObject:data];
        }
        self.provinceCityArray = [NSArray arrayWithObjects:pro,city, nil];
    }];
    
    
}


- (void)getHomePageWorkListData
{
    [[IKNetworkManager shareInstance] getHomePageWorkListDataWithBackData:^(NSArray *dataArray, BOOL success) {
        
        self.workList = [NSArray arrayWithArray:dataArray];
        
        NSMutableArray *titleArray1 = [NSMutableArray arrayWithCapacity:dataArray.count];
        NSMutableArray *titleArray2 = [NSMutableArray arrayWithCapacity:dataArray.count];
        NSMutableArray *titleArray3 = [NSMutableArray arrayWithCapacity:dataArray.count];
        
        for (int i = 0; i < dataArray.count; i ++) {
            IKJobTypeModel *model = (IKJobTypeModel *)[dataArray objectAtIndex:i];
            // 一级类型
            [titleArray1 addObject:model.JobName];
            if ([model.jobId isEqualToString:_resumeModel.parentWorkClassId]) {
                self.selectedJobTypeModel = model;
            }
            
            NSMutableArray *childArray = [NSMutableArray arrayWithCapacity:model.childType.count];
            NSMutableArray *sildeArray = [[NSMutableArray alloc] init];
            NSMutableArray *workA = [[NSMutableArray alloc] init];
            
            for (int j = 0; j < model.childType.count; j ++) {
                NSDictionary *dict = (NSDictionary *)[model.childType objectAtIndex:j];
                
                IKChildJobTypeModel *childModel = [[IKChildJobTypeModel alloc] init];
                childModel.childJobName = [dict objectForKey:@"name"];
                childModel.cJobId = [dict objectForKey:@"id"];
                // 二级类型
                [sildeArray addObject:childModel.childJobName];
                childModel.skillList = (NSArray *)[dict objectForKey:@"skillList"];
                childModel.workList = (NSArray *)[dict objectForKey:@"workList"];
                
                if ([childModel.cJobId isEqualToString:_resumeModel.workClassId]) {
                    self.selectedchildJobTypeDict = [dict copy];
                }
                NSMutableArray *workArray = [NSMutableArray arrayWithCapacity:childModel.workList.count];
                
                // 三级类型
                for (int k = 0; k < childModel.workList.count; k ++) {
                    NSDictionary *workDic = [childModel.workList objectAtIndex:k];
                    [workArray addObject:[workDic objectForKey:@"name"]];
                }
                
                [workA addObject:workArray];
                [childArray addObject:childModel];
            }
            
            [titleArray2 addObject:sildeArray];
            [titleArray3 addObject:workA];
        }
        self.jobTypeArray = [NSArray arrayWithObjects:titleArray1,titleArray2,titleArray3, nil];
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
