//
//  IKComDetailLoopTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKComDetailLoopTableViewCell.h"
#import "IKLoopPlayView.h"

@interface IKComDetailLoopTableViewCell ()

@property(nonatomic,strong)IKLoopPlayView   *lpView;

@end

@implementation IKComDetailLoopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    [self.contentView addSubview:self.lpView];
    
    [_lpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.and.height.equalTo(self.contentView);
    }];
}

- (IKLoopPlayView *)lpView
{
    if (_lpView == nil) {
        _lpView = [[IKLoopPlayView alloc]init];
        _lpView.scrollDirection = IKLPVScrollDirectionHorizontal;
        _lpView.scrollTimeInterval = 4;
        _lpView.pageControlHidden = NO;
    }
    return _lpView;
}

- (void)setImageArray:(NSArray *)imageArray
{
    if (IKArrayIsNotEmpty(imageArray)) {
        _imageArray = imageArray;
        
        self.lpView.imagesArray = imageArray;
        [self.lpView reloadImageData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
