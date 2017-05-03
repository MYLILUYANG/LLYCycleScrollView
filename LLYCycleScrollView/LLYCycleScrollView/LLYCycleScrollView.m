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
    //初始化各项参数
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
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLYCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"testimage"];
    
    cell.titleLabel.text = @"ssssaaaaaa";
    cell.titleLabelHeight = 20.0;
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %ld  row = %ld", indexPath.section, indexPath.row);
}





@end
