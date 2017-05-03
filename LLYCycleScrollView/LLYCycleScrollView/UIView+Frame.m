//
//  UIView+Frame.m
//  LLYCycleScrollView
//
//  Created by Lu Yang Li on 2017/5/3.
//  Copyright © 2017年 Lu Yang Li. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
-(CGFloat)lly_height
{
    return self.frame.size.height;
}

-(void)setLly_height:(CGFloat)lly_height
{
    CGRect temp = self.frame;
    temp.size.height = lly_height;
    self.frame = temp;
}

-(CGFloat)lly_width
{
    return self.frame.size.width;
}

-(void)setLly_width:(CGFloat)lly_width
{
    CGRect temp = self.frame;
    temp.size.width = lly_width;
    self.frame = temp;
}

-(CGFloat)lly_x
{
    return self.frame.origin.x;
}

-(void)setLly_x:(CGFloat)lly_x
{
    CGRect temp = self.frame;
    temp.origin.x = lly_x;
    self.frame = temp;
}

-(CGFloat)lly_y
{
    return self.frame.origin.y;
}

-(void)setLly_y:(CGFloat)lly_y
{
    CGRect temp = self.frame;
    temp.origin.y = lly_y;
    self.frame = temp;
}




@end
