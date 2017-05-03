//
//  LLYCycleCell.m
//  LLYCycleScrollView
//
//  Created by Lu Yang Li on 2017/5/3.
//  Copyright © 2017年 Lu Yang Li. All rights reserved.
//

#import "LLYCycleCell.h"
#import "UIView+Frame.h"
@interface LLYCycleCell ()



@end

@implementation LLYCycleCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    return self;
}


-(void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}


-(void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    //_titleLabel.hidden = YES;
    [self.contentView addSubview:_titleLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    CGFloat titLabelW = self.lly_width;
    CGFloat titLabelH = _titleLabelHeight;
    CGFloat titLabelX = 0;
    CGFloat titLabelY = self.lly_height - titLabelH;
    _titleLabel.frame = CGRectMake(titLabelX, titLabelY, titLabelW, titLabelH);
    
}

@end
