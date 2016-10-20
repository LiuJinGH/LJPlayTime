//
//  IndicatorView.m
//  LayerAnimationTest
//
//  Created by 刘瑾 on 16/9/28.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "IndicatorView.h"


@interface IndicatorView ()

@property (nonatomic) UIColor *originColor;

@end

@implementation IndicatorView

#pragma mark - Method

-(void )addAnimationWithColorToLayer{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"showColor"];
    animation2.duration = 1.0;
    animation2.fromValue = self.originColor;
    animation2.toValue = self.showColor;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.mylayer addAnimation:animation2 forKey:nil];
    
    [CATransaction commit];
}

-(void )addAnimationWithProgressToLayer{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation1.fromValue = [NSNumber numberWithFloat:0];
    animation1.toValue = [NSNumber numberWithFloat:self.progress];
    animation1.duration = 1.0;
    
    [self.mylayer addAnimation:animation1 forKey:nil];
    
    [CATransaction commit];
}

#pragma mark - Life

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(Class)layerClass{
    return [IndicatorLayer class];
}

#pragma mark - Lazy

-(void)setShowColor:(UIColor *)showColor{
    
    self.originColor = [UIColor colorWithCGColor:self.mylayer.showColor.CGColor];
    
    self.mylayer.showColor = showColor;
    [self addAnimationWithColorToLayer];
    [self addAnimationWithProgressToLayer];
    
}

-(void)setProgress:(CGFloat)progress{
    
    self.mylayer.progress = progress;
    [self addAnimationWithProgressToLayer];
    
}

-(CGFloat)progress{
    return self.mylayer.progress;
}

- (UIColor *)showColor {
    return self.mylayer.showColor;
}

- (IndicatorLayer *)mylayer {
	if(_mylayer == nil) {
		_mylayer = (IndicatorLayer *)self.layer;
	}
	return _mylayer;
}

- (UIColor *)originColor {
	if(_originColor == nil) {
        return [UIColor colorWithCGColor:self.mylayer.showColor.CGColor];
	}
	return _originColor;
}

@end
