//
//  LJCustiomTBVC.m
//  LJPlayTIme
//
//  Created by 刘瑾 on 2016/10/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJCustomTBVC.h"
#import "LJPTRecordMainVC.h"
#import "LJCollectorMainVC.h"
#import "LJPTExecutionMainVC.h"
#import "LJPTAnalyzingVC.h"

@implementation LJCustomTBVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *attDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor firColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:15], NSFontAttributeName,nil];
    
    LJPTRecordMainVC *recordVC = [LJPTRecordMainVC new];
    LJCollectorMainVC *collectorVC = [LJCollectorMainVC new];
    LJPTExecutionMainVC *executionVC = [LJPTExecutionMainVC new];
    LJPTAnalyzingVC *analyzingVC = [LJPTAnalyzingVC new];
    
    recordVC.colorList = @[[UIColor secColor], [UIColor thiColor], [UIColor fouColor]];
    
    [self addChildViewController:recordVC];
    [self addChildViewController:collectorVC];
    [self addChildViewController:executionVC];
    
    [self addChildViewController:analyzingVC];
    
    [recordVC.tabBarItem setTitleTextAttributes:attDic forState:UIControlStateNormal];
    recordVC.tabBarItem.title = @"记录";
    
    [attDic setValue:[UIColor secColor] forKeyPath:NSForegroundColorAttributeName];
    [collectorVC.tabBarItem setTitleTextAttributes:attDic forState:UIControlStateNormal];
    collectorVC.tabBarItem.title = @"收集";
    
    [attDic setValue:[UIColor thiColor] forKeyPath:NSForegroundColorAttributeName];
    [executionVC.tabBarItem setTitleTextAttributes:attDic forState:UIControlStateNormal];
    executionVC.tabBarItem.title = @"执行";
    
    [attDic setValue:[UIColor fouColor] forKeyPath:NSForegroundColorAttributeName];
    [analyzingVC.tabBarItem setTitleTextAttributes:attDic forState:UIControlStateNormal];
    analyzingVC.tabBarItem.title = @"分析";
    
    self.selectedIndex = 0;
    
}

@end
