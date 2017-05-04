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

-(void)initlizetion
{
    //初始化各项默认参数
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont = [UIFont systemFontOfSize:14];
    _titleLabelHeight = 30;
    _titleLabelTextAlignment = NSTextAlignmentLeft;
    _titleLabelBackgroundColor = [UIColor lightGrayColor];
    
    
    
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
    _imagePathsGroup = imagePathsGroup;
    
    _totalItemsCount = self.imagePathsGroup.count * 50;
    
    [self.mainView reloadData];
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





@end
