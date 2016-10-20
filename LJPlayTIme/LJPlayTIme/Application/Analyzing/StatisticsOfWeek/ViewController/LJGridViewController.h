//
//  LJGridViewController.h
//  Demo_UIScrollView
//
//  Created by 刘瑾 on 16/9/23.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJListView.h"


@interface LJGridViewController : UIViewController

@property (nonatomic) NSArray *rowTitles;
@property (nonatomic) NSMutableArray *columnTitles;
@property (nonatomic) CGSize headSize;
@property (nonatomic) CGFloat rowListHeight;
@property (nonatomic) ThemeViewStyle sectionHeaderThemeViewStyle;
@property (nonatomic) UIColor *sectionHeaderThemeViewColor;
@property (nonatomic) UIColor *columnTitleColor;
@property (nonatomic) UITableView *bigTable;

-(UIView *)viewForRowTitle:(UIView *)themeView andIndex:(NSInteger)index;
-(UIView *)viewForCellItem:(UIView *)themeView andIndex:(NSInteger)index;

@end
