
//
//  workTimeWelcomeVC.m
//  LJWorkWelcomeVC
//
//  Created by 刘瑾 on 16/9/26.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "WorkTimeWelcomeVC.h"
#import "LJCustomTrasitionAnimation.h"
#import "LJTimeManagerLoginVC.h"

@class LJCustomTrasitionAnimation;

@interface WorkTimeWelcomeVC ()<UIScrollViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic) UIScrollView *welcomeV;

@property (nonatomic) UIPageControl *pageV;

@property (nonatomic) LJCustomTrasitionAnimation *customTrasition;
@end

@implementation WorkTimeWelcomeVC

#pragma mark - method

-(void )turnTo:(UIButton *)sender{
    
    LJTimeManagerLoginVC *vc = [LJTimeManagerLoginVC new];
    
    vc.transitioningDelegate = self;

    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self welcomeV];
    [self pageV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIViewControllerTransitioning

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self.customTrasition;

}

#pragma mark - UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger numPage = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    
    if (self.pageV.currentPage == 2 && numPage == 3) {
        [self.pageV removeFromSuperview];
    }else if (self.pageV.currentPage == 3 && numPage == 2){
        [self.view addSubview:self.pageV];
    }
    
    self.pageV.currentPage = numPage;
}

#pragma mark - Lazy

- (UIScrollView *)welcomeV {
	if(_welcomeV == nil) {
		_welcomeV = [[UIScrollView alloc] init];
        [self.view addSubview:_welcomeV];
        _welcomeV.delegate = self;
        
        CGRect mainFrame = self.view.frame;
        
        _welcomeV.frame = mainFrame;
        _welcomeV.contentSize = CGSizeMake(mainFrame.size.width * 4, mainFrame.size.height);
        
        for (int i = 0; i < 4; i++) {
            
            CGRect frame = mainFrame;
            frame.origin.x = mainFrame.size.width * i;
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:frame];
            
            NSString *imageName = [NSString stringWithFormat:@"v%d", i + 1];
            
            iv.image = [UIImage imageNamed:imageName];
            [_welcomeV addSubview:iv];
            
            if (i == 3) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                CGSize size = self.view.frame.size;
                CGFloat centerX = self.view.center.x;
                [btn setFrame:CGRectMake(0, 0, size.width / 2, 40)];
                btn.center = CGPointMake(centerX, size.height / 4 *3);
                
                [btn setTitle:@"开启管理时间之旅" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
                
                btn.layer.borderWidth = 2;
                btn.layer.borderColor = [UIColor whiteColor].CGColor;
                btn.layer.cornerRadius = 10;
                btn.layer.masksToBounds = YES;
                
                [btn addTarget:self action:@selector(turnTo:) forControlEvents:UIControlEventTouchUpInside];
                
                iv.userInteractionEnabled = YES;
                [iv addSubview:btn];
                
            }
            
            
            
        }
        
        _welcomeV.pagingEnabled = YES;
        _welcomeV.bounces = NO;
        _welcomeV.showsVerticalScrollIndicator = NO;
        _welcomeV.showsHorizontalScrollIndicator = NO;
        
	}
	return _welcomeV;
}

- (UIPageControl *)pageV {
	if(_pageV == nil) {
		_pageV = [[UIPageControl alloc] init];
        [self.view addSubview:_pageV];
        
        CGSize size = self.view.frame.size;
        [_pageV setFrame:CGRectMake(0, size.height - 60, size.width, 40)];
        
        _pageV.numberOfPages = 4;
        
        _pageV.pageIndicatorTintColor = [UIColor orangeColor];
        
        _pageV.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        _pageV.currentPage = 0;
        
        _pageV.userInteractionEnabled = NO;
	}
	return _pageV;
}

- (LJCustomTrasitionAnimation *)customTrasition {
	if(_customTrasition == nil) {
		_customTrasition = [[LJCustomTrasitionAnimation alloc] init];
	}
	return _customTrasition;
}

@end
