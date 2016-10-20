//
//  LJWorkBasketViewController.m
//  LJWorkBasketView
//
//  Created by 刘瑾 on 16/9/25.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJWorkBasketViewController.h"
#import "LJCustomAlert.h"

#define kTipText @"今日已写入任务项：%ld条"

@interface LJWorkBasketViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic)  UIView *showView;

@property (nonatomic)  UIView *listView;

@property (nonatomic) UITapGestureRecognizer *listSingleTapGestureRecognizer;
@property (nonatomic) UITapGestureRecognizer *btnSingleTapGestureRecognizer;

@property (nonatomic) UIView *btnLongView;
@property (nonatomic) UIView *btnCircucalView;

@property (nonatomic) UIColor *greenColor;

@property (nonatomic) UIColor *redColor;

@property (nonatomic) UILabel *showLabel;

@property (nonatomic) LJCustomAlert *taskAlert;

@property (nonatomic) UITableView *taskListView;

@property (nonatomic) NSMutableArray<NSString *> *taskListDatas;

@property (nonatomic) NSString *tempTask;

@end

@implementation LJWorkBasketViewController

#pragma mark - method

//切换大/小篮子视图
-(void )singleTap:(UITapGestureRecognizer *)sender{
    
    static BOOL flagt = YES;
    
    if (flagt) {
        //隐藏showView alpha设置为0
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.showView.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
        }];
        //扩大listView
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            CGSize size = self.view.frame.size;
            
            [_listView setFrame:CGRectMake(10, 10, size.width - 10 * 2, size.height - 20)];
            CGSize listViewSize = self.listView.frame.size;
            CGFloat offset = 10;
            _taskListView.frame = CGRectMake(offset, offset, listViewSize.width - offset * 2, listViewSize.height - offset * 2);
            
        } completion:^(BOOL finished) {
            
            [UIView transitionWithView:_listView duration:0.5 options: UIViewAnimationOptionCurveLinear animations:^{
                
                _listView.backgroundColor = self.redColor;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
    }else{
        //显示showView alpha为1
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.showView.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            
        }];
        //缩小listView
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            CGRect frame = self.showView.frame;
            
            [_listView setFrame:CGRectMake(10, frame.origin.y + frame.size.height + 10, frame.size.width, frame.size.height)];
            CGSize listViewSize = self.listView.frame.size;
            CGFloat offset = 10;
            _taskListView.frame = CGRectMake(offset, offset, listViewSize.width - offset * 2, listViewSize.height - offset * 2);
            
        } completion:^(BOOL finished) {
            
            [UIView transitionWithView:_listView duration:0.5 options: UIViewAnimationOptionCurveLinear animations:^{
                _listView.backgroundColor = self.greenColor;
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
    }
    
    flagt = !flagt;
}

-(void )btnTap:(UITapGestureRecognizer *)sender{
    
    static BOOL flagt = YES;
    
    if (flagt) {
        
        [UIView animateWithDuration:1.0 animations:^{
            //收起
            CGPoint center = self.btnLongView.center;
            CGSize size = self.btnCircucalView.frame.size;
            [self.btnLongView setFrame:CGRectMake(0, 0, size.width, self.btnLongView.frame.size.height)];
            self.btnLongView.center = center;
            UIColor *tempColor = [UIColor colorWithCGColor:self.btnCircucalView.layer.borderColor];
            self.btnCircucalView.layer.borderColor = [UIColor whiteColor].CGColor;
            
            self.btnCircucalView.backgroundColor = tempColor;
            
            [self.view bringSubviewToFront:self.btnCircucalView];
            
        } completion:^(BOOL finished) {
            [self presentViewController:self.taskAlert animated:YES completion:nil];
        }];
        
    }else{
        //展开
        [UIView animateWithDuration:1.0 animations:^{
            
            CGSize size = self.showView.frame.size;
            CGFloat height = (size.height / 4) * 3;
            
            [self.btnLongView setFrame:CGRectMake(20, height, size.width - 40, 10)];
            
            self.btnCircucalView.layer.borderColor = self.btnCircucalView.backgroundColor.CGColor;
            self.btnCircucalView.backgroundColor = [UIColor whiteColor];
        }];
        
    }
    
    flagt = !flagt;
}

#pragma mark - UITextField

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0) {
        self.tempTask = textField.text;
    }
    
    textField.text = @"";
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.taskListDatas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"NO.%ld ", indexPath.row + 1];
    
    NSInteger index = self.taskListDatas.count - 1 - indexPath.row;
    
    [str appendString:self.taskListDatas[index]];
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.showView.layer.cornerRadius = 10;
    self.showView.layer.masksToBounds = YES;
    self.listView.layer.cornerRadius = 10;
    self.listView.layer.masksToBounds = YES;
    
    [self.listView addGestureRecognizer:self.listSingleTapGestureRecognizer];
    
    [self btnLongView];
    [self showLabel];
    [self btnCircucalView];
}

#pragma Lazy

- (UILabel *)showLabel {
    if(_showLabel == nil) {
        _showLabel = [[UILabel alloc] init];
        [self.showView addSubview:_showLabel];
        
        _showLabel.backgroundColor = [UIColor clearColor];
        _showLabel.textColor = [UIColor whiteColor];
        _showLabel.adjustsFontSizeToFitWidth = YES;
        _showLabel.font = [UIFont systemFontOfSize:25];
        _showLabel.textAlignment = NSTextAlignmentCenter;
        _showLabel.text = [NSString stringWithFormat:kTipText, self.taskListDatas.count];
        
        CGSize size = self.showView.frame.size;
        CGFloat x = size.width / 2;
        CGFloat y = size.height / 4;
        
        [_showLabel setFrame:CGRectMake(0, 0, size.width - 60, size.height / 4 - 20)];
        
        _showLabel.center = CGPointMake(x, y);
        
    }
    return _showLabel;
}

- (UIView *)btnLongView {
    if(_btnLongView == nil) {
        _btnLongView = [[UIView alloc] init];
        [self.showView addSubview:_btnLongView];
        
        _btnLongView.backgroundColor = self.greenColor;
        
        CGSize size = self.showView.frame.size;
        CGFloat height = (size.height / 4) * 3;
        
        [_btnLongView setFrame:CGRectMake(20, height, size.width - 40, 10)];
        _btnLongView.layer.cornerRadius = (_btnLongView.frame.size.height / 2);
        _btnLongView.layer.masksToBounds = YES;
        
    }
    return _btnLongView;
}

- (UIView *)btnCircucalView {
    if(_btnCircucalView == nil) {
        _btnCircucalView = [[UIView alloc] init];
        [self.showView addSubview:_btnCircucalView];
        
        _btnCircucalView.backgroundColor = [UIColor whiteColor];
        
        CGSize size = self.showView.frame.size;
        CGFloat radius = size.height / 4;
        [_btnCircucalView setFrame:CGRectMake(0, 0, radius, radius)];
        _btnCircucalView.center = _btnLongView.center;
        
        _btnCircucalView.layer.cornerRadius = radius / 2;
        _btnCircucalView.layer.masksToBounds = YES;
        _btnCircucalView.layer.borderWidth = 10;
        _btnCircucalView.layer.borderColor = self.greenColor.CGColor;
        
        [_btnCircucalView addGestureRecognizer:self.btnSingleTapGestureRecognizer];
    }
    return _btnCircucalView;
}

- (UIView *)showView {
    if(_showView == nil) {
        _showView = [[UIView alloc] init];
        [self.view addSubview:_showView];
        
        _showView.backgroundColor = self.redColor;
        
        CGSize size = self.view.frame.size;
        
        [_showView setFrame:CGRectMake(10, 10, size.width - 10 * 2, (size.height - 3 * 10 - 115) / 2 )];
        
        [self taskListView];
        
    }
    return _showView;
}

- (UIView *)listView {
    if(_listView == nil) {
        _listView = [[UIView alloc] init];
        [self.view addSubview:_listView];
        
        _listView.backgroundColor = self.greenColor;
        
        CGRect frame = self.showView.frame;
        
        [_listView setFrame:CGRectMake(10, frame.origin.y + frame.size.height + 10, frame.size.width, frame.size.height)];
        
    }
    return _listView;
}

- (UITapGestureRecognizer *)listSingleTapGestureRecognizer {
	if(_listSingleTapGestureRecognizer == nil) {
        _listSingleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        
        _listSingleTapGestureRecognizer.numberOfTapsRequired = 1;
        
	}
	return _listSingleTapGestureRecognizer;
}

- (UITapGestureRecognizer *)btnSingleTapGestureRecognizer {
    if(_btnSingleTapGestureRecognizer == nil) {
        _btnSingleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTap:)];
        
        _btnSingleTapGestureRecognizer.numberOfTapsRequired = 1;
    }
    return _btnSingleTapGestureRecognizer;
}

- (UIColor *)greenColor {
	if(_greenColor == nil) {
        _greenColor = [UIColor secColor];

	}
	return _greenColor;
}

- (UIColor *)redColor {
	if(_redColor == nil) {
        _redColor = [UIColor firColor];

	}
	return _redColor;
}

- (LJCustomAlert *)taskAlert {
	if(_taskAlert == nil) {
		
        _taskAlert = [LJCustomAlert alertControllerWithTitle:@"输入任务描述" message:@"请输入简洁的任务描述" preferredStyle:UIAlertControllerStyleAlert withTopColor:self.redColor andButColor:self.greenColor];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.tempTask = nil;
            [self btnTap:nil];
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.tempTask) {
                [self.taskListDatas addObject:self.tempTask];
                self.showLabel.text = [NSString stringWithFormat:kTipText, self.taskListDatas.count];
                [self.taskListView reloadData];
            }
            self.tempTask = nil;
            
            [self btnTap:nil];
            
        }];
        
        [_taskAlert addAction:action1];
        [_taskAlert addAction:action2];
        
        __weak typeof (self) weakSelf = self;
        [_taskAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            UIColor *color = kRGBColor(247, 180, 180, 1.0);
            
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"简洁的任务描述" attributes:@{NSForegroundColorAttributeName : color}];
            
            textField.attributedPlaceholder = str;
            textField.textColor = weakSelf.redColor;
            
            textField.delegate = weakSelf;
        }];
        
	}
	return _taskAlert;
}

- (UITableView *)taskListView {
	if(_taskListView == nil) {
        
		_taskListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.listView addSubview:_taskListView];
        
        CGSize size = self.listView.frame.size;
        CGFloat offset = 10;
        _taskListView.frame = CGRectMake(offset, offset, size.width - offset * 2, size.height - offset * 2);
        
        _taskListView.backgroundColor = [UIColor clearColor];
        
        _taskListView.delegate = self;
        _taskListView.dataSource = self;
        
        _taskListView.tableFooterView = [UIView new];
        _taskListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_taskListView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
	}
	return _taskListView;
}

- (NSMutableArray<NSString *> *)taskListDatas {
	if(_taskListDatas == nil) {
		_taskListDatas = [[NSMutableArray alloc] init];
        
        [_taskListDatas addObject:@"睡觉"];
        [_taskListDatas addObject:@"吃饭"];
        [_taskListDatas addObject:@"洗澡澡"];
        
	}
	return _taskListDatas;
}

@end
