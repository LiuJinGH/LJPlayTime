//
//  LJGridViewController.m
//  Demo_UIScrollView
//
//  Created by 刘瑾 on 16/9/23.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJGridViewController.h"


//#define MAS_SHORTHAND_GLOBALS
//#import "Masonry.h"

/*
    tag值使用注明：
        smallTable ：711
        bigTable:   712
        bigTable中的第一个Section Head View：721
        bigTable中的每个cell ：722
        每个ListView中的item ：731
 */
#define BIGTABLE 712
#define SMALLTABLE 711
#define SECTION_HEAD_VIEW 721
#define CELL 722

#define MAIN_VIEW_HEIGHT self.view.frame.size.height
#define MAIN_VIEW_WIDTH self.view.frame.size.width
#define SMALLTABLE_WIDTH 80
#define BIGSCROLLVIEW_WIDTH ((MAIN_VIEW_WIDTH)-(SMALLTABLE_WIDTH))

@interface LJGridViewController ()<UITableViewDelegate,UITableViewDataSource,LJListViewDataSource>

@property (nonatomic) UITableView *smallTable;

@property (nonatomic) UIScrollView *bigScrollView;

@property (nonatomic) LJListView *sectionHeaderView;
@end

@implementation LJGridViewController

#pragma mark - method

-(UIView *)viewForRowTitle:(UIView *)themeView andIndex:(NSInteger)index{
    
    CGSize size = themeView.frame.size;
    UILabel *lb = [UILabel new];
    [lb setFrame:CGRectMake(5, 5, size.width - 10, size.height - 10)];
    lb.text = self.columnTitles[index];
    lb.textAlignment = NSTextAlignmentCenter;
    return lb;
    
}

-(UIView *)viewForCellItem:(UIView *)themeView andIndex:(NSInteger)index{
    
    return nil;
}

#pragma mark - life

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor grayColor];
    self.headSize = CGSizeMake(100, 60);
    [self.smallTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.bigTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.sectionHeaderThemeViewStyle = ThemeViewStyleCornerRadius;
    
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowTitles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (tableView.tag == SMALLTABLE) {
        cell.textLabel.text = self.rowTitles[indexPath.row];
        
    }else{
        
        LJListView *lv = [cell viewWithTag:CELL];
        if (!lv) {
            LJListView *v = [LJListView listViewWithDataList:self.columnTitles andItemSize:CGSizeMake(self.headSize.width, self.rowListHeight) andDelegate:self andTag:CELL];
            [cell.contentView addSubview:v];
        }else{
            
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [self columnTitleColor];
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == BIGTABLE) {
        return self.sectionHeaderView;
    }
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headSize.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.rowListHeight;
}
#pragma mark - UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.y;
    CGPoint offsetSY = self.smallTable.contentOffset;
    CGPoint offsetBY = self.bigTable.contentOffset;
    offsetBY.y = offset;
    offsetSY.y = offset;
    self.smallTable.contentOffset = offsetSY;
    self.bigTable.contentOffset = offsetBY;
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        CGFloat offsetX = scrollView.contentOffset.x;
        CGPoint offset = scrollView.contentOffset;
        CGFloat headSizeWidth = self.headSize.width;
        int bPart = (int)offsetX / headSizeWidth;
        int sPart = (int)offsetX % (int)headSizeWidth;
        
        [UIView animateWithDuration:0.1 animations:^{
            
            CGFloat offsetTemp;
            if (sPart > (headSizeWidth / 2)) {
                offsetTemp = (bPart + 1) * headSizeWidth;
            }else{
                offsetTemp = bPart * headSizeWidth;
            }
            if ((offsetTemp + scrollView.frame.size.width) > scrollView.contentSize.width) {
                offsetTemp = scrollView.contentSize.width - scrollView.frame.size.width + 20;
            }
            scrollView.contentOffset = CGPointMake(offsetTemp, offset.y);
            
        }];
    }
    
}

#pragma mark - LJListView

/**
 *  在这个方法设置网格项的视图，一次设置一行
 *
 *  @param listView  需要设置的行视图
 *  @param index     行数据
 *  @param themeView 该数据项的视图
 *
 *  @return 该数据项的内容视图
 */
-(UIView *)listView:(LJListView *)listView viewForListInIndex:(NSInteger)index andThemeView:(UIView *)themeView{
    
    if (listView.tag == SECTION_HEAD_VIEW) {
        return [self viewForRowTitle:themeView andIndex:index];
    }
    
    if (listView.tag == CELL) {
        return [self viewForCellItem:themeView andIndex:index];
    }
    
    return nil;
}

#pragma mark - setter

-(void)setSectionHeaderThemeViewColor:(UIColor *)sectionHeaderThemeViewColor{
    self.sectionHeaderView.themeViewColor = sectionHeaderThemeViewColor;
}

-(void)setSectionHeaderThemeViewStyle:(ThemeViewStyle)sectionHeaderThemeViewStyle{
    if (_sectionHeaderThemeViewStyle == sectionHeaderThemeViewStyle) {
        return;
    }else{
        [self.sectionHeaderView updataThemeView:sectionHeaderThemeViewStyle];
    }
}

#pragma mark - Lazy

- (UIScrollView *)bigScrollView {
	if(_bigScrollView == nil) {
		_bigScrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_bigScrollView];
        _bigScrollView.delegate = self;
        _bigScrollView.bounces = NO;
        _bigScrollView.backgroundColor = [UIColor purpleColor];
        [_bigScrollView setFrame:CGRectMake(SMALLTABLE_WIDTH, 0, BIGSCROLLVIEW_WIDTH, MAIN_VIEW_HEIGHT)];
        
	}
	return _bigScrollView;
}

- (UITableView *)smallTable {
	if(_smallTable == nil) {
		_smallTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_smallTable];
        _smallTable.delegate = self;
        _smallTable.dataSource = self;
        _smallTable.bounces = NO;
        _smallTable.showsHorizontalScrollIndicator = NO;
        _smallTable.showsVerticalScrollIndicator = NO;
        _smallTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _smallTable.tag = SMALLTABLE;
        _smallTable.backgroundColor = [UIColor whiteColor];
        [_smallTable setFrame:CGRectMake(0, 0, SMALLTABLE_WIDTH, MAIN_VIEW_HEIGHT)];
        
	}
	return _smallTable;
}

- (UITableView *)bigTable {
	if(_bigTable == nil) {
		_bigTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.bigScrollView addSubview:_bigTable];
        _bigTable.delegate = self;
        _bigTable.dataSource = self;
        _bigTable.bounces = NO;
        _bigTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bigTable.tag = BIGTABLE;
        [_bigTable setFrame:CGRectMake(0, 0, BIGSCROLLVIEW_WIDTH, MAIN_VIEW_HEIGHT)];
        
	}
	return _bigTable;
}

- (NSArray *)rowTitles {
	if(_rowTitles == nil) {
		_rowTitles = @[@"6:00", @"7:00", @"8:00", @"9:00", @"10:00", @"11:00", @"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00", @"19:00", @"20:00", @"21:00", @"22:00", @"23:00"];
	}
	return _rowTitles;
}

- (NSMutableArray *)columnTitles {
	if(_columnTitles == nil) {
		_columnTitles = [NSMutableArray arrayWithObjects:@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期天", nil];
	}
	return _columnTitles;
}

- (LJListView *)sectionHeaderView {
	if(_sectionHeaderView == nil) {
        
        LJListView *v = [LJListView listViewWithDataList:self.columnTitles andItemSize:CGSizeMake(self.headSize.width, self.headSize.height) andDelegate:self andTag:SECTION_HEAD_VIEW];
        self.bigScrollView.contentSize = CGSizeMake(CGRectGetWidth(v.frame), 0);
        [self.bigTable setFrame:CGRectMake(0, 0, CGRectGetWidth(v.frame), CGRectGetHeight(self.bigScrollView.frame))];
        
		_sectionHeaderView = v;
	}
	return _sectionHeaderView;
}

- (CGFloat)rowListHeight {
    if(!_rowListHeight) {
        _rowListHeight = 45;
    }
    return _rowListHeight;
}
@end
