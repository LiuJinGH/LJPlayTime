//
//  TestVC.m
//  Demo_UIScrollView
//
//  Created by 刘瑾 on 16/9/23.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "TestVC.h"
#import "IndicatorView.h"

@implementation TestVC

#pragma mark - method

-(UIView *)viewForCellItem:(UIView *)themeView andIndex:(NSInteger)index{
    
//    UIButton *bt = [UIButton buttonWithType:UIButtonTypeSystem];
//    [bt setTitle:@"测试" forState:UIControlStateNormal];
//    CGFloat width = CGRectGetWidth(themeView.frame);
//    CGFloat height = CGRectGetHeight(themeView.frame);
//    [bt setFrame:CGRectMake(5, 5, width - 10, height - 10)];
//    if (index % 2) {
//        themeView.layer.borderColor = [UIColor fouColor].CGColor;
//    }
//    
//    return bt;
    CGSize size = themeView.frame.size;
    CGFloat width = size.width > size.height ? size.height : size.width;
    IndicatorView *iv = [[IndicatorView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    iv.center = CGPointMake(size.width / 2, size.height / 2);
    CGFloat progress = (arc4random() % 81 + 10) / 100.0;
    iv.progress = progress;
    return iv;
    
}

#pragma mark - life

-(void)viewDidLoad{
    [super viewDidLoad];
//    self.columnTitles = [NSMutableArray arrayWithObjects:@"周一", @"周二", @"周三", @"周四", @"周五", nil];
    self.rowListHeight = 60;
    self.headSize = CGSizeMake(100, 60);
    self.sectionHeaderThemeViewColor = [UIColor fouColor];
    self.columnTitleColor = [UIColor fouColor];
    self.sectionHeaderThemeViewStyle = ThemeViewStyleCornerRadius;
    
}

@end
