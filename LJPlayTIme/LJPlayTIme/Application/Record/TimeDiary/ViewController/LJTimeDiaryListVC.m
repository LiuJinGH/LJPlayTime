//
//  LJTimeDiaryListVC.m
//  LJPlayTIme
//
//  Created by 刘瑾 on 2016/10/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJTimeDiaryListVC.h"
#import "LJDayListCell.h"

@implementation LJTimeDiaryListVC

#pragma mark - life

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerClass:[LJDayListCell class] forCellReuseIdentifier:@"LJDayListCell"];
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.pagingEnabled = YES;
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LJDayListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJDayListCell" forIndexPath:indexPath];
    
    cell.timeLabel.text = @[@"8:00", @"9:00", @"10:00", @"11:00", @"12:00", @"13:00", @"14:00"][indexPath.row];
    
    [cell expectTextV];
    [cell actualTextV];
    [cell standV];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

@end
