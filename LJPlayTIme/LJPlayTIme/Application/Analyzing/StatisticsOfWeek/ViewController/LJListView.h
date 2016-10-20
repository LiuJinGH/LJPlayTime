//
//  LJListView.h
//  Demo_UIScrollView
//
//  Created by 刘瑾 on 16/9/23.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ThemeViewStyle) {
    ThemeViewStyleCornerRadius,
    ThemeViewStyleNone,
    ThemeViewStyleNormal,
};

//typedef enum : NSUInteger {
//    ThemeViewStyleCornerRadius,
//    ThemeViewStyleNone,
//    ThemeViewStyleNormal,
//} ThemeViewStyle;

@class LJListView;

@protocol LJListViewDataSource <NSObject>

-(UIView *)listView:(LJListView *)listView viewForListInIndex:(NSInteger)index andThemeView:(UIView *)themeView;

@end

@interface LJListView : UIView

+(instancetype )listViewWithDataList:(NSMutableArray *)dataList andItemSize:(CGSize) itemSize andDelegate:(id <LJListViewDataSource>) delegate andTag:(NSInteger) tag;

-(void)updataThemeView:(ThemeViewStyle) themeViewStyle;
@property (nonatomic) UIColor *themeViewColor;

@end
