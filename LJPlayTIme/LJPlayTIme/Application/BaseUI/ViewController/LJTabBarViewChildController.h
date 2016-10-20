//
//  LJTabBarViewController.h
//  LJTabbarVCDemo
//
//  Created by 刘瑾 on 2016/10/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCustomNVC.h"

@interface LJTabBarViewChildController : UIViewController

@property (nonatomic) UIColor *mainColor;
@property (nonatomic) NSInteger indexTag;
@property (nonatomic) BOOL firstVCFlage;
@property (nonatomic) LJCustomNVC *nvc;
@property (nonatomic) NSArray<UIColor *> *colorList;

-(void )inputNVCWithRootController:(UIViewController *) vc;

@end
