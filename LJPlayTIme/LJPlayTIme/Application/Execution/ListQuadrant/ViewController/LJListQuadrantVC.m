//
//  LJListQuadrantVC.m
//  LJWorkQuqdarant
//
//  Created by 刘瑾 on 16/9/26.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJListQuadrantVC.h"
#import "LJQuadrantView.h"

/*
        tap使用记录
 
            firstQuadrant tap 611
            secondQuadrant tap 612
            thirdQuadrant tap 613
            fourthQuadrant tap 614
 
 */


@class LJQuadrantView;


@interface LJListQuadrantVC ()

@property (nonatomic) UIColor *firstQuadrantColor;
@property (nonatomic) UIColor *secondQuadrantColor;
@property (nonatomic) UIColor *thirdQuadrantColor;
@property (nonatomic) UIColor *fourthQuadrantColor;

@property (nonatomic) NSArray *quadrantArray;
@property (nonatomic) LJQuadrantView *firstQuadrant;
@property (nonatomic) LJQuadrantView *secondQuadrant;
@property (nonatomic) LJQuadrantView *thirdQuadrant;
@property (nonatomic) LJQuadrantView *fourthQuadrant;

@property (nonatomic) CGFloat quadrantViewWidth;
@property (nonatomic) CGFloat quadrantViewHeight;
@property (nonatomic) CGFloat separatorWidh;
@property (nonatomic) CGFloat sizeToView_Top;
@property (nonatomic) CGFloat sizeToView_Left;
@property (nonatomic) CGFloat sizeToView_Right;
@property (nonatomic) CGFloat sizeToView_Buttom;

@property (nonatomic) UITapGestureRecognizer *singleTapInFirth;
@property (nonatomic) UITapGestureRecognizer *singleTapInSecond;
@property (nonatomic) UITapGestureRecognizer *singleTapInThird;
@property (nonatomic) UITapGestureRecognizer *singleTapInFourth;

@property (nonatomic) UIView *axisX;
@property (nonatomic) UIView *axisY;

@end

@implementation LJListQuadrantVC

#pragma mark - method

-(void )singleTapToDo:(UITapGestureRecognizer *)sender{
    LJQuadrantView *v = (LJQuadrantView *)sender.view;
    
    [self.view bringSubviewToFront:v];
    
    if (v.flgatToBig) {
        [UIView animateWithDuration:.5 animations:^{
            
            [v setFrame:CGRectMake(self.sizeToView_Left, self.sizeToView_Top, self.view.frame.size.width - self.sizeToView_Left - self.sizeToView_Right, self.view.frame.size.height - self.sizeToView_Top - self.sizeToView_Buttom)];

            v.layer.cornerRadius = 20;
            v.titleLb.alpha = 0;
            v.listView.alpha= 0;
        
        } completion:^(BOOL finished) {
            
            [v.titleLb setFrame:CGRectMake(0, 5, v.frame.size.width, 30)];
            v.textInCenter = YES;
            [v.listView reloadData];
            [v setNeedsDisplay];
            
            [UIView animateWithDuration:.5 animations:^{
                
                v.titleLb.alpha = 1;
                v.listView.alpha = 1;
                
            }];
        }];
        
        for (LJQuadrantView *vOther in self.quadrantArray) {
            if (vOther != v) {
                CGSize size = self.view.frame.size;
                CGPoint center = CGPointMake(size.width / 2, size.height / 2);
                [UIView animateWithDuration:.5 animations:^{
                    [vOther setFrame:CGRectMake(center.x, center.y, 0, 0)];
                }];
                
            }
        }
        
        [UIView animateWithDuration:.5 animations:^{
            CGSize size = self.view.frame.size;
            NSLog(@"%@", NSStringFromCGSize(size));
            CGPoint center = CGPointMake(size.width / 2, size.height / 2);
            
            [self.axisY setFrame:CGRectMake(0, 0, 10, 10)];
            self.axisY.center = center;
            [self.axisX setFrame:self.axisY.frame];
        }];
        
    }else{
        [UIView animateWithDuration:.5 animations:^{
            
            [v setFrame:v.tapWithOriginRect];
            
            v.layer.cornerRadius = 8;
            v.titleLb.alpha = 0;
            v.listView.alpha= 0;
            
        } completion:^(BOOL finished) {
            
            [v.titleLb setFrame:CGRectMake(0, 5, v.frame.size.width, 30)];
            v.textInCenter = NO;
            [v.listView reloadData];
            [v setNeedsDisplay];
            
            [UIView animateWithDuration:.5 animations:^{
                v.titleLb.alpha = 1;
                v.listView.alpha = 1;
            }];
        }];
        
        for (LJQuadrantView *vOther in self.quadrantArray) {
            if (vOther != v) {
                
                [UIView animateWithDuration:.5 animations:^{
                    [vOther setFrame:vOther.tapWithOriginRect];
                }];
                
            }
        }
        
        [UIView animateWithDuration:.5 animations:^{
            CGSize size = self.view.frame.size;
            CGPoint center = CGPointMake(size.width / 2, size.height / 2);
            
            [self.axisY setFrame:CGRectMake(0, 0, 10, self.quadrantViewHeight * 2 + self.separatorWidh)];
            self.axisY.center = center;
            [self.axisX setFrame:CGRectMake(0, 0, self.quadrantViewWidth * 2 + self.separatorWidh, 10)];
            self.axisX.center = center;
        }];
    }
    
    v.flgatToBig = !v.flgatToBig;
    
}

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGSize size = self.view.frame.size;
    
    self.sizeToView_Top = 10;
    self.sizeToView_Left = 10;
    self.sizeToView_Right = 10;
    self.sizeToView_Buttom = 10;
    self.separatorWidh = 30;
    self.quadrantViewWidth = (size.width - self.sizeToView_Left - self.sizeToView_Right - self.separatorWidh) / 2;
    self.quadrantViewHeight = (size.height - self.sizeToView_Top - self.sizeToView_Buttom - self.separatorWidh) / 2;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self quadrantArray];
    
    [self singleTapInFirth];
    [self singleTapInSecond];
    [self singleTapInThird];
    [self singleTapInFourth];
    
    CGPoint center = CGPointMake(size.width / 2, size.height / 2);
    self.axisX.center = center;
    self.axisY.center = center;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

#pragma mark - Lazy

- (UIColor *)firstQuadrantColor {
	if(_firstQuadrantColor == nil) {
        _firstQuadrantColor = [UIColor firColor];
//		_firstQuadrantColor = [UIColor colorWithRed:RGB_FLOAT(247) green:RGB_FLOAT(112) blue:RGB_FLOAT(123) alpha:1.0];
	}
	return _firstQuadrantColor;
}

- (UIColor *)secondQuadrantColor {
	if(_secondQuadrantColor == nil) {
        _secondQuadrantColor = [UIColor secColor];
//		_secondQuadrantColor = [UIColor colorWithRed:RGB_FLOAT(250) green:RGB_FLOAT(160) blue:RGB_FLOAT(113) alpha:1.0];
	}
	return _secondQuadrantColor;
}

- (UIColor *)thirdQuadrantColor {
	if(_thirdQuadrantColor == nil) {
        _thirdQuadrantColor = [UIColor thiColor];
//		_thirdQuadrantColor = [UIColor colorWithRed:RGB_FLOAT(102) green:RGB_FLOAT(207) blue:RGB_FLOAT(229) alpha:1.0];
	}
	return _thirdQuadrantColor;
}

- (UIColor *)fourthQuadrantColor {
	if(_fourthQuadrantColor == nil) {
        _fourthQuadrantColor = [UIColor fouColor];
//		_fourthQuadrantColor = [UIColor colorWithRed:RGB_FLOAT(41) green:RGB_FLOAT(178) blue:RGB_FLOAT(162) alpha:1.0];
	}
	return _fourthQuadrantColor;
}

- (LJQuadrantView *)firstQuadrant {
	if(_firstQuadrant == nil) {
		_firstQuadrant = [[LJQuadrantView alloc] initWithFrame:CGRectMake(self.sizeToView_Left + self.separatorWidh + self.quadrantViewWidth, self.sizeToView_Top, self.quadrantViewWidth, self.quadrantViewHeight)];
        [self.view addSubview:_firstQuadrant];
        
        _firstQuadrant.titleLb.text = @"重要且紧急";
        _firstQuadrant.backgroundColor = self.firstQuadrantColor;
	}
	return _firstQuadrant;
}

- (LJQuadrantView *)secondQuadrant {
	if(_secondQuadrant == nil) {
		_secondQuadrant = [[LJQuadrantView alloc] initWithFrame:CGRectMake(self.sizeToView_Left, self.sizeToView_Top, self.quadrantViewWidth, self.quadrantViewHeight)];
        [self.view addSubview:_secondQuadrant];
        
        _secondQuadrant.titleLb.text = @"重要但不紧急";
        _secondQuadrant.backgroundColor = self.secondQuadrantColor;
	}
	return _secondQuadrant;
}

- (LJQuadrantView *)thirdQuadrant {
	if(_thirdQuadrant == nil) {
		_thirdQuadrant = [[LJQuadrantView alloc] initWithFrame:CGRectMake(self.sizeToView_Left + self.separatorWidh + self.quadrantViewWidth, self.sizeToView_Top + self.separatorWidh + self.quadrantViewHeight, self.quadrantViewWidth, self.quadrantViewHeight)];
        [self.view addSubview:_thirdQuadrant];
        
        _thirdQuadrant.titleLb.text = @"不重要但紧急";
        _thirdQuadrant.backgroundColor = self.thirdQuadrantColor;
	}
	return _thirdQuadrant;
}

- (LJQuadrantView *)fourthQuadrant {
	if(_fourthQuadrant == nil) {
		_fourthQuadrant = [[LJQuadrantView alloc] initWithFrame:CGRectMake(self.sizeToView_Left, self.sizeToView_Top + self.separatorWidh + self.quadrantViewHeight, self.quadrantViewWidth, self.quadrantViewHeight)];
        [self.view addSubview:_fourthQuadrant];
        
        _fourthQuadrant.titleLb.text = @"不重要且不紧急";
        _fourthQuadrant.backgroundColor = self.fourthQuadrantColor;
	}
	return _fourthQuadrant;
}

- (UITapGestureRecognizer *)singleTapInFirth {
	if(_singleTapInFirth == nil) {
		_singleTapInFirth = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapToDo:)];
        _singleTapInFirth.numberOfTapsRequired = 1;
        
        [self.firstQuadrant addGestureRecognizer:_singleTapInFirth];
	}
	return _singleTapInFirth;
}

- (UITapGestureRecognizer *)singleTapInSecond {
	if(_singleTapInSecond == nil) {
		_singleTapInSecond = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapToDo:)];
        _singleTapInSecond.numberOfTapsRequired = 1;
        
        [self.secondQuadrant addGestureRecognizer:_singleTapInSecond];
	}
	return _singleTapInSecond;
}

- (UITapGestureRecognizer *)singleTapInThird {
	if(_singleTapInThird == nil) {
		_singleTapInThird = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapToDo:)];
        
        [self.thirdQuadrant addGestureRecognizer:_singleTapInThird];
	}
	return _singleTapInThird;
}

- (UITapGestureRecognizer *)singleTapInFourth {
	if(_singleTapInFourth == nil) {
		_singleTapInFourth = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapToDo:)];
        
        [self.fourthQuadrant addGestureRecognizer:_singleTapInFourth];
	}
	return _singleTapInFourth;
}

- (UIView *)axisX {
	if(_axisX == nil) {
		_axisX = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.quadrantViewWidth * 2 + self.separatorWidh, 10)];
        [self.view addSubview:_axisX];
        _axisX.backgroundColor = [UIColor grayColor];
        _axisX.layer.cornerRadius = 5;
//        _axisX.center = self.view.center;
        
	}
	return _axisX;
}

- (UIView *)axisY {
	if(_axisY == nil) {
		_axisY = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.quadrantViewHeight * 2 + self.separatorWidh)];
        [self.view addSubview:_axisY];
        
        _axisY.backgroundColor = [UIColor grayColor];
        _axisY.layer.cornerRadius = 5;
//        _axisY.center = self.view.center;

	}
	return _axisY;
}

- (NSArray *)quadrantArray {
	if(_quadrantArray == nil) {
		_quadrantArray = @[self.firstQuadrant, self.secondQuadrant, self.thirdQuadrant, self.fourthQuadrant];
	}
	return _quadrantArray;
}

@end
