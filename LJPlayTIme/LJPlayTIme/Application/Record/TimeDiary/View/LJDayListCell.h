//
//  LJDayListCell.h
//  LJDayLsitCell
//
//  Created by 刘瑾 on 16/9/25.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJDayListCell : UITableViewCell

@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UITextView *expectTextV;
@property (nonatomic) UITextView *actualTextV;
@property (nonatomic) UIView *standV;

-(void )updataCustomColorWithNewColor:(UIColor *) color;


@end
