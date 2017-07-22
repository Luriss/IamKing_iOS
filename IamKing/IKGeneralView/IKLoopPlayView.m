//
//  IKLoopPlayView.m
//  IamKing
//
//  Created by Luris on 2017/7/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKLoopPlayView.h"
#import "UIImageView+WebCache.h"
#import "LRPageControl.h"


#define IKCollectionViewCellIdentifier (@"IKCollectionViewCellIdentifier")
#define Multiple (10000)

@interface IKLPCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, strong) UIImageView *imageView;

- (void)setupWithUrlString:(NSString*)url placeholderImage:(UIImage*)placeholderImage;
- (void)setupWithImageName:(NSString*)imgName placeholderImage:(UIImage*)placeholderImage;
- (void)setupWithImage:(UIImage*)img placeholderImage:(UIImage*)placeholderImage;

@end


@implementation IKLPCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}


- (void)setupWithUrlString:(NSString*)url placeholderImage:(UIImage*)placeholderImage {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage];
    
    __weak typeof (self) weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.imageView.alpha = 0.0;
        
        [UIView transitionWithView:weakSelf.imageView duration:IKLoadImageTime options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [weakSelf.imageView setImage:image];
            weakSelf.imageView.alpha = 1.0;
        }completion:NULL];
    }];
}

- (void)setupWithImageName:(NSString*)imgName placeholderImage:(UIImage*)placeholderImage {
    UIImage* image = [UIImage imageNamed:imgName];
    if (!image) {
        image  = placeholderImage;
    }
    self.imageView.image = image;
}

- (void)setupWithImage:(UIImage*)img placeholderImage:(UIImage*)placeholderImage {
    if (img) {
        self.imageView.image = img;
    }else {
        self.imageView.image = placeholderImage;
    }
}

- (void)setupImageView {
    [self.contentView addSubview:self.imageView];
}

- (UIImageView* )imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    _contentMode = contentMode;
    self.imageView.contentMode = contentMode;
}


@end







@interface IKLoopPlayView ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger   _totalPageCount;
    NSUInteger  _infiniteCount;
    
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) LRPageControl *pageControl;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation IKLoopPlayView

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
    _scrollDirection = IKLPVScrollDirectionHorizontal;
    // 默认滚动时间3秒
    _scrollTimeInterval = 3;
    // 默认 pageControl 水平居中.
    _pageControlAlignment = IKPageControlAlignmentHorizontalCenter;
    //默认自动滚动
    _isAutoScroll = YES;
    // 默认无线滚动
    _isInfiniteLoop = YES;
    // 默认 UIViewContentModeScaleToFill
    _pageViewContentMode = UIViewContentModeScaleToFill;
    // 默认不显示
    _pageControlHidden = YES;
    
    _infiniteCount = 0;
    
    // 是否反向滚动,默认 no
    _reverseDirection = NO;
    _numberOfPages = 0;
    
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
        if (self.scrollDirection == IKLPVScrollDirectionHorizontal) {
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
        [_collectionView registerClass:[IKLPCollectionViewCell class] forCellWithReuseIdentifier:IKCollectionViewCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

- (LRPageControl *)pageControl
{
    if (_pageControl == nil) {
        CGFloat width = 15 * self.numberOfPages;
        _pageControl = [[LRPageControl alloc]initWithFrame:CGRectMake(0, 0, width, 20)];
        _pageControl.numberOfPages = self.numberOfPages;
        
        [self insertSubview:self.pageControl aboveSubview:self.collectionView];
        
        __weak typeof (self) weakSelf = self;

        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(20);
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
        }];
    }
    
    return _pageControl;
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

- (void)setImagesArray:(NSArray *)imagesArray
{
    NSLog(@"imagesArray = %@,",imagesArray);

    if (!IKArrayIsEmpty(imagesArray)) {
        _imagesArray = [imagesArray copy];
        
        // 因为默认是无线循环所以此处可以直接设置一个较大的数
        _infiniteCount = imagesArray.count * Multiple * 2;
        _totalPageCount = _infiniteCount;
        _numberOfPages = imagesArray.count;
        self.pageControl.numberOfPages = _numberOfPages;
        self.collectionView.scrollEnabled = YES;

        [self setIsAutoScroll:_isAutoScroll];
    }
}

- (void)reloadImageData
{
    [self.collectionView reloadData];
}

- (void)setTitlesArray:(NSArray *)titlesArray
{
    if (!IKArrayIsEmpty(titlesArray)) {
        _titlesArray = titlesArray;        
    }
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
    
    _totalPageCount = isInfiniteLoop?_infiniteCount:(self.imagesArray.count);
}

- (void)setScrollDirection:(IKLPVScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    if (scrollDirection == IKLPVScrollDirectionHorizontal) {
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    else{
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
}


- (void)setReverseDirection:(BOOL)reverseDirection
{
    _reverseDirection = reverseDirection;
    
    if (_isAutoScroll) {
        [self setupTimer];
    }
}


- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if (placeholderImage) {
        _placeholderImage = placeholderImage;
    }
    else{
        _placeholderImage = [UIImage imageWithContentsOfFile:@""]; // 默认占位图
    }
}

- (void)setScrollTimeInterval:(NSTimeInterval)scrollTimeInterval
{
    _scrollTimeInterval = scrollTimeInterval;
    
    if (_isAutoScroll) {
        [self setupTimer];
    }
}



- (void)setPageViewContentMode:(UIViewContentMode)pageViewContentMode
{
    _pageViewContentMode = pageViewContentMode;
}


- (void)setPageControlHidden:(BOOL)pageControlHidden
{
    _pageControlHidden = pageControlHidden;
    
    self.pageControl.hidden = pageControlHidden;
    
}

- (void)setPageControlAlignment:(IKPageControlAlignment)pageControlAlignment
{
    _pageControlAlignment = pageControlAlignment;
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
    IKLPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IKCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.contentMode = self.pageViewContentMode;
    cell.backgroundColor = IKGeneralLightGray;
    if (self.imagesArray.count) {
        NSInteger index = indexPath.row % self.imagesArray.count;
        id object = [self.imagesArray objectAtIndex:index];
        if ([object isKindOfClass:[NSString class]]) {
            if ([(NSString*)object hasPrefix:@"http"]) {
                [cell setupWithUrlString:(NSString*)object placeholderImage:self.placeholderImage];
            }
            else {
                [cell setupWithImageName:(NSString*)object placeholderImage:self.placeholderImage];
            }
        }
        else if ([object isKindOfClass:[UIImage class]]) {
            [cell setupWithImage:(UIImage*)object placeholderImage:self.placeholderImage];
        }
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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _pageControl.currentPage = (indexPath.row % 5);
    [self setupTimer];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}





// 滚动到指定的页面
- (void)scrollToPageAtIndex:(NSUInteger)pageIndex Animation:(BOOL)animation
{
    
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

- (void)setupTimer
{
    [self invalidateTimer];
    
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
    
    if (IKArrayIsEmpty(self.imagesArray)) {
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
    
    if (self.scrollDirection == IKLPVScrollDirectionHorizontal) {
        CGFloat nextPageX = 0;
        if (self.reverseDirection) {
            nextPageX = self.collectionView.contentOffset.x - _flowLayout.itemSize.width;
            if (_isInfiniteLoop) {
                if (nextPageX < 0) {
                    nextPageX = _flowLayout.itemSize.width * self.imagesArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        else{
            nextPageX = self.collectionView.contentOffset.x + _flowLayout.itemSize.width;
            if (self.isInfiniteLoop) {
                if (nextPageX > _flowLayout.itemSize.width * _infiniteCount) {
                    nextPageX = _flowLayout.itemSize.width * self.imagesArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(nextPageX,_flowLayout.itemSize.height * 0.5)];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:hasScrollAnimation];
        _pageControl.currentPage = (indexPath.row % 5);
    }
    else {
        CGFloat nextPageY = 0;
        if (self.reverseDirection) {
            nextPageY = self.collectionView.contentOffset.y - _flowLayout.itemSize.height;
            if (self.isInfiniteLoop) {
                if (nextPageY < 0) {
                    nextPageY = _flowLayout.itemSize.height * self.imagesArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        else{
            nextPageY = self.collectionView.contentOffset.y + _flowLayout.itemSize.height;
            if (self.isInfiniteLoop) {
                if (nextPageY > _flowLayout.itemSize.height * _infiniteCount) {
                    nextPageY = _flowLayout.itemSize.height * self.imagesArray.count * Multiple;
                    hasScrollAnimation = NO;
                }
            }
        }
        
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(_flowLayout.itemSize.width * 0.5, nextPageY)];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:hasScrollAnimation];
        _pageControl.currentPage = (indexPath.row % 5);

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
