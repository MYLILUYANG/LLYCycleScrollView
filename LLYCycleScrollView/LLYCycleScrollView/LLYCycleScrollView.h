//
//  LLYCycleScrollView.h
//  LLYCycleScrollView
//
//  Created by Lu Yang Li on 2017/5/2.
//  Copyright © 2017年 Lu Yang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLYCycleScrollViewDelegate <NSObject>



@end

@interface LLYCycleScrollView : UIView

@property (nonatomic, weak) id<LLYCycleScrollViewDelegate>delegate;

@property (nonatomic, strong)   UIImage     *placeholderImage;

@property (nonatomic, assign)   CGFloat     titleLabelHeight;
@property (nonatomic, strong)   UIColor     *titleLabelTextColor;
@property (nonatomic, strong)   UIColor     *titleLabelBackgroundColor;
@property (nonatomic, strong)   UIFont      *titleLabelTextFont;
@property (nonatomic, assign)   NSTextAlignment titleLabelTextAlignment;

@property (nonatomic, copy)     NSString    *title;

/**
 网络图片数组
 */
@property (nonatomic, strong) NSArray *imageUrlStringGroup;

/**
 每张图片对应的文字数组
 */
@property (nonatomic, strong) NSArray *titlesGroup;

/**
 本地图片数组
 */
@property (nonatomic, strong) NSArray *localImageNamesGroup;


+(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate placeholderImage:(UIImage *)placeholderImage;

@end
