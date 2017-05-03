//
//  LLYCycleCell.h
//  LLYCycleScrollView
//
//  Created by Lu Yang Li on 2017/5/3.
//  Copyright © 2017年 Lu Yang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLYCycleCell : UICollectionViewCell

@property (nonatomic, weak)     UIImageView *imageView;

@property (nonatomic, weak)     UILabel     *titleLabel;

@property (nonatomic, assign)   CGFloat     titleLabelHeight;
@property (nonatomic, strong)   UIColor     *titleLabelTextColor;
@property (nonatomic, strong)   UIColor     *titleLabelBackgroundColor;
@property (nonatomic, strong)   UIFont      *titleLabelTextFont;
@property (nonatomic, assign)   NSTextAlignment titleLabelTextAlignment;


@end
