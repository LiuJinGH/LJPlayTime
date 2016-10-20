//
//  LJPTAnalyzingVC.m
//  LJPlayTIme
//
//  Created by 刘瑾 on 2016/10/12.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJPTAnalyzingVC.h"
#import "TestVC.h"

@interface LJPTAnalyzingVC ()

@end

@implementation LJPTAnalyzingVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.mainColor = [UIColor fouColor];
    self.indexTag = 104;
    self.navigationItem.title = @"分析";
    
    TestVC *diaryListVC = [TestVC new];
    diaryListVC.navigationItem.title = @"周统计表";
    [self inputNVCWithRootController:diaryListVC];
    
}

@end
