//
//  LJListView.m
//  Demo_UIScrollView
//
//  Created by 刘瑾 on 16/9/23.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJListView.h"

@interface LJListView ()
{
    UIColor *_themeViewColor;
}

@property (nonatomic) CGSize itemSize;

@property (nonatomic) NSMutableArray *dataList;
@property (nonatomic, weak) id <LJListViewDataSource> delegate;
@property (nonatomic) UIView *themeView;

@property (nonatomic) NSMutableArray *themeViewArray;

@end

@implementation LJListView

#pragma mark - method

-(void)updataThemeView:(ThemeViewStyle)themeViewStyle{
    
    for (UIView *themeView in self.themeViewArray) {
        
        switch (themeViewStyle) {
            case ThemeViewStyleCornerRadius:
                
                themeView.layer.cornerRadius = 5;
                
                break;
                
            case ThemeViewStyleNone:
                
                themeView.layer.borderWidth = 0;
                
            case ThemeViewStyleNormal:
                
                themeView.layer.cornerRadius = 0;
                
            default:
                break;
        }
    }
    [self setNeedsDisplay];
}

/**
 *  初始化ListView的设置
 */

-(void )setupListView{
    
    CGFloat width = self.itemSize.width;
    CGFloat height = self.itemSize.height;
    int i;
    
    for (i = 0; i < self.dataList.count; i ++) {
        
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        
        _themeView = [UIView new];
        [_themeView setFrame:CGRectMake(5, 5, width - 10, height - 10)];
        _themeView.layer.borderWidth = 2;
        _themeView.layer.borderColor = [UIColor grayColor].CGColor;
        _themeView.layer.cornerRadius = 5;
        _themeView.layer.masksToBounds = YES;
        
        UIView *v3 = [self.delegate listView:self viewForListInIndex:i andThemeView:_themeView];
        v3.tag = 731;
        if (v3) {
            [_themeView addSubview:v3];
        }
        [self.themeViewArray addObject:_themeView];
        
        [itemView addSubview:_themeView];
        [self addSubview:itemView];
        
    }
    
    [self setFrame:CGRectMake(0, 0, i * width, height)];
    
}

#pragma mark - life

/**
 *  工厂方法
 *
 *  @param dataList 行数据
 *  @param itemSize 每个数据项的大小
 *  @param delegate 代理对象
 *  @param tag      标识
 *
 *  @return ListView对象
 */

+(instancetype)listViewWithDataList:(NSMutableArray *)dataList andItemSize:(CGSize)itemSize andDelegate:(id<LJListViewDataSource>)delegate andTag:(NSInteger)tag{
    LJListView *v = [LJListView new];
    if (v) {
        v.dataList = dataList;
        v.itemSize = itemSize;
        v.delegate = delegate;
        v.tag = tag;
        v.backgroundColor = [UIColor whiteColor];
        [v setupListView];
        
    }
    return v;
}

#pragma mark - setter

-(void)setThemeViewColor:(UIColor *)themeViewColor{
    _themeViewColor = themeViewColor;
    
    for (UIView *themeView in self.themeViewArray) {
        themeView.layer.borderColor = _themeViewColor.CGColor;
    }
}

#pragma mark - Lazy

- (NSMutableArray *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (NSMutableArray *)themeViewArray {
    if(_themeViewArray == nil) {
        _themeViewArray = [[NSMutableArray alloc] init];
    }
    return _themeViewArray;
}

- (UIColor *)themeViewColor {
	if(_themeViewColor == nil) {
		_themeViewColor = [UIColor grayColor];
	}
	return _themeViewColor;
}

@end
