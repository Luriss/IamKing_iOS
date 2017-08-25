//
//  IKAddPhotoTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAddPhotoTableViewCell.h"
#import "IKShowPhotoCollectionViewCell.h"
#import "IKAddPhotoCollectionViewCell.h"

@interface IKAddPhotoTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;


@end
@implementation IKAddPhotoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){

    }
    return self;
}


- (void)initSubViews
{
    [self.contentView addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.equalTo(self.contentView);
    }];
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(110, 160);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.minimumInteritemSpacing = 5.0f; // 列间距
        layout.minimumLineSpacing = 7.5f; //行间距
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 5.0f, 10.0f);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 180) collectionViewLayout:layout];
        _collectionView.tag = 101;
        _collectionView.bounces = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[IKShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"IKShowPhotoCollectionViewCell"];
        [_collectionView registerClass:[IKAddPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"IKAddPhotoCollectionViewCell"];

    }
    return _collectionView;
}

- (void)setDataArray:(NSArray *)dataArray
{
    if (IKArrayIsNotEmpty(dataArray)) {
        _dataArray = dataArray;
        
        NSLog(@"dataArray = %@",dataArray);
        [self initSubViews];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.dataArray.count;
    if (count < 8) {
        return count + 1;
    }
    else{
        return 8;  // 最多显示8张图片
    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = self.dataArray.count;
    if (count < 8 && indexPath.row == 0) {
        IKAddPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKAddPhotoCollectionViewCell" forIndexPath:indexPath];
        
//        cell.backgroundColor = [UIColor purpleColor];
        
        return cell;
    }
    else{
        IKShowPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKShowPhotoCollectionViewCell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor redColor];
        if (count < 8) {
            [cell setupImageWithUrlString:self.dataArray[indexPath.row - 1]];
        }
        else{
            [cell setupImageWithUrlString:self.dataArray[indexPath.row]];
        }
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
