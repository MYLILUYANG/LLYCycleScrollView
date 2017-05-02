//
//  ViewController.m
//  LLYCycleScrollView
//
//  Created by Lu Yang Li on 2017/5/2.
//  Copyright © 2017年 Lu Yang Li. All rights reserved.
//

#import "ViewController.h"
#import "LLYCycleScrollView.h"

#define K_ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    LLYCycleScrollView *cycView = [LLYCycleScrollView initWithFrame:CGRectMake(0, 64, K_ScreenWidth, 180) delegate:self placeholderImage:nil];
    [self.view addSubview:cycView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
