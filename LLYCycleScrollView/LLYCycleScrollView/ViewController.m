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
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];

    self.view.backgroundColor = [UIColor whiteColor];
    LLYCycleScrollView *cycView = [LLYCycleScrollView initWithFrame:CGRectMake(0, 64, K_ScreenWidth, 180) delegate:self placeholderImage:nil];
    cycView.imageUrlStringGroup = imagesURLStrings;
    [self.view addSubview:cycView];
        UIPageControl *controller = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 300, K_ScreenWidth, 30)];
    controller.backgroundColor = [UIColor lightGrayColor];
    controller.numberOfPages = 6;
    controller.currentPage = 2;
    controller.tintColor = [UIColor yellowColor];
    [self.view addSubview:controller];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
