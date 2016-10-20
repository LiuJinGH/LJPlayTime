//
//  LJQuadrantView.m
//  LJWorkQuqdarant
//
//  Created by 刘瑾 on 16/9/26.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJQuadrantView.h"

@interface LJQuadrantView ()<UITableViewDelegate, UITableViewDataSource>



@property (nonatomic) UIColor *listViewColor;

@end

@implementation LJQuadrantView

#pragma mark - life

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.tapWithOriginRect = frame;
        self.textInCenter = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self.titleLb setFrame:CGRectMake(0, 5, self.frame.size.width, 30)];
    
    [self.listView setFrame:CGRectMake(10, 30 + 15, self.frame.size.width - 20, self.frame.size.height - 30 -15 - 20)];
    
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    cell.textLabel.text = @"工作任务项工作任务项工作任务项";
    if (self.textInCenter) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.numberOfLines = 1;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        
    }else{
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
    return cell;
}

#pragma mark - Lazy

- (UILabel *)titleLb {
	if(_titleLb == nil) {
		_titleLb = [[UILabel alloc] init];
        [self addSubview:_titleLb];
        
        _titleLb.font = [UIFont systemFontOfSize:18];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
//        _titleLb.backgroundColor = [UIColor grayColor];
        
        [_titleLb setFrame:CGRectMake(0, 5, self.frame.size.width, 30)];
        
        
        //一些初始化设置
        self.flgatToBig = YES;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
	}
	return _titleLb;
}

- (UITableView *)listView {
	if(_listView == nil) {
		_listView = [[UITableView alloc] initWithFrame:CGRectMake(10, 30 + 15, self.frame.size.width - 20, self.frame.size.height - 30 -15 - 20) style:UITableViewStylePlain];
        [self addSubview:_listView];
        
        _listView.delegate = self;
        _listView.dataSource = self;
        [_listView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _listView.backgroundColor = self.listViewColor;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.layer.cornerRadius = 8;
        _listView.layer.masksToBounds = YES;
        
	}
	return _listView;
}

- (UIColor *)listViewColor {
	if(_listViewColor == nil) {
		_listViewColor = [UIColor clearColor];
	}
	return _listViewColor;
}

@end
