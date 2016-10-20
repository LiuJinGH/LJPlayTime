//
//  LJCustomAlert.h
//  LJWorkBasketView
//
//  Created by 刘瑾 on 2016/10/9.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJCustomAlert : UIAlertController

+(instancetype )alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle withTopColor:(UIColor *)topColor andButColor:(UIColor *)butColor;

@end
