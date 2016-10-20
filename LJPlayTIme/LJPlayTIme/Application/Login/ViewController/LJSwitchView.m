//
//  LJSwitchView.m
//  LJTimeManagerLoginVC
//
//  Created by 刘瑾 on 16/9/28.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJSwitchView.h"

@interface LJSwitchView ()

@property (nonatomic) UIView *showView;


@end

@implementation LJSwitchView

#pragma mark - method

-(void )tapView:(UITapGestureRecognizer *)tap{
    
    self.on = !self.on;
    
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
}

#pragma mark - setter

-(void)setOn:(BOOL)on{
    if (_on != on) {
        _on = on;
        [UIView animateWithDuration:0.5 animations:^{
            if (_on) {
                self.showView.backgroundColor = self.viewColor;
                self.showView.layer.borderColor = self.viewColor.CGColor;
                self.titleLabel.textColor = self.viewColor;
            }else{
                self.showView.backgroundColor = [UIColor whiteColor];
                self.showView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                self.titleLabel.textColor = [UIColor lightGrayColor];
            }
        }];
    }
}

#pragma mark - Lzay

- (UIView *)showView {
    if(_showView == nil) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [self addSubview:_showView];
        
        _showView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _showView.layer.borderWidth = 2.0;
        _showView.layer.cornerRadius = _showView.frame.size.height / 2;
        _showView.layer.masksToBounds = YES;
        _showView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:singleTap];
        
        self.on = NO;
    }
    return _showView;
}


- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 25)];
        [self addSubview:_titleLabel];
        
        _titleLabel.textColor = [UIColor lightGrayColor];
        
        [self showView];
    }
    return _titleLabel;
}


@end
