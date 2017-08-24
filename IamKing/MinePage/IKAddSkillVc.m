//
//  IKAddSkillVc.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAddSkillVc.h"
#import "IKAddSkilTypeTableViewCell.h"
#import "IKSkillTypeVc.h"
#import "IKShowSkillTypeTableViewCell.h"
#import "IKPickerView.h"


@interface IKAddSkillVc ()<UITableViewDelegate,UITableViewDataSource,IKSkillTypeVcDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray *titileArray;
@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation IKAddSkillVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavTitle];
    [self initLeftBackItem];
    
    
    self.titileArray = @[@"选择认证/技能",@"是否经官方权威培训机构认证?",@"是否持有改认证/技能资质证书?",@"该认证/技能有多久的授课经验?",@"该认证/技能目前处于什么等级?"];
    
    
    [self.view addSubview:self.tableView];
    [self initBottomButton];
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



- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64 - 60) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
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
    NSLog(@"commitButtonClick  = %@ self.isAddSkill = %d",_skillDict,self.isAddSkill);
    
    if ([self.dataArray containsObject:@""]) {
        [LRToastView showTosatWithText:@"请完成所有选项后,再点击确定" inView:self.view];
    }
    else{
        if (self.isAddSkill) {
            if ([self.delegate respondsToSelector:@selector(addSkillAddNewSkillWithData:)]) {
                [self.delegate addSkillAddNewSkillWithData:_skillDict];
            }
        }
        else{
            if ([self.delegate respondsToSelector:@selector(addSkillChangeNeedRefreshData:)]) {
                [self.delegate addSkillChangeNeedRefreshData:_skillDict];
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

- (void)setSkillDict:(NSMutableDictionary *)skillDict
{
    NSLog(@"skillDict  = %@",skillDict);
    if (IKDictIsNotEmpty(skillDict)) {
        
        _skillDict = skillDict;
        
        [self.dataArray addObject:[self getString:[skillDict objectForKey:@"name"]]];
        
        if ([[skillDict objectForKey:@"is_approve"] isEqualToString:@"1"]) {
            [self.dataArray addObject:@"是"];
        }
        else{
            [self.dataArray addObject:@"否"];
        }

        if ([[skillDict objectForKey:@"has_certificate"] isEqualToString:@"1"]) {
            [self.dataArray addObject:@"是"];
        }
        else{
            [self.dataArray addObject:@"否"];
        }
        
        [self.dataArray addObject:[self getString:[skillDict objectForKey:@"experienceTypeName"]]];
        [self.dataArray addObject:[self getString:[skillDict objectForKey:@"levelName"]]];

    }
}

- (void)setIsAddSkill:(BOOL)isAddSkill
{
    _isAddSkill = isAddSkill;
    
    if (isAddSkill) {
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        [self.dataArray addObject:@""];
        
        _skillDict = [[NSMutableDictionary alloc] init];
        
        [_skillDict setObject:@"" forKey:@"id"];
        [_skillDict setObject:@"1" forKey:@"status"];

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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        static  NSString *cellId = @"IKShowSkillTypeTableViewCellId";
        IKShowSkillTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKShowSkillTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.psLabel.text = self.titileArray.firstObject;
        cell.value = self.dataArray.firstObject;

        return cell;
    }
    else{
        static  NSString *cellId = @"IKAddSkilTypeTableViewCellId";
        IKAddSkilTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKAddSkilTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.psLabel.text = self.titileArray[indexPath.row];
        cell.value = self.dataArray[indexPath.row];

        return cell;
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 2) {
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
        
        NSString *skillName = self.dataArray.firstObject;

        if (self.isAddSkill && IKStringIsEmpty(skillName)) {
            [LRToastView showTosatWithText:@"请选择认证/技能" inView:self.view];
        }
        else{
            if (indexPath.row == 2) {
                NSString *str = self.dataArray[1];
                
                if ([str isEqualToString:@"是"]) {
                    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"是"];
                    [_skillDict setObject:@"1" forKey:@"has_certificate"];
                }
                else{
                    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"否"];
                    [LRToastView showTosatWithText:@"未经官方权威培训机构认证,则无认证/技能资质证书" inView:self.view];
                    [_skillDict setObject:@"0" forKey:@"has_certificate"];
                }
            }
            else{
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"是"];
                [_skillDict setObject:@"1" forKey:@"is_approve"];
            }
        }
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
       //在block中实现相对应的事件
    }];
    action1.backgroundColor = IKGeneralBlue;
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"否" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSString *skillName = self.dataArray.firstObject;
        
        if (self.isAddSkill && IKStringIsEmpty(skillName)) {
            [LRToastView showTosatWithText:@"请选择认证/技能" inView:self.view];
        }
        else{
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"否"];
            if (indexPath.row == 2) {
                [_skillDict setObject:@"0" forKey:@"has_certificate"];
            }
            else{
                [_skillDict setObject:@"0" forKey:@"is_approve"];
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
    
    if (indexPath.row == 0) {
        IKSkillTypeVc *skillType = [[IKSkillTypeVc alloc] init];
        NSLog(@"self.childTypeModel = %@",self.childTypeDict);
        skillType.childTypeDict = self.childTypeDict;
        skillType.delegate = self;
        [self.navigationController pushViewController:skillType animated:YES];
    }
    else if (indexPath.row == 1){
        
    }
    else if (indexPath.row == 2){
        
    }
    else if (indexPath.row == 3){
        NSArray *data = @[@"1年以下",@"1~2年",@"3~5年",@"6~8年",@"8~10年",@"10年以上"];
        IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
        pickerView.dataSource = data;
        
        [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
            IKShowSkillTypeTableViewCell *cell = (IKShowSkillTypeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.value = selectedValue;
            if (self.isAddSkill) {
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:selectedValue];
            }
            NSString *index = [NSString stringWithFormat:@"%ld",[data indexOfObject:selectedValue]+1];
            [_skillDict setObject:selectedValue forKey:@"experienceTypeName"];
            [_skillDict setObject:index forKey:@"experience_type"];

        }];
    }
    else{
        NSArray *data = @[@"初级",@"中级",@"高级",@"资深",@"导师级"];
        IKPickerView *pickerView = [[IKPickerView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
        pickerView.dataSource = data;
        
        [pickerView showWithSelectedResultBlock:^(NSString *selectedValue) {
            IKAddSkilTypeTableViewCell *cell = (IKAddSkilTypeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

            cell.value = selectedValue;
            if (self.isAddSkill) {
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:selectedValue];
            }
            NSString *index = [NSString stringWithFormat:@"%ld",[data indexOfObject:selectedValue]+1];
            [_skillDict setObject:selectedValue forKey:@"levelName"];
            [_skillDict setObject:index forKey:@"level"];
        }];
    }
}


- (void)selectedJobTypeName:(NSString *)name typeId:(NSString *)typeId
{
    IKShowSkillTypeTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.value = name;
    
    if (self.isAddSkill) {
        [self.dataArray replaceObjectAtIndex:0 withObject:name];
    }
    [_skillDict setObject:name forKey:@"name"];
    [_skillDict setObject:typeId forKey:@"skill_id"];
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
