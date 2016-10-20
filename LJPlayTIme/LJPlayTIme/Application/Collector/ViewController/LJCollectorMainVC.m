//
//  LJCollectorMainVC.m
//  LJPlayTIme
//
//  Created by 刘瑾 on 2016/10/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJCollectorMainVC.h"
#import "LJWorkBasketViewController.h"

@implementation LJCollectorMainVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.mainColor = [UIColor secColor];
    self.indexTag = 102;
    self.navigationItem.title = @"收集";
    
    LJWorkBasketViewController *workBasketC = [LJWorkBasketViewController new];
    workBasketC.navigationItem.title = @"工作蓝";
    [self inputNVCWithRootController:workBasketC];
    
}

@end
