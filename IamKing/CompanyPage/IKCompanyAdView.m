//
//  IKCompanyAdView.m
//  IamKing
//
//  Created by Luris on 2017/8/3.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyAdView.h"

#define IKCollectionViewCellIdentifier (@"IKAdCollectionViewCellIdentifier")
#define Multiple (100)

@interface IKAdCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, strong) UIImageView *imageView;

- (void)setupWithUrlString:(NSString*)url placeholderImage:(UIImage*)placeholderImage;
- (void)setupWithImageName:(NSString*)imgName placeholderImage:(UIImage*)placeholderImage;
- (void)setupWithImage:(UIImage*)img placeholderImage:(UIImage*)placeholderImage;

@end


@implementation IKAdCollectionViewCell


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







@interface IKCompanyAdView ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger   _totalPageCount;
    NSUInteger  _infiniteCount;
    
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation IKCompanyAdView

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
    [self layoutCollectView];

}

- (void)initBaseValue
{
    // 默认水平方向滚动
    _scrollDirection = IKAdVScrollDirectionHorizontal;
    // 默认滚动时间3秒
    _scrollTimeInterval = 3;

    //默认自动滚动
    _isAutoScroll = NO;
    // 默认无线滚动
    _isInfiniteLoop = YES;
    // 默认 UIViewContentModeScaleToFill
    _pageViewContentMode = UIViewContentModeScaleAspectFill;
    
    _infiniteCount = 0;
    
    // 是否反向滚动,默认 no
    _reverseDirection = NO;
    
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        if (self.scrollDirection == IKAdVScrollDirectionHorizontal) {
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
        [_collectionView registerClass:[IKAdCollectionViewCell class] forCellWithReuseIdentifier:IKCollectionViewCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}



- (void)layoutCollectView
{
    _flowLayout.itemSize = self.frame.size;
    
    CGFloat nextPageY = _flowLayout.itemSize.height * self.imagesArray.count * Multiple;
    __weak typeof (self) weakSelf = self;
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
        make.width.and.height.equalTo(weakSelf);
    }];
}


#pragma mark - Setter

- (void)setImagesArray:(NSArray *)imagesArray
{
    if (!IKArrayIsEmpty(imagesArray)) {
        _imagesArray = [imagesArray copy];
        
        
        if (imagesArray.count > 1) {
            // 因为默认是无线循环所以此处可以直接设置一个较大的数
            _infiniteCount = imagesArray.count * Multiple * 2;
            _totalPageCount = _infiniteCount;
            
        }
        else{
            _totalPageCount = imagesArray.count;
        }
        [self addSubviews];
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
//    
//    if (isAutoScroll) {
//        [self setupTimer];
//    }
}


- (void)setIsInfiniteLoop:(BOOL)isInfiniteLoop
{
    _isInfiniteLoop = isInfiniteLoop;
    
    _totalPageCount = isInfiniteLoop?_infiniteCount:(self.imagesArray.count);
}

- (void)setScrollDirection:(IKAdVScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    if (scrollDirection == IKAdVScrollDirectionHorizontal) {
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
    if (scrollTimeInterval < 0) {
        scrollTimeInterval = 1;
    }
    _scrollTimeInterval = scrollTimeInterval;
}



- (void)setPageViewContentMode:(UIViewContentMode)pageViewContentMode
{
    _pageViewContentMode = pageViewContentMode;
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
    IKAdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IKCollectionViewCellIdentifier forIndexPath:indexPath];
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
    NSLog(@"ad View CLick = %ld",indexPath.row%self.imagesArray.count);
    
    NSInteger index = indexPath.row%self.imagesArray.count;
    [IKNotificationCenter postNotificationName:@"IKAdViewClick" object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%ld",index]}];
    
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
    
    // 傻逼一样的代码 防止滚动到最大值,闪一下
    
    if (self.collectionView.contentOffset.y == 0) {
        CGFloat nextPageY = _flowLayout.itemSize.height * self.imagesArray.count * Multiple;
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(_flowLayout.itemSize.width * 0.5, nextPageY)];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        
    }
    
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
    
    if (self.scrollDirection == IKAdVScrollDirectionHorizontal) {
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
