//
//  IndicatorView.h
//  LayerAnimationTest
//
//  Created by 刘瑾 on 16/9/28.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndicatorLayer.h"

@interface IndicatorView : UIView



@property (nonatomic) CGFloat progress;

@property (nonatomic) IndicatorLayer *mylayer;

@property (nonatomic) UIColor *showColor;



@end
