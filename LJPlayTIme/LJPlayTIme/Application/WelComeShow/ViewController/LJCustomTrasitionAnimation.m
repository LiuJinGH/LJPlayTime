//
//  LJCustomTrasitionAnimation.m
//  LJWorkWelcomeVC
//
//  Created by 刘瑾 on 16/9/26.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJCustomTrasitionAnimation.h"

@implementation LJCustomTrasitionAnimation

//转场动画的时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //获取源视图 和 目的视图
    UIView *fromV = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toV = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //将源视图和目的视图截取下来。 非必要步骤
    UIView *snapFromV = [fromV snapshotViewAfterScreenUpdates:YES];
    UIView *snapToV = [toV snapshotViewAfterScreenUpdates:YES];
//    UIView *snapFromV = fromV;
//    UIView *snapToV = toV;
    //加入显示层
    [[transitionContext containerView] addSubview:snapToV];
    [[transitionContext containerView] addSubview:snapFromV];
    
    //动画部分
    [UIView transitionFromView:snapFromV toView:snapToV duration:[self transitionDuration:transitionContext] options:UIViewAnimationOptionTransitionCurlDown completion:^(BOOL finished) {
        [snapFromV removeFromSuperview];
        [snapToV removeFromSuperview];
        [[transitionContext containerView] addSubview:toV];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
