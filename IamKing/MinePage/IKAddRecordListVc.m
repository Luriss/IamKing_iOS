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


@interface IKAddRecordListVc ()<UITableViewDelegate,UITableViewDataSource,IKBaseInfoTableViewCellDelegate,IKResumeSelfIntroductionCellDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)BOOL         cellIsEditing;
@property(nonatomic, copy)NSArray       *titleArray;
@property(nonatomic, strong)NSMutableArray *dataArray;


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
//    NSLog(@"commitButtonClick  = %@ self.isAddSkill = %d",_skillDict,self.isAddSkill);
//
//    if ([self.dataArray containsObject:@""]) {
//        [LRToastView showTosatWithText:@"请完成所有选项后,再点击确定" inView:self.view];
//    }
//    else{
//        if (self.isAddSkill) {
//            if ([self.delegate respondsToSelector:@selector(addSkillAddNewSkillWithData:)]) {
//                [self.delegate addSkillAddNewSkillWithData:_skillDict];
//            }
//        }
//        else{
//            if ([self.delegate respondsToSelector:@selector(addSkillChangeNeedRefreshData:)]) {
//                [self.delegate addSkillChangeNeedRefreshData:_skillDict];
//            }
//        }
//        
//        [self backButtonClick:nil];
//    }
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
        [self.dataArray addObject:[self getString:[recordDict objectForKey:@"time_start"]]];
        
        NSString *endTime = [self getString:[recordDict objectForKey:@"time_end"]];
        if ([endTime isEqualToString:@"-1"]) {
            [self.dataArray addObject:@"至今"];
        }
        else{
            [self.dataArray addObject:endTime];
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
    
//    if (indexPath.row == 0) {
//        IKSkillTypeVc *skillType = [[IKSkillTypeVc alloc] init];
//        NSLog(@"self.childTypeModel = %@",self.childTypeDict);
//        skillType.childTypeDict = self.childTypeDict;
//        skillType.delegate = self;
//        [self.navigationController pushViewController:skillType animated:YES];
//    }
//    else if (indexPath.row == 1){
//        
//    }
//    else if (indexPath.row == 2){
//        
//    }
//    else if (indexPath.row == 3){
//        NSArray *data = @[@"1年以下",@"1~2年",@"3~5年",@"6~8年",@"8~10年",@"10年以上"];
//        IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
//        pickerView.dataSource = data;
//        
//        [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
//            IKShowSkillTypeTableViewCell *cell = (IKShowSkillTypeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//            cell.value = selectedValue;
//            if (self.isAddSkill) {
//                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:selectedValue];
//            }
//            NSString *index = [NSString stringWithFormat:@"%ld",[data indexOfObject:selectedValue]+1];
//            [_skillDict setObject:selectedValue forKey:@"experienceTypeName"];
//            [_skillDict setObject:index forKey:@"experience_type"];
//            
//        }];
//    }
//    else{
//        NSArray *data = @[@"初级",@"中级",@"高级",@"资深",@"导师级"];
//        IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
//        pickerView.dataSource = data;
//        
//        [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
//            IKAddSkilTypeTableViewCell *cell = (IKAddSkilTypeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//            
//            cell.value = selectedValue;
//            if (self.isAddSkill) {
//                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:selectedValue];
//            }
//            NSString *index = [NSString stringWithFormat:@"%ld",[data indexOfObject:selectedValue]+1];
//            [_skillDict setObject:selectedValue forKey:@"levelName"];
//            [_skillDict setObject:index forKey:@"level"];
//        }];
//    }
}



#pragma mark - IKBaseInfoTableViewCellDelegate

- (void)textFieldBeginEditingNeedAjustkeyBorad:(BOOL)isNeed
{
    self.cellIsEditing = YES;
}

#pragma mark - IKResumeSelfIntroductionCellDelegate

- (void)textViewBeginEditingNeedAjustkeyBorad:(BOOL)isNeed
{
    [self.tableView setContentOffset:CGPointMake(0, 100) animated:YES];

    self.cellIsEditing = YES;
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
