//
//  LJCustomNVC.m
//  LJTabbarVCDemo
//
//  Created by 刘瑾 on 2016/10/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJCustomNVC.h"

@interface LJCustomNVC ()

@property (nonatomic) UIView *barBV;

@end

@implementation LJCustomNVC

#pragma mark - method

-(void )setupNvcBar{
    
    self.barBV.backgroundColor = self.mainColor;
    UINavigationBar *nvcBar = self.navigationBar;
    
    [nvcBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [nvcBar setShadowImage:[UIImage new]];
    
    [nvcBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    nvcBar.tintColor = [UIColor whiteColor];
}

#pragma mark - life

-(void)viewDidLoad{
    [super viewDidLoad];
    CGFloat width = self.view.frame.size.width;
    self.barBV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 64)];
    self.barBV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.barBV];
    [self.view bringSubviewToFront:self.navigationBar];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupNvcBar];
    self.view.layer.borderColor = self.mainColor.CGColor;
    
}

@end
