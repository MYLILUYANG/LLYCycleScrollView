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


+(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate placeholderImage:(UIImage *)placeholderImage;

@end
