//
//  IKFeedbackTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/27.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKFeedbackTableViewCell.h"



@interface IKFeedbackTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIView  *bottomLineView;

@end


@implementation IKFeedbackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier noData:(BOOL)isNoData
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        if (isNoData) {
            [self noDataLabel];
        }
        else{
            [self initSubViews];
        }
    }
    return self;
}

- (void)noDataLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"暂无评论";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = IKSubHeadTitleColor;
    
    [self.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.and.height.equalTo(self.contentView);
    }];
}


- (void)initSubViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
