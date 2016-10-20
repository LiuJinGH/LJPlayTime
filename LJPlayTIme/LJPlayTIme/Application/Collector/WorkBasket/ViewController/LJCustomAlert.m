//
//  LJCustomAlert.m
//  LJWorkBasketView
//
//  Created by 刘瑾 on 2016/10/9.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJCustomAlert.h"

@interface LJCustomAlert ()

@property (nonatomic) UIColor *topColor;

@property (nonatomic) UIColor *butColor;

@end

@implementation LJCustomAlert

+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle withTopColor:(UIColor *)topColor andButColor:(UIColor *)butColor{
    
    LJCustomAlert *alert = [super alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (alert) {
        alert.topColor = topColor;
        alert.butColor = butColor;
    }
    return alert;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.view.tintColor = self.butColor;
    
    self.view.subviews[0].subviews[0].hidden = YES;
    UIView *topMainView = self.view.subviews[0].subviews[1].subviews[0].subviews[0];
    UIView *butMainView = self.view.subviews[0].subviews[1].subviews[0].subviews[2];
    UILabel *titleLabel = topMainView.subviews[0].subviews[0];
    UILabel *decsLabel = topMainView.subviews[0].subviews[1];
    
    topMainView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    topMainView.layer.borderColor = self.topColor.CGColor;
    topMainView.layer.cornerRadius = 20;
    topMainView.layer.borderWidth = 5;
    
    titleLabel.textColor = self.topColor;
    decsLabel.textColor = self.topColor;
    
    butMainView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    butMainView.layer.borderColor = self.butColor.CGColor;
    butMainView.layer.cornerRadius = 10;
    butMainView.layer.borderWidth = 5;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    CATransition *animation = [CATransition animation];
    
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromTop;
    animation.duration = 2.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.view.layer addAnimation:animation forKey:nil];
    
}

@end
