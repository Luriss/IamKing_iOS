//
//  IKRollLabel.m
//  IamKing
//
//  Created by Luris on 2017/8/3.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKRollLabel.h"

#define IKRollLabelCellIdentifier (@"IKRollLabelCellIdentifier")
#define Multiple (10000)

@interface IKRollLabelCell : UICollectionViewCell

@property (nonatomic, strong) UILabel   *contentLabel;
//@property (nonatomic, copy) NSString    *labelText;
//@property (nonatomic, strong) UIFont    *labelFont;
//@property (nonatomic, strong) UIColor   *textColor;
//@property (nonatomic, strong) UIColor   *labelTextColor;
//@property(nonatomic)        NSTextAlignment    textAlignment;


@end


@implementation IKRollLabelCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContentLabel];
    }
    return self;
}


- (void)setupContentLabel {
    [self.contentView addSubview:self.contentLabel];
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]initWithFrame:self.bounds];
    }
    return _contentLabel;
}


@end




@interface IKRollLabel ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger   _totalPageCount;
    NSUInteger  _infiniteCount;
    
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation IKRollLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBaseValue];
        [self addSubviews];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initBaseValue];
        [self addSubviews];
    }
    
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)dealloc {
    [self invalidateTimer];
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    
}



- (void)addSubviews
{
    [self addSubview:self.collectionView];
}

- (void)initBaseValue
{
    // 默认水平方向滚动
    _scrollDirection = IKRollLabelScrollDirectionHorizontal;
    // 默认滚动时间3秒
    _scrollTimeInterval = 3;
    
    // 默认无线滚动
    _isInfiniteLoop = YES;
    
    _infiniteCount = 0;
    
    // 是否反向滚动,默认 no
    _reverseDirection = NO;
    _numberOfPages = 0;
    _labelFont = [UIFont systemFontOfSize:13.0f];
    _labelTextColor = [UIColor blackColor];
    _textAlignment = NSTextAlignmentCenter;

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutCollectView];
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        if (self.scrollDirection == IKRollLabelScrollDirectionHorizontal) {
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }
        else{
            flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[IKRollLabelCell class] forCellWithReuseIdentifier:IKRollLabelCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}


- (void)layoutCollectView
{
    _flowLayout.itemSize = self.frame.size;
    
    __weak typeof (self) weakSelf = self;
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
        make.width.and.height.equalTo(weakSelf);
    }];
}


#pragma mark - Setter

- (void)setDataArray:(NSArray *)dataArray
{
    if (!IKArrayIsEmpty(dataArray)) {
        _dataArray = [dataArray copy];
        
        
        if (dataArray.count > 1) {
            // 因为默认是无线循环所以此处可以直接设置一个较大的数
            _infiniteCount = dataArray.count * Multiple * 2;
            _totalPageCount = _infiniteCount;
            
            [self setIsAutoScroll:_isAutoScroll];
        }
        else{
            _totalPageCount = dataArray.count;
            [self setIsAutoScroll:NO];
        }
        
        _numberOfPages = dataArray.count;
        self.collectionView.scrollEnabled = YES;
    }
}


- (void)reloadViewData
{
    [self.collectionView reloadData];
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll
{
    _isAutoScroll = isAutoScroll;
    
    if (isAutoScroll) {
        [self setupTimer];
    }
}


- (void)setIsInfiniteLoop:(BOOL)isInfiniteLoop
{
    _isInfiniteLoop = isInfiniteLoop;
    
    _totalPageCount = isInfiniteLoop?_infiniteCount:(self.dataArray.count);
}

- (void)setScrollDirection:(IKRollLabelScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    if (scrollDirection == IKRollLabelScrollDirectionHorizontal) {
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    else{
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
}


- (void)setReverseDirection:(BOOL)reverseDirection
{
    _reverseDirection = reverseDirection;
}

- (void)setScrollTimeInterval:(NSTimeInterval)scrollTimeInterval
{
    _scrollTimeInterval = scrollTimeInterval;
}


- (void)setLabelFont:(UIFont *)labelFont
{
    if (labelFont) {
        _labelFont = labelFont;
    }
}

- (void)setLabelTextColor:(UIColor *)labelTextColor
{
    if (labelTextColor) {
        _labelTextColor = labelTextColor;
    }
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    if (textAlignment) {
        _textAlignment = textAlignment;
    }
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalPageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IKRollLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IKRollLabelCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (self.dataArray.count > 0) {
        NSInteger index = indexPath.row % self.dataArray.count;
        NSString *text = [self.dataArray objectAtIndex:index];
        cell.contentLabel.text = text;
        cell.contentLabel.font = self.labelFont;
        cell.contentLabel.textAlignment = self.textAlignment;
        cell.contentLabel.textColor = self.labelTextColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didSelectItemAtIndex:)]) {
    //        [self.delegate infiniteScrollView:self didSelectItemAtIndex:self.currentPageIndex];
    //    }
    //
    //    if (self.scrollViewDidSelectBlock) {
    //        self.scrollViewDidSelectBlock(self,self.currentPageIndex);
    //    }
}

// 开始自动滚动
- (void)startAutoScrollPage
{
    [self setupTimer];
}

// 停止自动滚动
- (void)stopAutoScrollPage
{
    [self invalidateTimer];
}


#pragma mark - timer
#pragma mark - timer

- (void)setupTimer
{
    [self invalidateTimer];
    
    // 傻逼一样的代码 防止滚动到最大值,闪一下
    CGFloat nextPageY = _flowLayout.itemSize.height * self.dataArray.count * Multiple;
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(_flowLayout.itemSize.width * 0.5, nextPageY)];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


- (void)scrollToNextPage
{
    if (IKArrayIsEmpty(self.dataArray)) {
        [self invalidateTimer];
        return;
    }
    
    if ([NSThread isMainThread]) {
        [self startScrollToNextPage];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startScrollToNextPage];
        });
    }
}


- (void)startScrollToNextPage
{
    BOOL hasScrollAnimation = YES;
    
    if (self.scrollDirection == IKRollLabelScrollDirectionHorizontal) {
        CGFloat nextPageX = 0;
        if (self.reverseDirection) {
            nextPageX = self.collectionView.contentOffset.x - _flowLayout.itemSize.width;
            if (_isInfiniteLoop) {
                if (nextPageX < 0) {
                    nextPageX = _flowLayout.itemSize.width * self.dataArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        else{
            nextPageX = self.collectionView.contentOffset.x + _flowLayout.itemSize.width;
            if (self.isInfiniteLoop) {
                if (nextPageX > _flowLayout.itemSize.width * _infiniteCount) {
                    nextPageX = _flowLayout.itemSize.width * self.dataArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(nextPageX,_flowLayout.itemSize.height * 0.5)];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:hasScrollAnimation];
    }
    else {
        CGFloat nextPageY = 0;
        if (self.reverseDirection) {
            nextPageY = self.collectionView.contentOffset.y - _flowLayout.itemSize.height;            
            if (self.isInfiniteLoop) {
                if (nextPageY < 0) {
                    nextPageY = _flowLayout.itemSize.height * self.dataArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        else{
            nextPageY = self.collectionView.contentOffset.y + _flowLayout.itemSize.height;
            
            if (self.isInfiniteLoop) {
                if (nextPageY > _flowLayout.itemSize.height * _infiniteCount) {
                    nextPageY = _flowLayout.itemSize.height * self.dataArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(_flowLayout.itemSize.width * 0.5, nextPageY)];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:hasScrollAnimation];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
