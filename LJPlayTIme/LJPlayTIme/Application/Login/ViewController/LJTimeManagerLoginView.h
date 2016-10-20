//
//  LJTimeManagerLoginView.h
//  LJTimeManagerLoginVC
//
//  Created by 刘瑾 on 16/9/27.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSwitchView.h"

#define LJ_LOGIN_SUCCESS @"LoginSuccessNotification"

@interface LJTimeManagerLoginView : UIView

@property (nonatomic) UIView *contentView;
@property (nonatomic) UIColor *viewColor;

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIView *loginTextView;
@property (nonatomic) UIView *btnView;

@property (nonatomic) UITextField *nameField;
@property (nonatomic) UITextField *passField;
@property (nonatomic) UITextField *otherField;

@property (nonatomic) LJSwitchView *rememberPassSwitch;
@property (nonatomic) LJSwitchView *autoLoginSwitch;

@property (nonatomic) BOOL certificationFlagt;

@end
