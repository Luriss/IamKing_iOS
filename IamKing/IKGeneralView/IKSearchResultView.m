//
//  IKSearchResultView.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchResultView.h"
#import "IKTableView.h"
#import "IKInfoTableViewCell.h"
#import "IKCompanyTableViewCell.h"
#import "IKChooseCityView.h"
#import "IKSelectView.h"


typedef NS_ENUM(NSInteger, IKSelectedType) {
    IKSelectedTypeJob = 0,                  /** 职位 */
    IKSelectedTypeCompany,                  /** 公司 */
};


@interface IKSearchResultView ()<UITableViewDelegate,UITableViewDataSource,IKChooseCityViewDelegate>

@property(nonatomic,strong)IKView *topView;
@property(nonatomic,strong)IKView *jcView;
@property(nonatomic,strong)IKView *subTypeView;
@property(nonatomic,strong)UIButton *jobButton;
@property(nonatomic,strong)UIButton *companyButton;
@property(nonatomic,strong)IKView *jcBtnSelectedView;
@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;
@property(nonatomic,strong)UIButton *button4;

@property(nonatomic,strong)IKView *stView1;
@property(nonatomic,strong)IKView *stView2;
@property(nonatomic,strong)IKView *stView3;
@property(nonatomic,strong)IKView *stView4;

@property(nonatomic,strong)IKTableView *tableView;
@property(nonatomic,assign)IKSelectedType selectedType;


@end


@implementation IKSearchResultView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubviews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubviews];
    }
    
    return self;
}


- (void)addSubviews
{
    self.selectedType = IKSelectedTypeJob;
    
    
    [self insertSubview:self.topView atIndex:3];
    
    // 顶部的底图
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.mas_equalTo(80);
    }];
    
    [_topView addSubview:self.jcView];
    [_topView addSubview:self.subTypeView];
    
    // 职位公司
    [_jcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView).offset(4);
        make.left.equalTo(_topView).offset(10);
        make.right.equalTo(_topView).offset(-10);
        make.height.mas_equalTo(34);
    }];
    
    // 类型选项
    [_subTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jcView.mas_bottom).offset(4);
        make.left.and.right.and.height.equalTo(_jcView);
    }];
    
    [_jcView addSubview:self.jobButton];
    [_jcView addSubview:self.companyButton];
    [_jcView insertSubview:self.jcBtnSelectedView belowSubview:_jobButton];
    
    // 职位按钮
    [_jobButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.left.equalTo(_jcView);
        make.width.equalTo(_jcView).multipliedBy(0.5);
    }];
    
    // 公司按钮
    [_companyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.right.equalTo(_jcView);
        make.width.equalTo(_jobButton);
    }];
    
    // 选项的背景色
    [_jcBtnSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jcView).offset(3);
        make.left.equalTo(_jcView).offset(3);
        make.bottom.equalTo(_jcView).offset(-3);
        make.width.equalTo(_jobButton).offset(6);
    }];
    
    [_subTypeView addSubview:self.stView1];
    
    // 类型选项1
    [_stView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(_subTypeView);
        make.width.equalTo(_subTypeView).multipliedBy(0.25);
    }];
    
    [_subTypeView addSubview:self.stView2];
    
    // 类型选项2
    [_stView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_subTypeView);
        make.left.equalTo(_stView1.mas_right);
        make.width.equalTo(_stView1);
    }];
    
    // 类型选项3
    [_subTypeView addSubview:self.stView3];
    
    [_stView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_subTypeView);
        make.left.equalTo(_stView2.mas_right);
        make.width.equalTo(_stView1);
    }];
    
    // 类型选项4
    [_subTypeView addSubview:self.stView4];
    
    [_stView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_subTypeView);
        make.left.equalTo(_stView3.mas_right);
        make.width.equalTo(_stView1);
    }];
    
    // 底部结果 tableView
    [self insertSubview:self.tableView belowSubview:_topView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom);
        make.left.and.bottom.and.right.equalTo(self);
    }];
}


- (IKView *)topView
{
    if (_topView == nil) {
        _topView = [[IKView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];

    }
    
    return  _topView;
}


- (IKTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 80) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.scrollState = IKTableViewScrollStateNormal;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (IKView *)jcView
{
    if (_jcView == nil) {
        _jcView = [[IKView alloc] init];
        _jcView.backgroundColor = IKGeneralLightGray;
        _jcView.layer.cornerRadius = 17;
    }
    
    return _jcView;
}

- (IKView *)subTypeView
{
    if (_subTypeView == nil) {
        _subTypeView = [[IKView alloc] init];
        _subTypeView.backgroundColor = IKGeneralLightGray;
        _subTypeView.layer.cornerRadius = 17;
    }
    
    return _subTypeView;
}

- (UIButton *)jobButton
{
    if (_jobButton == nil) {
        _jobButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _jobButton.backgroundColor = [UIColor clearColor];
        [_jobButton setTitle:@"职位" forState:UIControlStateNormal];
        [_jobButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _jobButton.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_jobButton addTarget:self action:@selector(jcButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _jobButton;
}


- (UIButton *)companyButton
{
    if (_companyButton == nil) {
        _companyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _companyButton.backgroundColor = [UIColor clearColor];
        [_companyButton setTitle:@"公司" forState:UIControlStateNormal];
        [_companyButton setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _companyButton.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_companyButton addTarget:self action:@selector(jcButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _companyButton;
}


- (IKView *)jcBtnSelectedView
{
    if (_jcBtnSelectedView == nil) {
        _jcBtnSelectedView = [[IKView alloc] init];
        _jcBtnSelectedView.backgroundColor = IKGeneralBlue;
        _jcBtnSelectedView.layer.cornerRadius = 14;
    }
    return _jcBtnSelectedView;
}


- (IKView *)stView1
{
    if (_stView1 == nil) {
        _stView1 = [self createStView];
        [_stView1 addSubview:self.button1];
        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.equalTo(_stView1);
            make.right.equalTo(_stView1).offset(-15);
        }];
    }
    
    return _stView1;
}


- (UIButton *)button1
{
    if (_button1 == nil) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"工作城市" forState:UIControlStateNormal];
        [_button1 setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_button1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_button1 addTarget:self action:@selector(subTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _button1;
}


- (IKView *)stView2
{
    if (_stView2 == nil) {
        _stView2 = [self createStView];
        [_stView2 addSubview:self.button2];
        [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.equalTo(_stView2);
            make.right.equalTo(_stView2).offset(-15);
        }];
    }
    
    return _stView2;
}


- (UIButton *)button2
{
    if (_button2 == nil) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"公司类型" forState:UIControlStateNormal];
        [_button2 setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _button2.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_button2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_button2 addTarget:self action:@selector(subTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}


- (IKView *)stView3
{
    if (_stView3 == nil) {
        _stView3 = [self createStView];
        [_stView3 addSubview:self.button3];
        [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.equalTo(_stView3);
            make.right.equalTo(_stView3).offset(-15);
        }];
    }
    
    return _stView3;
}


- (UIButton *)button3
{
    if (_button3 == nil) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setTitle:@"薪资待遇" forState:UIControlStateNormal];
        [_button3 setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _button3.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_button3 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_button3 addTarget:self action:@selector(subTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _button3;
}


- (IKView *)stView4
{
    if (_stView4 == nil) {
        _stView4 = [self createStView];
        [_stView4 addSubview:self.button4];
        [_button4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.equalTo(_stView4);
            make.right.equalTo(_stView4).offset(-15);
        }];
    }
    
    return _stView4;
}


- (UIButton *)button4
{
    if (_button4 == nil) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setTitle:@"从业经验" forState:UIControlStateNormal];
        [_button4 setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _button4.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_button4 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_button4 addTarget:self action:@selector(subTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _button4;
}

- (IKView *)createStView
{
    IKView *stView = [[IKView alloc] init];
    stView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView setImage:[UIImage imageNamed:@"IK_showMore"]];
    [stView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stView).offset(7);
        make.right.equalTo(stView).offset(-5);
        make.width.and.height.mas_equalTo(20);
    }];
    return stView;
}

- (void)subTypeButtonClick:(UIButton *)button
{
    if (self.selectedType == IKSelectedTypeJob) {
        if (button == _button1) {
            [self showOrHideCityChooseView];
        }
        else if (button == _button2){
            [self showOrHideSelectCompanyTypeView];
        }
        else if (button == _button3){
            
        }
        else{
            
        }
    }
    else{
        if (button == _button1) {
            
        }
        else if (button == _button2){
            
        }
        else if (button == _button3){
            
        }
        else{
            
        }
    }
}


- (void)showOrHideCityChooseView
{
    UIView *view = [self viewWithTag:10001];
    
    if ( view != nil) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(view.frame));
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
        return;
    }
    
    IKChooseCityView *choose = [[IKChooseCityView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 80)];
    choose.tag = 10001;
    choose.delegate = self;
    choose.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(choose.frame));
    [self insertSubview:choose belowSubview:_topView];
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        choose.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        UIView *view2 = [self viewWithTag:10002];
        if (view2) {
            [view2 removeFromSuperview];
        }
    }];
    
}

- (void)chooseCityViewSelectedCity:(NSString *)city
{
    NSLog(@"city = %@",city);
    
    [self showOrHideCityChooseView];
    
}

- (void)showOrHideSelectCompanyTypeView
{
    UIView *view = [self viewWithTag:10002];
    
    if ( view != nil) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(view.frame));
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
        return;
    }
    
    IKSelectView *select = [[IKSelectView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 80)];
    select.tag = 10002;
    select.backgroundColor = IKSeachBarBgColor;
    select.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(select.frame));
    
    [self insertSubview:select belowSubview:_topView];
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        select.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        UIView *view2 = [self viewWithTag:10001];
        if (view2) {
            [view2 removeFromSuperview];
        }
    }];
}

- (void)jcButtonClick:(UIButton *)button
{
    NSLog(@"button  = %@",button);
    if (button == _companyButton) {
        [self setCompanyTypeSelectedChangeTitle];
        [self startSelectedViewAnimation:_jobButton.center endPoint:_companyButton.center];
    }
    else{
        [self setJobTypeSelectedChangeTitle];
        [self startSelectedViewAnimation:_companyButton.center endPoint:_jobButton.center];

    }
}


- (void)setJobTypeSelectedChangeTitle
{
    self.selectedType = IKSelectedTypeJob;

    [_jobButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_companyButton setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    
    [_button1 setTitle:@"工作城市" forState:UIControlStateNormal];
    [_button2 setTitle:@"公司类型" forState:UIControlStateNormal];
    [_button3 setTitle:@"薪资待遇" forState:UIControlStateNormal];
    [_button4 setTitle:@"从业经验" forState:UIControlStateNormal];
    
    [self.tableView reloadData];
}

- (void)setCompanyTypeSelectedChangeTitle
{
    self.selectedType = IKSelectedTypeCompany;

    [_companyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_jobButton setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    
    [_button1 setTitle:@"公司类型" forState:UIControlStateNormal];
    [_button2 setTitle:@"店铺数量" forState:UIControlStateNormal];
    [_button3 setTitle:@"直营加盟" forState:UIControlStateNormal];
    [_button4 setTitle:@"公司评价" forState:UIControlStateNormal];
    
    IKCompanyInfoModel  *model = [[IKCompanyInfoModel alloc] init];
    model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg";
    model.title = @"高级营销总监";
    model.evaluate = 3;
    model.address = @"杭州";
    model.setupTime = @"2010年成立";
    model.numberOfStore = @"6~10家店";
    model.introduce = @"时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.";
    model.numberOfJob = @"10个 在招职位";
    self.companyModel = model;
    [self.tableView reloadData];
}



- (void)startSelectedViewAnimation:(CGPoint )startPoint  endPoint:(CGPoint )endPoint
{
    CABasicAnimation* position = [CABasicAnimation animation];
    position.duration = 0.1;
    position.keyPath = @"position.x";
    position.fromValue = [NSValue valueWithCGPoint:startPoint];
    position.toValue = [NSValue valueWithCGPoint:endPoint];
    position.removedOnCompletion = NO;
    position.fillMode = kCAFillModeForwards;
    [_jcBtnSelectedView.layer addAnimation:position forKey:nil];
}



- (void)reloadData
{
    [self.tableView reloadData];
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
    if (self.selectedType == IKSelectedTypeJob) {
        return 3;
    }
    else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedType == IKSelectedTypeJob) {
        static  NSString *cellId=@"IKInfoCellId";
        IKInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell==nil)
        {
            cell=[[IKInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (indexPath.row == 1 || indexPath.row == 3) {
            _jobModel.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg";
        }
        
        [cell addCellData:_jobModel];
        return cell;
    }
    else{
        static  NSString *cellId=@"IKCompanyTableViewCellId";
        IKCompanyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil)
        {
            cell = [[IKCompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (indexPath.row == 1 || indexPath.row == 3) {
            _companyModel.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg";
            _companyModel.evaluate = 2;
        }
        
        [cell addCellData:_companyModel];
        return cell;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
