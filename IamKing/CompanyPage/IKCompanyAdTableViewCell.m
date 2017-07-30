//
//  IKCompanyAdTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyAdTableViewCell.h"
#import "IKLoopPlayView.h"
#import "IKButtonView.h"


@interface IKCompanyAdTableViewCell ()<IKButtonViewDelegate>

@property(nonatomic,strong)IKLoopPlayView   *lpView1;
@property(nonatomic,strong)IKLoopPlayView   *lpView2;
@property(nonatomic,strong)IKLoopPlayView   *lpView3;
@property(nonatomic,strong)IKButtonView     *exchangeBtn;

@property(nonatomic,strong)UILabel *nameLabel1;
@property(nonatomic,strong)UILabel *nameLabel2;
@property(nonatomic,strong)UILabel *nameLabel3;


@property(nonatomic,strong)UILabel *desLabel1;
@property(nonatomic,strong)UILabel *desLabel2;
@property(nonatomic,strong)UILabel *desLabel3;

@end


@implementation IKCompanyAdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self.contentView addSubview:self.lpView1];
    [self.contentView addSubview:self.lpView2];
    [self.contentView addSubview:self.lpView3];
    
    [self.contentView addSubview:self.nameLabel1];
    [self.contentView addSubview:self.nameLabel2];
    [self.contentView addSubview:self.nameLabel3];

    [self.contentView addSubview:self.desLabel1];
    [self.contentView addSubview:self.desLabel2];
    [self.contentView addSubview:self.desLabel3];

    [self.contentView addSubview:self.exchangeBtn];
    
    [_lpView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(13);
        make.left.equalTo(self.contentView.mas_left).offset(15);
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
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.width.equalTo(self.contentView).multipliedBy(0.587);
        make.height.equalTo(self.contentView).multipliedBy(0.158);
        make.centerX.equalTo(self.contentView);
    }];
    
}

- (IKLoopPlayView *)lpView1
{
    if (_lpView1 == nil) {
        _lpView1 = [[IKLoopPlayView alloc]init];
        _lpView1.scrollDirection = IKLPVScrollDirectionVertical;
        _lpView1.scrollTimeInterval = 4;
        _lpView1.pageControlHidden = YES;
        _lpView1.layer.cornerRadius = 5;
        _lpView1.layer.borderWidth = 1;
        _lpView1.layer.borderColor = IKLineColor.CGColor;
        _lpView1.layer.masksToBounds = YES;
        _lpView1.backgroundColor = [UIColor redColor];
        _lpView1.imagesArray = @[@"https://pic.iamking.com.cn/Public/User/headerImage/1501213018_93_359.jpg",@"https://pic.iamking.com.cn/Public/User/headerImage/1501154443_148_986.jpg"];
    }
    
    return _lpView1;
}

- (IKLoopPlayView *)lpView2
{
    if (_lpView2 == nil) {
        _lpView2 = [[IKLoopPlayView alloc]init];
        _lpView2.scrollDirection = IKLPVScrollDirectionVertical;
        _lpView2.scrollTimeInterval = 4;
        _lpView2.pageControlHidden = YES;
        _lpView2.layer.cornerRadius = 5;
        _lpView2.layer.borderWidth = 1;
        _lpView2.layer.borderColor = IKLineColor.CGColor;
        _lpView2.layer.masksToBounds = YES;
        _lpView2.backgroundColor = [UIColor purpleColor];
        _lpView2.imagesArray = @[@"https://pic.iamking.com.cn/Public/User/headerImage/1501229456_858_653.jpg",@"https://pic.iamking.com.cn/Public/User/headerImage/1501230813_895_169.jpg"];

    }
    
    return _lpView2;
}

- (IKLoopPlayView *)lpView3
{
    if (_lpView3 == nil) {
        _lpView3 = [[IKLoopPlayView alloc]init];
        _lpView3.scrollDirection = IKLPVScrollDirectionVertical;
        _lpView3.scrollTimeInterval = 4;
        _lpView3.pageControlHidden = YES;
        _lpView3.layer.cornerRadius = 5;
        _lpView3.layer.borderWidth = 1;
        _lpView3.layer.borderColor = IKLineColor.CGColor;
        _lpView3.layer.masksToBounds = YES;
        _lpView3.backgroundColor = [UIColor orangeColor];
        _lpView3.imagesArray = @[@"https://pic.iamking.com.cn/Public/User/headerImage/1501230813_895_169.jpg",@"https://pic.iamking.com.cn/Public/User/headerImage/1501213018_93_359.jpg"];

    }
    
    return _lpView3;
}


- (UILabel *)nameLabel1
{
    if (_nameLabel1 == nil) {
        _nameLabel1 = [[UILabel alloc] init];
        _nameLabel1.textColor = IKMainTitleColor;
        _nameLabel1.font = [UIFont systemFontOfSize:12.0f];
        _nameLabel1.textAlignment = NSTextAlignmentCenter;
        _nameLabel1.text = @"威尔士健身";
    }
    return _nameLabel1;
}

- (UILabel *)nameLabel2
{
    if (_nameLabel2 == nil) {
        _nameLabel2 = [[UILabel alloc] init];
        _nameLabel2.textColor = IKMainTitleColor;
        _nameLabel2.font = [UIFont systemFontOfSize:12.0f];
        _nameLabel2.textAlignment = NSTextAlignmentCenter;
        _nameLabel2.text = @"一兆韦德健身";
    }
    return _nameLabel2;
}

- (UILabel *)nameLabel3
{
    if (_nameLabel3 == nil) {
        _nameLabel3 = [[UILabel alloc] init];
        _nameLabel3.textColor = IKMainTitleColor;
        _nameLabel3.font = [UIFont systemFontOfSize:12.0f];
        _nameLabel3.textAlignment = NSTextAlignmentCenter;
        _nameLabel3.text = @"Keep";
    }
    return _nameLabel3;
}


- (UILabel *)desLabel1
{
    if (_desLabel1 == nil) {
        _desLabel1 = [[UILabel alloc] init];
        _desLabel1.textColor =  IKSubHeadTitleColor;
        _desLabel1.font = [UIFont systemFontOfSize:11.0f];
        _desLabel1.textAlignment = NSTextAlignmentCenter;
        _desLabel1.text = @"国内知名健身品牌";
    }
    return _desLabel1;
}


- (UILabel *)desLabel2
{
    if (_desLabel2 == nil) {
        _desLabel2 = [[UILabel alloc] init];
        _desLabel2.textColor =  IKSubHeadTitleColor;
        _desLabel2.font = [UIFont systemFontOfSize:11.0f];
        _desLabel2.textAlignment = NSTextAlignmentCenter;
        _desLabel2.text = @"国内知名健身品牌";
    }
    return _desLabel2;
}

- (UILabel *)desLabel3
{
    if (_desLabel3 == nil) {
        _desLabel3 = [[UILabel alloc] init];
        _desLabel3.textColor =  IKSubHeadTitleColor;
        _desLabel3.font = [UIFont systemFontOfSize:11.0f];
        _desLabel3.textAlignment = NSTextAlignmentCenter;
        _desLabel3.text = @"移动健身教练";
    }
    return _desLabel3;
}


- (IKButtonView *)exchangeBtn
{
    if (_exchangeBtn == nil) {
        _exchangeBtn = [[IKButtonView alloc] init];
        _exchangeBtn.title = @"换一换";
        _exchangeBtn.cornerRadius = 16;
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
    [_lpView2 scrollToNextPage];
    [_lpView3 scrollToNextPage];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
