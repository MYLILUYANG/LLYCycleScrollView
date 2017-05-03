//
//  LLYCycleScrollView.m
//  LLYCycleScrollView
//
//  Created by Lu Yang Li on 2017/5/2.
//  Copyright © 2017年 Lu Yang Li. All rights reserved.
//

#import "LLYCycleScrollView.h"
#import "LLYCycleCell.h"
#import "UIImageView+WebCache.h"
@interface LLYCycleScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LLYCycleScrollView

+(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate placeholderImage:(UIImage *)placeholderImage
{
    LLYCycleScrollView *scrollView = [[LLYCycleScrollView alloc] initWithFrame:frame];
    scrollView.delegate = delegate;
//    self->placeholderImage = placeholderImage;
    return scrollView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initlizetion];
        [self setupMainView];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initlizetion];
    [self setupMainView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_mainView.contentOffset.x == 0 && _totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else
        {
            targetIndex = 0;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
}

-(void)initlizetion
{
    //初始化各项默认参数
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont = [UIFont systemFontOfSize:14];
    _titleLabelHeight = 30;
    _titleLabelTextAlignment = NSTextAlignmentLeft;
    _titleLabelBackgroundColor = [UIColor lightGrayColor];
    
    _aotoScrollTimeInterval = 2.0;
    _autoScroll = YES;
    _infiniteLoop = YES;
}

-(void)setupMainView
{
    //設置collectionview
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = self.bounds.size;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = [UIColor clearColor];
    [mainView registerClass:[LLYCycleCell class] forCellWithReuseIdentifier:@"cellId"];
    mainView.showsVerticalScrollIndicator = false;
    mainView.showsHorizontalScrollIndicator = false;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = false;
    [self addSubview:mainView];
    _mainView = mainView;
}

-(void)setImageUrlStringGroup:(NSArray *)imageUrlStringGroup
{
    _imageUrlStringGroup = imageUrlStringGroup;
    
    NSMutableArray *temp  = [NSMutableArray array];
    
    [_imageUrlStringGroup enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSString *urlString;
        
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        }else if([obj isKindOfClass:[NSURL class]]){
            
            NSURL *url = obj;
            urlString = [url absoluteString];
            
            
        }
        if (urlString) {
            [temp addObject:urlString];
        }
        
        
    }];
    self.imagePathsGroup = [temp copy];
}

-(void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    [self invalidateTime];
    
    _imagePathsGroup = imagePathsGroup;
    
    _totalItemsCount = self.imagePathsGroup.count * 50;
    if (imagePathsGroup.count != 1) {
        [self setAutoScroll:self.autoScroll];
    }else
    {
        _mainView.scrollEnabled = false;
    }
    [self.mainView reloadData];
    
}

-(void)setAotoScrollTimeInterval:(CGFloat)aotoScrollTimeInterval
{
    _aotoScrollTimeInterval = aotoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
    
}

-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    if (_timer) {
        
        [self invalidateTime];
    }
    if (_autoScroll) {
        
        [self setupTimer];
        
    }
}

-(void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.aotoScrollTimeInterval target:self selector:@selector(automicScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)automicScroll
{
    if (_totalItemsCount == 0) return;
    
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
#warning 计算scroll 的 index 
        NSLog(@"scroll to next one");
        [self scrollToIndex:10];

    }
    
}

-(void)scrollToIndex:(int)index
{
    if (index >= _totalItemsCount) {
        if (_infiniteLoop) {
            
            index = _totalItemsCount * 0.5;
            [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

            return;
            
        }
        
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
}

-(void)invalidateTime
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLYCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    long itemIndex = [self pageControlIndexWithCurrentIndex:indexPath.item];
    
    NSString *urlString = self.imagePathsGroup[itemIndex];
    
    if ([urlString hasPrefix:@"http"]) {
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"testimage"]];
        
    }
    
    
    
    cell.title = @"test _ test";
    cell.titleLabelHeight = _titleLabelHeight;
    cell.titleLabelTextColor = _titleLabelTextColor;
    cell.titleLabelTextFont = _titleLabelTextFont;
    cell.titleLabelTextAlignment = _titleLabelTextAlignment;
    cell.titleLabelBackgroundColor = _titleLabelBackgroundColor;
    
    return cell;
}

-(int)pageControlIndexWithCurrentIndex:(NSInteger) index
{
    return (int)index % self.imagePathsGroup.count;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %ld  row = %ld", indexPath.section, indexPath.row);
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"did scroll");
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
    if (_timer) {
        [self invalidateTime];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_infiniteLoop) {
        [self setupTimer];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     NSLog(@"scrollViewDidEndDecelerating");
}

@end
