//
//  LJPTRecordMianVC.m
//  LJPlayTIme
//
//  Created by 刘瑾 on 2016/10/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJPTRecordMainVC.h"
#import "LJTimeDiaryListVC.h"

@implementation LJPTRecordMainVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.mainColor = [UIColor firColor];
    
    self.indexTag = 101;
    self.firstVCFlage = YES;
    self.navigationItem.title = @"记录";
    
    LJTimeDiaryListVC *diaryListVC = [LJTimeDiaryListVC new];
    diaryListVC.navigationItem.title = @"时间日记";
    [self inputNVCWithRootController:diaryListVC];
    
}

@end
