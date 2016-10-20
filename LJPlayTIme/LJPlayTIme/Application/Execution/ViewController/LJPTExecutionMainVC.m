//
//  LJPTExecutionMainVC.m
//  LJPlayTIme
//
//  Created by 刘瑾 on 2016/10/12.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJPTExecutionMainVC.h"
#import "LJListQuadrantVC.h"

@interface LJPTExecutionMainVC ()

@end

@implementation LJPTExecutionMainVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.mainColor = [UIColor thiColor];
    self.indexTag = 103;
    self.navigationItem.title = @"执行";
    
    LJListQuadrantVC *listQuadrantVC = [LJListQuadrantVC new];
    listQuadrantVC.navigationItem.title = @"时间四象限";
    [self inputNVCWithRootController:listQuadrantVC];
    
}

@end
