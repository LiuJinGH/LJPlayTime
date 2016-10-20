//
//  LJTimeManagerLoginVC.m
//  LJTimeManagerLoginVC
//
//  Created by 刘瑾 on 16/9/27.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJTimeManagerLoginVC.h"
#import "LJDynamicShowHeaderView.h"
#import "LJTimeManagerLoginView.h"
#import "LJCustomTBVC.h"
#import "LJCustomTrasitionAnimation.h"

@interface LJTimeManagerLoginVC ()<UIViewControllerTransitioningDelegate>

@property (nonatomic) UIImageView *contentView;
@property (nonatomic) UIColor *viewColor;

@property (nonatomic) LJDynamicShowHeaderView *loginHead;

@property (nonatomic) LJTimeManagerLoginView *loginView;

@property (nonatomic) CGSize viewSize;

@property (nonatomic) LJCustomTrasitionAnimation *customTrasition;

@end

@implementation LJTimeManagerLoginVC

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.loginView endEditing:YES];
    
}

-(void )loginSuccess{
    
    LJCustomTBVC *vc = [LJCustomTBVC new];
//    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:NO completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.viewSize = self.view.frame.size;
    
    [self loginView];
    [self loginHead];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view bringSubviewToFront:self.loginHead];
}

#pragma mark - UIViewControllerTransitioning

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self.customTrasition;
    
}

#pragma mark - Lazy

- (UIImageView *)contentView {
    if(_contentView == nil) {
        _contentView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, self.viewSize.width - 10 *2, (self.viewSize.height - 30 * 2))];
        [self.view addSubview:_contentView];
        
        _contentView.layer.cornerRadius = 10;
        _contentView.layer.masksToBounds = YES;
        _contentView.backgroundColor = self.viewColor;
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

- (LJDynamicShowHeaderView *)loginHead {
	if(_loginHead == nil) {
        CGSize size = self.contentView.frame.size;
		_loginHead = [[LJDynamicShowHeaderView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height / 2)];
        [self.contentView addSubview:_loginHead];
        
        _loginHead.backgroundColor = [UIColor clearColor];
        
	}
	return _loginHead;
}

- (LJTimeManagerLoginView *)loginView {
    if(_loginView == nil) {
        int div = 8;
        CGSize size = self.loginHead.frame.size;
        CGFloat left = size.width / div;
        CGFloat top = size.height;
        CGFloat width = left * (div - 2);
        
        _loginView = [[LJTimeManagerLoginView alloc] initWithFrame:CGRectMake(left, top, width, 200)];
        
        [self.contentView addSubview:_loginView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:LJ_LOGIN_SUCCESS object:nil];
    }
    return _loginView;
}

- (UIColor *)viewColor {
	if(_viewColor == nil) {
        _viewColor = kRGBColor(247, 112, 123, 1.0);
	}
	return _viewColor;
}

- (LJCustomTrasitionAnimation *)customTrasition {
	if(_customTrasition == nil) {
		_customTrasition = [[LJCustomTrasitionAnimation alloc] init];
	}
	return _customTrasition;
}

@end
