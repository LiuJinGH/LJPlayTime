//
//  LJQuadrantView.h
//  LJWorkQuqdarant
//
//  Created by 刘瑾 on 16/9/26.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJQuadrantView : UIView

@property (nonatomic) UILabel *titleLb;

@property (nonatomic) UITableView *listView;

@property (nonatomic) BOOL flgatToBig;

@property (nonatomic) CGRect tapWithOriginRect;

@property (nonatomic) BOOL textInCenter;

@end
