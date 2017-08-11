//
//  IKCompanyAdTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyAdTableViewCell.h"
#import "IKButtonView.h"
#import "IKCompanyAdView.h"
#import "IKRollLabel.h"
#import "IKCompanyRecommendListModel.h"


@interface IKCompanyAdTableViewCell ()<IKButtonViewDelegate>

@property(nonatomic,strong)IKCompanyAdView   *lpView1;
@property(nonatomic,strong)IKCompanyAdView   *lpView2;
@property(nonatomic,strong)IKCompanyAdView   *lpView3;

@property(nonatomic,strong)IKRollLabel *nameLabel1;
@property(nonatomic,strong)IKRollLabel *nameLabel2;
@property(nonatomic,strong)IKRollLabel *nameLabel3;

@property(nonatomic,strong)IKRollLabel *desLabel1;
@property(nonatomic,strong)IKRollLabel *desLabel2;
@property(nonatomic,strong)IKRollLabel *desLabel3;

@property(nonatomic,strong)IKButtonView     *exchangeBtn;

@end


@implementation IKCompanyAdTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];

    }
    return self;
}


- (void)addSubViews
{
    [self addSubview:self.lpView1];
    [self addSubview:self.lpView2];
    [self addSubview:self.lpView3];
    
    [self addSubview:self.nameLabel1];
    [self addSubview:self.nameLabel2];
    [self addSubview:self.nameLabel3];

    [self addSubview:self.desLabel1];
    [self addSubview:self.desLabel2];
    [self addSubview:self.desLabel3];

    [self addSubview:self.exchangeBtn];
    
    [_lpView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(13);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.and.height.mas_equalTo(ceilf(IKSCREENH_HEIGHT*0.165));
    }];
    
    [_lpView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView1.mas_top);
        make.left.equalTo(_lpView1.mas_right).offset(10);
        make.width.and.height.equalTo(_lpView1);
    }];
    
    [_lpView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView1.mas_top);
        make.left.equalTo(_lpView2.mas_right).offset(10);
        make.width.and.height.equalTo(_lpView1);
    }];
    
    [_nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView1.mas_bottom).offset(5);
        make.left.equalTo(_lpView1.mas_left);
        make.width.equalTo(_lpView1.mas_width);
        make.height.mas_equalTo(20);
    }];
    
    [_nameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView2.mas_bottom).offset(5);
        make.left.equalTo(_lpView2.mas_left);
        make.width.equalTo(_lpView2.mas_width);
        make.height.mas_equalTo(20);
    }];
    
    [_nameLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView3.mas_bottom).offset(5);
        make.left.equalTo(_lpView3.mas_left);
        make.width.equalTo(_lpView3.mas_width);
        make.height.mas_equalTo(20);
    }];
    
    [_desLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel1.mas_bottom).offset(-2);
        make.left.equalTo(_lpView1.mas_left);
        make.width.equalTo(_lpView1.mas_width);
        make.height.mas_equalTo(18);
    }];
    
    [_desLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel2.mas_bottom).offset(-2);
        make.left.equalTo(_lpView2.mas_left);
        make.width.equalTo(_lpView2.mas_width);
        make.height.mas_equalTo(18);
    }];
    
    [_desLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel3.mas_bottom).offset(-2);
        make.left.equalTo(_lpView3.mas_left);
        make.width.equalTo(_lpView3.mas_width);
        make.height.mas_equalTo(18);
    }];
 
    [_exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.equalTo(self).multipliedBy(0.587);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(self);
    }];
    
}

- (IKCompanyAdView *)lpView1
{
    if (_lpView1 == nil) {
        _lpView1 = [[IKCompanyAdView alloc]init];
        _lpView1.scrollDirection = IKAdVScrollDirectionVertical;
        _lpView1.scrollTimeInterval = 3;
        _lpView1.reverseDirection = YES;
        _lpView1.isAutoScroll = YES;
        _lpView1.layer.cornerRadius = 6;
        _lpView1.layer.borderWidth = 1;
        _lpView1.layer.borderColor = IKLineColor.CGColor;
        _lpView1.layer.masksToBounds = YES;
        _lpView1.backgroundColor = [UIColor redColor];
    }
    
    return _lpView1;
}

- (IKCompanyAdView *)lpView2
{
    if (_lpView2 == nil) {
        _lpView2 = [[IKCompanyAdView alloc]init];
        _lpView2.scrollDirection = IKAdVScrollDirectionVertical;
        _lpView2.scrollTimeInterval = 3.5;
        _lpView2.reverseDirection = YES;
        _lpView2.isAutoScroll = YES;
        _lpView2.layer.cornerRadius = 6;
        _lpView2.layer.borderWidth = 1;
        _lpView2.layer.borderColor = IKLineColor.CGColor;
        _lpView2.layer.masksToBounds = YES;
        _lpView2.backgroundColor = [UIColor purpleColor];
    }
    
    return _lpView2;
}

- (IKCompanyAdView *)lpView3
{
    if (_lpView3 == nil) {
        _lpView3 = [[IKCompanyAdView alloc]init];
        _lpView3.scrollDirection = IKAdVScrollDirectionVertical;
        _lpView3.scrollTimeInterval = 4;
        _lpView3.reverseDirection = YES;
        _lpView3.isAutoScroll = YES;
        _lpView3.layer.cornerRadius = 6;
        _lpView3.layer.borderWidth = 1;
        _lpView3.layer.borderColor = IKLineColor.CGColor;
        _lpView3.layer.masksToBounds = YES;
        _lpView3.backgroundColor = [UIColor orangeColor];
//        _lpView3.imagesArray = @[@"https://pic.iamking.com.cn/Public/User/headerImage/1501230813_895_169.jpg",@"https://pic.iamking.com.cn/Public/User/headerImage/1501213018_93_359.jpg"];

    }
    
    return _lpView3;
}


- (IKRollLabel *)nameLabel1
{
    if (_nameLabel1 == nil) {
        _nameLabel1 = [[IKRollLabel alloc] init];
        _nameLabel1.scrollDirection = IKRollLabelScrollDirectionVertical;
        _nameLabel1.labelFont = [UIFont systemFontOfSize:12.0f];
        _nameLabel1.textAlignment = NSTextAlignmentCenter;
//        _nameLabel1.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
        _nameLabel1.reverseDirection = YES;
        _nameLabel1.scrollTimeInterval = 3;
        _nameLabel1.labelTextColor = IKMainTitleColor;
    }
    return _nameLabel1;
}

- (IKRollLabel *)nameLabel2
{
    if (_nameLabel2 == nil) {
        _nameLabel2 = [[IKRollLabel alloc] init];
        _nameLabel2.scrollDirection = IKRollLabelScrollDirectionVertical;
        _nameLabel2.labelFont = [UIFont systemFontOfSize:12.0f];
        _nameLabel2.textAlignment = NSTextAlignmentCenter;
//        _nameLabel2.dataArray = @[@"q",@"w",@"e",@"r",@"t",@"y"];
        _nameLabel2.reverseDirection = YES;
        _nameLabel2.scrollTimeInterval = 3.5;
        _nameLabel2.labelTextColor = IKMainTitleColor;
    }
    return _nameLabel2;
}

- (IKRollLabel *)nameLabel3
{
    if (_nameLabel3 == nil) {
        _nameLabel3 = [[IKRollLabel alloc] init];
        _nameLabel3.scrollDirection = IKRollLabelScrollDirectionVertical;
        _nameLabel3.labelFont = [UIFont systemFontOfSize:12.0f];
        _nameLabel3.textAlignment = NSTextAlignmentCenter;
//        _nameLabel3.dataArray = @[@"11",@"12",@"13",@"14",@"15",@"16"];
        _nameLabel3.reverseDirection = YES;
        _nameLabel3.scrollTimeInterval = 4;
        _nameLabel3.labelTextColor = IKMainTitleColor;
    }
    return _nameLabel3;
}


- (IKRollLabel *)desLabel1
{
    if (_desLabel1 == nil) {
        _desLabel1 = [[IKRollLabel alloc] init];
        _desLabel1.scrollDirection = IKRollLabelScrollDirectionVertical;
        _desLabel1.labelFont = [UIFont systemFontOfSize:11.0f];
        _desLabel1.textAlignment = NSTextAlignmentCenter;
//        _desLabel1.dataArray = @[@"11",@"12",@"13",@"14",@"15",@"16"];
        _desLabel1.reverseDirection = YES;
        _desLabel1.scrollTimeInterval = 3;
        _desLabel1.labelTextColor = IKSubHeadTitleColor;
    }
    return _desLabel1;
}


- (IKRollLabel *)desLabel2
{
    if (_desLabel2 == nil) {
        _desLabel2 = [[IKRollLabel alloc] init];
        _desLabel2.scrollDirection = IKRollLabelScrollDirectionVertical;
        _desLabel2.labelFont = [UIFont systemFontOfSize:11.0f];
        _desLabel2.textAlignment = NSTextAlignmentCenter;
//        _desLabel2.dataArray = @[@"11",@"12",@"13",@"14",@"15",@"16"];
        _desLabel2.reverseDirection = YES;
        _desLabel2.scrollTimeInterval = 3.5;
        _desLabel2.labelTextColor = IKSubHeadTitleColor;
    }
    return _desLabel2;
}

- (IKRollLabel *)desLabel3
{
    if (_desLabel3 == nil) {
        _desLabel3 = [[IKRollLabel alloc] init];
        _desLabel3.scrollDirection = IKRollLabelScrollDirectionVertical;
        _desLabel3.labelFont = [UIFont systemFontOfSize:11.0f];
        _desLabel3.textAlignment = NSTextAlignmentCenter;
//        _desLabel3.dataArray = @[@"11",@"12",@"13",@"14",@"15",@"16"];
        _desLabel3.reverseDirection = YES;
        _desLabel3.scrollTimeInterval = 4;
        _desLabel3.labelTextColor = IKSubHeadTitleColor;
    }
    return _desLabel3;
}

- (IKButtonView *)exchangeBtn
{
    if (_exchangeBtn == nil) {
        _exchangeBtn = [[IKButtonView alloc] init];
        _exchangeBtn.title = @"换一换";
        _exchangeBtn.cornerRadius = 22;
        _exchangeBtn.borderColor = IKMainTitleColor;
        _exchangeBtn.borderWidth = 1;
        _exchangeBtn.delegate = self;
        _exchangeBtn.needAnimation = YES;
    }
    
    return _exchangeBtn;
}

- (void)buttonViewButtonClick:(nullable UIButton *)button
{
    NSLog(@"ssssssss = %@",button);
    [_lpView1 scrollToNextPage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_lpView2 scrollToNextPage];

    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_lpView3 scrollToNextPage];

    });
}


- (void)addCompanyAdCellData:(NSArray *)array
{
    if (array.count == 0) {
        return;
    }
    
    
    NSMutableArray *imageA = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableArray *nameA = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableArray *descA = [NSMutableArray arrayWithCapacity:array.count];

    for (IKCompanyRecommendListModel *model in array) {
        
        [nameA addObject:model.nickName];
        [imageA addObject:model.logoImageUrl];
        [descA addObject:model.describe];
    }
    
    _lpView1.imagesArray = imageA;
    [_lpView1 reloadImageData];

    _nameLabel1.dataArray = nameA;
    [_nameLabel1 reloadViewData];

    _desLabel1.dataArray = descA;
    [_desLabel1 reloadViewData];

    _lpView2.imagesArray = imageA;
    [_lpView2 reloadImageData];

    _nameLabel2.dataArray = nameA;
    [_nameLabel2 reloadViewData];
    
    _desLabel2.dataArray = descA;
    [_desLabel2 reloadViewData];

    
    _lpView3.imagesArray = imageA;
    [_lpView3 reloadImageData];

    _nameLabel3.dataArray = nameA;
    [_nameLabel3 reloadViewData];

    _desLabel3.dataArray = descA;
    [_desLabel3 reloadViewData];

    [self AllStartScrollPage];
}


- (void)AllStartScrollPage
{
    [_lpView1 startAutoScrollPage];
    [_nameLabel1 startAutoScrollPage];
    [_desLabel1 startAutoScrollPage];

    [_lpView2 startAutoScrollPage];
    [_nameLabel2 startAutoScrollPage];
    [_desLabel2 startAutoScrollPage];

    [_lpView3 startAutoScrollPage];
    [_nameLabel3 startAutoScrollPage];
    [_desLabel3 startAutoScrollPage];

}


- (void)AllStopScrollPage
{
    [_lpView1 stopAutoScrollPage];
    [_nameLabel1 stopAutoScrollPage];
    [_desLabel1 stopAutoScrollPage];
    
    [_lpView2 stopAutoScrollPage];
    [_nameLabel2 stopAutoScrollPage];
    [_desLabel2 stopAutoScrollPage];
    
    [_lpView3 stopAutoScrollPage];
    [_nameLabel3 stopAutoScrollPage];
    [_desLabel3 stopAutoScrollPage];
    
}


@end
