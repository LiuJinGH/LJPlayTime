//
//  LJTimeManagerLoginView.m
//  LJTimeManagerLoginVC
//
//  Created by 刘瑾 on 16/9/27.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJTimeManagerLoginView.h"

@interface LJTimeManagerLoginView ()<UITextFieldDelegate>
{
    CGFloat width;
    CGFloat height;
    int hDiv;
    int currtentT;
    CGRect originFrame;
}

@property (nonatomic) UITapGestureRecognizer *btnSingleTap;
@property (nonatomic) NSMutableArray<UITextField *> *textFieldArray;

@property (nonatomic) BOOL completionLogin;

@end

@implementation LJTimeManagerLoginView

#pragma mark - method

-(CGFloat )calculateOffsetYByKeyboard:(CGSize)keyboardSize{
    
    CGFloat mainHeight = [UIScreen mainScreen].bounds.size.height;
    
    //将本视图的bounds转化为window坐标系中的值
    CGRect selfbounds = [self convertRect:self.bounds toView:self.window];
    //求本视图的底部Y坐标值
    CGFloat selfY = selfbounds.origin.y + selfbounds.size.height;
    //屏幕底部到本视图底部的距离
    CGFloat offsetY1 = mainHeight - selfY;
    //本视图需要在键盘弹出之后的偏移值
    CGFloat offsetY2 = keyboardSize.height - offsetY1;
    
    return offsetY2;
    
}

-(void )keyboardOpen:(NSNotification *) notification{
    
    CGRect frame = self.frame;
    originFrame = frame;
    CGFloat offsetY = [self calculateOffsetYByKeyboard:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size];
    frame.origin.y -= offsetY;
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:option animations:^{
        [self setFrame:frame];
        [self setNeedsDisplay];
    } completion:nil];
    
}

-(void )keyboardClose:(NSNotification *) notification{
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:option animations:^{
        [self setFrame:originFrame];
        [self setNeedsDisplay];
    } completion:nil];
    
}

-(void )btnSingTapDo:(UITapGestureRecognizer *)tap{
    [self addTransitionAnimationToTextView];
    
}

-(void )goToMainView:(BOOL) flagt{
    
    if (flagt == NO) {
        return;
    }else{
        
        CATransition *animation = [CATransition animation];
        
        animation.duration = 1.0;
        animation.type = @"rippleEffect";
        animation.subtype = kCATransitionFromTop;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        self.loginTextView.alpha = 0;
        self.btnView.alpha = 0;
        self.rememberPassSwitch.alpha = 0;
        self.autoLoginSwitch.alpha = 0;
        
        [self.loginTextView.layer addAnimation:animation forKey:nil];
        [self.btnView.layer addAnimation:animation forKey:nil];
        [self.rememberPassSwitch.layer addAnimation:animation forKey:nil];
        [self.autoLoginSwitch.layer addAnimation:animation forKey:nil];
        
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGFloat left = 20;
            CGFloat top = 10;
            CGFloat mWidth = width - 20*2;
            CGFloat mHeight = height - 10*2;
            [self.titleLabel setFrame:CGRectMake(left, top, mWidth, mHeight)];
            
            self.titleLabel.text = @"登录成功！";
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:LJ_LOGIN_SUCCESS object:self userInfo:nil];
            self.completionLogin = YES;
        }];
        
    }
    
}

-(void )addTransitionAnimationToTextView{
    
    [UIView transitionWithView:self.loginTextView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        [self.textFieldArray[currtentT] removeFromSuperview];
        currtentT++;
        if (self.textFieldArray.count == currtentT) {
            
            [self goToMainView:self.certificationFlagt];
            
            currtentT = 0;
        }
        [self.loginTextView addSubview:self.textFieldArray[currtentT]];
        
    } completion:^(BOOL finished) {
        ;
    }];
    
}

#pragma mark - life

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        currtentT = 0;
        [self contentView];
        [self titleLabel];
        [self textFieldArray];
        [self.loginTextView addSubview:self.textFieldArray[currtentT]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOpen:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardClose:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

#pragma mark - UITextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    [self addTransitionAnimationToTextView];
    return YES;
}

#pragma mark - Lazy

- (UIView *)contentView {
	if(_contentView == nil) {
        self.completionLogin = NO;
        self.certificationFlagt = YES;
        self.backgroundColor = [UIColor clearColor];
        width = self.frame.size.width;
        height = self.frame.size.height;
        hDiv = 10;
        
		_contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self addSubview:_contentView];
        
        _contentView.layer.cornerRadius = 16;
        _contentView.layer.masksToBounds = YES;
        
        _contentView.layer.borderColor = self.viewColor.CGColor;
        _contentView.layer.borderWidth = 8;
        _contentView.backgroundColor = [UIColor whiteColor];
        
	}
	return _contentView;
}

- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        
        CGFloat left = 20;
        CGFloat top = (height / hDiv) ;
        CGFloat lWidth = width - 20 *2;
        CGFloat lHeight = (height / hDiv) * 3 - 5;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, lWidth, lHeight)];
        [self.contentView addSubview:_titleLabel];
        
        _titleLabel.textColor = self.viewColor;
        _titleLabel.text = @"登录";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = [UIFont systemFontOfSize:27];
    }
    return _titleLabel;
}

- (UIView *)loginTextView {
    if(_loginTextView == nil) {
        
        CGFloat left = 20;
        CGFloat top = 10 + self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y;
        CGFloat tHeight = (height / hDiv) * 3 - 10;
        CGFloat tWidth = width - 20 * 2 - tHeight;
        _loginTextView = [[UIView alloc] initWithFrame:CGRectMake(left, top, tWidth, tHeight)];
        [self.contentView addSubview:_loginTextView];
        
        _loginTextView.layer.cornerRadius = 8;
        _loginTextView.layer.masksToBounds = YES;
        
        _loginTextView.layer.borderColor = self.viewColor.CGColor;
        _loginTextView.layer.borderWidth = 3;
        
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(left + tWidth + 10, top, tHeight - 10, tHeight)];
        self.btnView = btnView;
        [self.contentView addSubview:btnView];
        
        btnView.layer.cornerRadius = 8;
        btnView.layer.masksToBounds = YES;
        
        btnView.layer.borderColor = self.viewColor.CGColor;
        btnView.layer.borderWidth = 3;
        [btnView addGestureRecognizer:self.btnSingleTap];
        
        [self rememberPassSwitch];
        [self autoLoginSwitch];
    }
    return _loginTextView;
}

- (UITextField *)otherField {
    if(_otherField == nil) {
        CGRect frame = self.loginTextView.bounds;
        frame.origin.x = 10;
        frame.size.width -= 10;
        _otherField = [[UITextField alloc] initWithFrame:frame];
        _otherField.placeholder = @"验证码";
        _otherField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _otherField.delegate = self;
    }
    return _otherField;
}

- (UITextField *)nameField {
    if(_nameField == nil) {
        CGRect frame = self.loginTextView.bounds;
        frame.origin.x = 10;
        frame.size.width -= 10;
        _nameField = [[UITextField alloc] initWithFrame:frame];
        _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameField.placeholder = @"用户名或邮箱号码";
        _nameField.delegate = self;
    }
    return _nameField;
}

- (UITextField *)passField {
    if(_passField == nil) {
        
        CGRect frame = self.loginTextView.bounds;
        frame.origin.x = 10;
        frame.size.width -= 10;
        _passField = [[UITextField alloc] initWithFrame:frame];
        _passField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passField.placeholder = @"密码";
        _passField.delegate = self;
    }
    return _passField;
}

- (LJSwitchView *)rememberPassSwitch {
    if(_rememberPassSwitch == nil) {
        CGFloat left = 25 ;
        CGFloat top = 20 + self.loginTextView.frame.origin.y + self.loginTextView.frame.size.height;
        _rememberPassSwitch = [[LJSwitchView alloc] initWithFrame:CGRectMake(left, top, 100, 25)];
        [self addSubview:_rememberPassSwitch];
        
        _rememberPassSwitch.viewColor = self.viewColor;
        _rememberPassSwitch.titleLabel.text = @"记住密码";
        
    }
    return _rememberPassSwitch;
}

- (LJSwitchView *)autoLoginSwitch {
    if(_autoLoginSwitch == nil) {
        
        CGRect frame = self.rememberPassSwitch.frame;
        CGFloat right = self.frame.origin.x + self.loginTextView.frame.size.width;
        CGFloat left = 25 + frame.size.width + 10;
        CGFloat top = frame.origin.y;
        CGFloat offset = right - frame.origin.x - frame.size.width *2 ;
        NSLog(@"%f", offset);
        _autoLoginSwitch = [[LJSwitchView alloc] initWithFrame:CGRectMake(left + offset, top, frame.size.width, frame.size.height)];
        [self addSubview:_autoLoginSwitch];
        
        _autoLoginSwitch.viewColor = self.viewColor;
        _autoLoginSwitch.titleLabel.text = @"自动登录";
        
    }
    return _autoLoginSwitch;
}

- (UIColor *)viewColor {
	if(_viewColor == nil) {
        _viewColor = kRGBColor(54, 172, 255, 1.0);
	}
	return _viewColor;
}

- (UITapGestureRecognizer *)btnSingleTap {
	if(_btnSingleTap == nil) {
        _btnSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnSingTapDo:)];
        _btnSingleTap.numberOfTapsRequired = 1;
        
        
	}
	return _btnSingleTap;
}

- (NSMutableArray<UITextField *> *)textFieldArray {
	if(_textFieldArray == nil) {
		_textFieldArray = [[NSMutableArray<UITextField *> alloc] init];
        [_textFieldArray addObject:self.nameField];
        [_textFieldArray addObject:self.passField];
//        [_textFieldArray addObject:self.otherField];
        
	}
	return _textFieldArray;
}

@end
