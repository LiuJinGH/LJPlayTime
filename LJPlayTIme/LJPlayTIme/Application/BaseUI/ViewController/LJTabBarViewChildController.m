//
//  LJTabBarViewController.m
//  LJTabbarVCDemo
//
//  Created by 刘瑾 on 2016/10/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJTabBarViewChildController.h"


@interface LJTabBarViewChildController ()

@property (nonatomic) UIView *tabBarBtnView;

@property (nonatomic) UILabel *tabBarLab;



@property (nonatomic) BOOL Flage1;
@property (nonatomic) BOOL Flage2;

@end

@implementation LJTabBarViewChildController

#pragma mark - method

//将LJCustomNVC 加入视图控制器中
-(void )inputNVCWithRootController:(LJCustomNVC *) vc{
    self.nvc = [[LJCustomNVC alloc]initWithRootViewController:vc];
    self.nvc.mainColor = self.mainColor;
    
    [self addChildViewController:self.nvc];
    [self.view addSubview:self.nvc.view];
}

//设置LJCustomNVC
-(void )setupNVC:(UINavigationController *)nvc{
    
    CGSize size = self.view.bounds.size;
    [nvc.view setFrame:CGRectMake(0, 0, size.width, size.height - 50)];
    nvc.view.layer.cornerRadius = 15;
    nvc.view.layer.masksToBounds = YES;
    nvc.view.layer.borderWidth = 5;
    
}

#pragma mark - life

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.firstVCFlage = NO;
    self.Flage1 = YES;
    self.Flage2 = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    if (self.Flage1) {
        
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] initWithDictionary:@{NSForegroundColorAttributeName : self.mainColor, NSFontAttributeName : [UIFont systemFontOfSize:15]}];
        //正常状态的字体颜色
        [self.tabBarItem setTitleTextAttributes:attDic forState:UIControlStateNormal];
        
        [attDic setValue:[UIColor whiteColor] forKeyPath:NSForegroundColorAttributeName];
        //高亮状态的字体颜色
        [self.tabBarItem setTitleTextAttributes:attDic forState:UIControlStateFocused];
        
        //        NSLog(@"%@", self.tabBarController.tabBar.subviews);
        
        //        if (self.firstVCFlage) {
        //            self.tabBarBtnView = self.tabBarController.tabBar.subviews.firstObject;
        //        }else{
        self.tabBarBtnView = self.tabBarController.tabBar.subviews.lastObject;
        //        }
        
        self.tabBarBtnView.tag = self.indexTag;
        self.tabBarLab = self.tabBarBtnView.subviews[0];
        
        !_nvc ?: [self setupNVC:_nvc];
        
        self.Flage1 = NO;
        
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        self.tabBarBtnView.layer.backgroundColor = self.mainColor.CGColor;
        self.tabBarLab.textColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    NSLog(@"%@", self.tabBarController.tabBar.subviews);
    if (self.Flage2 && self.firstVCFlage) {
        for (int i =1; i < 4; i++) {
            UIView *view = self.tabBarController.tabBar.subviews[i];
            
            view.contentMode = UIViewContentModeCenter;
            view.layer.cornerRadius = 15;
            view.layer.masksToBounds = YES;
            view.layer.borderColor = self.colorList[i-1].CGColor;
            view.layer.borderWidth = 5;
            
            UILabel *labelView = view.subviews[0];
            labelView.textColor = self.colorList[i-1];
            labelView.frame = view.bounds;
            labelView.textAlignment = NSTextAlignmentCenter;
        }
        
        self.Flage2 = NO;
    }
    
    self.tabBarBtnView.contentMode = UIViewContentModeCenter;
    self.tabBarBtnView.layer.cornerRadius = 15;
    self.tabBarBtnView.layer.masksToBounds = YES;
    self.tabBarBtnView.layer.borderColor = self.mainColor.CGColor;
    self.tabBarBtnView.layer.borderWidth = 5;
    self.tabBarBtnView.backgroundColor = self.mainColor;
    [self.tabBarLab setFrame:self.tabBarBtnView.bounds];
    self.tabBarLab.textAlignment = NSTextAlignmentCenter;
    self.tabBarLab.textColor = [UIColor whiteColor];

    CATransition *animation = [CATransition animation];
    animation.type = @"suckEffect";
    animation.subtype = kCATransitionFromTop;
    animation.duration = 0.7;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.view.layer addAnimation:animation forKey:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.tabBarBtnView.backgroundColor = [UIColor whiteColor];
        self.tabBarLab.textColor = self.mainColor;
    }];
    
}



@end
