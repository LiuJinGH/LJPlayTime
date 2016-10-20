//
//  IndicatorLayer.m
//  LayerAnimationTest
//
//  Created by 刘瑾 on 16/9/28.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "IndicatorLayer.h"

@interface IndicatorLayer ()

@end

@implementation IndicatorLayer

+(BOOL)needsDisplayForKey:(NSString *)key{
    
    if ([key isEqualToString:@"progress"] || [key isEqualToString:@"showView"]) {
        return YES;
    }else{
        return [super needsDisplayForKey:key];
    }
    
}

-(void)drawInContext:(CGContextRef)ctx{
    
    CGContextSetStrokeColorWithColor(ctx, self.showColor.CGColor);
    CGContextSetLineWidth(ctx,3.f);
    
    CGContextAddArc(ctx,CGRectGetWidth(self.bounds)/2.,CGRectGetHeight(self.bounds)/2.,CGRectGetWidth(self.bounds)/2. - 6, M_PI_2 * 3, M_PI_2*3+M_PI*2*self.progress,0);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextStrokePath(ctx);
    
}

-(UIColor *)showColor{
    if (!_showColor) {
        _showColor = [UIColor fouColor];
    }
    return _showColor;
}

@end
