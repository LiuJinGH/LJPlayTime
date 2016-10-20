//
//  LJDynamicShowHeaderView.m
//  LJTimeManagerShowHeaderView
//
//  Created by 刘瑾 on 16/9/27.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJDynamicShowHeaderView.h"

#define kHEADERDVIEW_WIDTH 70
#define kHEADERDVIEW_HEIGHT 80

@interface LJDynamicShowHeaderView ()

@property (nonatomic) UIDynamicAnimator *animation;

@property (nonatomic) UIGravityBehavior *gravityBehavior;

@property (nonatomic) UICollisionBehavior *collisionBehavior;

@property (nonatomic) UIAttachmentBehavior *attachmentBehavior;

@property (nonatomic) UIPanGestureRecognizer *panGesture;

@property (nonatomic) UIColor *viewColor;
@end

@implementation LJDynamicShowHeaderView

#pragma mark - method

-(void)doPanEvent:(UIPanGestureRecognizer *)panGesture{
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint transition = [panGesture locationInView:self];
        CGSize size = self.frame.size;
        
        CGFloat littleHeight = kHEADERDVIEW_HEIGHT - kHEADERDVIEW_WIDTH;
        
        if (transition.x < littleHeight) {
            transition.x = littleHeight;
        }else if(transition.x > size.width - littleHeight){
            transition.x = size.width - littleHeight;
        }
        if (transition.y < littleHeight) {
            
            //当移动的点在回收点附近时，收回
            CGFloat left = self.center.x - littleHeight * 3 ;
            CGFloat right = self.center.x + littleHeight * 3 ;
            
            if (transition.x >= left && transition.x <= right) {
                transition.x = self.center.x;
                transition.y = 0;
            }
            
            transition.y = littleHeight;
        }
        
        self.attachmentBehavior.anchorPoint = transition;
        
        [self setNeedsDisplay];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}

#pragma mark - life

- (void)drawRect:(CGRect)rect {
    
    //将headView中的点（35，5）转换为self中对应的点
    CGPoint position = [self convertPoint:CGPointMake(kHEADERDVIEW_WIDTH / 2, (kHEADERDVIEW_HEIGHT - kHEADERDVIEW_WIDTH) / 2) fromView:self.headView];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, position.x, position.y);
    CGContextAddLineToPoint(ctx, self.attachmentBehavior.anchorPoint.x, self.attachmentBehavior.anchorPoint.y );
    
    CGContextSetLineWidth(ctx, 5.0);
    CGFloat length[] = {5.0,5.0};
    CGContextSetLineDash(ctx, 0.0, length, 2);
    
    [self.viewColor set];
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
}


#pragma mark - Lazy

- (UIView *)headView {
	if(_headView == nil) {
        
        CGFloat littleHeight = kHEADERDVIEW_HEIGHT - kHEADERDVIEW_WIDTH;
        
        
		_headView = [[UIView alloc] initWithFrame:CGRectMake(self.center.x - 80, littleHeight + 5, kHEADERDVIEW_WIDTH, kHEADERDVIEW_HEIGHT)];
        [self addSubview:_headView];
        
        UIView *topPoin = [[UIView alloc] initWithFrame:CGRectMake(0, 0, littleHeight *2, littleHeight *2)];
        topPoin.center = CGPointMake(self.center.x, 0);
        [self addSubview:topPoin];
        topPoin.layer.cornerRadius = littleHeight;
        topPoin.layer.masksToBounds = YES;
        topPoin.backgroundColor = self.viewColor;
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, littleHeight *2, littleHeight *2)];
        [_headView addSubview:topView];
        topView.center = CGPointMake(kHEADERDVIEW_WIDTH / 2, littleHeight);
        topView.layer.cornerRadius = littleHeight;
        topView.layer.masksToBounds = YES;
        
        UIImageView *showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kHEADERDVIEW_WIDTH, kHEADERDVIEW_WIDTH)];
        [_headView addSubview:showView];
        showView.center = CGPointMake(kHEADERDVIEW_WIDTH / 2, kHEADERDVIEW_WIDTH / 2 + littleHeight);
        showView.layer.cornerRadius = littleHeight;
        showView.layer.borderColor = [UIColor whiteColor].CGColor;
        showView.layer.borderWidth = 5;
        showView.layer.masksToBounds = YES;
        showView.image = [UIImage imageNamed:@"headerImage"];
        showView.backgroundColor = self.viewColor;
        topView.backgroundColor = self.viewColor;
        
        [self addGestureRecognizer:self.panGesture];
        [self gravityBehavior];
        [self collisionBehavior];
        [self attachmentBehavior];
        
//        self.layer.borderColor = self.viewColor.CGColor;
//        self.layer.borderWidth = 2;
        self.layer.cornerRadius = littleHeight;
        self.layer.masksToBounds = YES;
//        self.backgroundColor = [UIColor whiteColor];
        
        [_headView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
	}
	return _headView;
}

- (UIDynamicAnimator *)animation {
	if(_animation == nil) {
		_animation = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        
	}
	return _animation;
}

- (UIGravityBehavior *)gravityBehavior {
	if(_gravityBehavior == nil) {
		_gravityBehavior = [[UIGravityBehavior alloc] init];
        [self.attachmentBehavior addChildBehavior:_gravityBehavior];
        
        [_gravityBehavior addItem:self.headView];
	}
	return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior {
	if(_collisionBehavior == nil) {
		_collisionBehavior = [[UICollisionBehavior alloc] init];
        [self.attachmentBehavior addChildBehavior:_collisionBehavior];
        
        [_collisionBehavior addItem:self.headView];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        
        
	}
	return _collisionBehavior;
}

- (UIPanGestureRecognizer *)panGesture {
	if(_panGesture == nil) {
		_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPanEvent:)];
	}
	return _panGesture;
}

- (UIAttachmentBehavior *)attachmentBehavior {
	if(_attachmentBehavior == nil) {
        
        
        
        //设置偏移
        UIOffset offset = UIOffsetMake(0, -(kHEADERDVIEW_HEIGHT / 2));
        //创建初始化
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.headView offsetFromCenter:offset attachedToAnchor:CGPointMake(self.center.x, 0)];
        
        [self.animation addBehavior:_attachmentBehavior];
        //设置阻尼
        _attachmentBehavior.damping = 1;
        //设置频繁度
        _attachmentBehavior.frequency = 1;
        
	}
	return _attachmentBehavior;
}

- (UIColor *)viewColor {
	if(_viewColor == nil) {
		_viewColor = [UIColor cyanColor];
	}
	return _viewColor;
}

@end
