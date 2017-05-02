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

@property (nonatomic, strong) UIImage *placeholderImage;

+(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate placeholderImage:(UIImage *)placeholderImage;

@end
