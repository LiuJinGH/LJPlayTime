//
//  LJDayListCell.m
//  LJDayLsitCell
//
//  Created by 刘瑾 on 16/9/25.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJDayListCell.h"

@interface LJDayListCell () <UITextViewDelegate>

@property (nonatomic) UIView *LJDayLIstContentView;
@property (nonatomic) UIView *backgroundContentView;

@property (nonatomic) UIColor *customColor;

@end

@implementation LJDayListCell

#pragma mark - method

-(void)updataCustomColorWithNewColor:(UIColor *)color{
    self.customColor = color;
    [self setNeedsDisplay];
    
}

-(void )setupLayerCornerRedius:(CGFloat) redius withLayer:(CALayer *) layer{
    layer.cornerRadius = redius;
    layer.masksToBounds = YES;
}

#pragma mark - life

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextView 

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }else if (range.location > 20){
        return NO;
    }
    return YES;
}

#pragma mark - Lazy

- (UIView *)backgroundContentView {
    if(_backgroundContentView == nil) {
        _backgroundContentView = [[UIView alloc] init];
        [self.contentView addSubview:_backgroundContentView];
        
        [_backgroundContentView setFrame:CGRectMake(10, 5, self.contentView.frame.size.width - 10 * 2 , self.contentView.frame.size.height - 15)];
        _backgroundContentView.backgroundColor = self.customColor;
        [self setupLayerCornerRedius:8 withLayer:_backgroundContentView.layer];
        
        
        //一些cell的设置
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    }
    return _backgroundContentView;
}

- (UIView *)LJDayLIstContentView {
    if(_LJDayLIstContentView == nil) {
        _LJDayLIstContentView = [[UIView alloc] init];
        [self.backgroundContentView addSubview:_LJDayLIstContentView];
        
        [_LJDayLIstContentView setFrame:CGRectMake(20, 30, self.backgroundContentView.frame.size.width - 40, self.backgroundContentView.frame.size.height - 50)];
        _LJDayLIstContentView.backgroundColor = [UIColor whiteColor];
        [self setupLayerCornerRedius:8 withLayer:_LJDayLIstContentView.layer];
        
    }
    return _LJDayLIstContentView;
}

- (UILabel *)timeLabel {
    if(_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [self.LJDayLIstContentView addSubview:_timeLabel];
        
        _timeLabel.text = @"8:00";
        _timeLabel.textColor = self.customColor;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        
        //设置边框
        _timeLabel.layer.borderColor = _timeLabel.textColor.CGColor;
        _timeLabel.layer.borderWidth = 2;
        [self setupLayerCornerRedius:8 withLayer:_timeLabel.layer];
        
        //设置位置大小
        CGSize size = self.LJDayLIstContentView.frame.size;
        [_timeLabel setFrame:CGRectMake(10, 20, size.width / 5, 30)];
        
        
        
    }
    return _timeLabel;
}

- (UITextView *)expectTextV {
    if(_expectTextV == nil) {
        _expectTextV = [[UITextView alloc] init];
        [self.LJDayLIstContentView addSubview:_expectTextV];
        
        _expectTextV.backgroundColor = self.customColor;
        [self setupLayerCornerRedius:8 withLayer:_expectTextV.layer];
        _expectTextV.textColor = [UIColor whiteColor];
        _expectTextV.font = [UIFont systemFontOfSize:16];
        _expectTextV.text = @"期待结果：";
        _expectTextV.delegate = self;
        
        CGSize size = self.LJDayLIstContentView.frame.size;
        CGFloat x = 10 + size.width / 5 + 10;
        [_expectTextV setFrame:CGRectMake(x, 20, size.width - x - 10, (size.height - 20 - 10 - 10) / 2 )];
        
        
        
    }
    return _expectTextV;
}

- (UITextView *)actualTextV {
    if(_actualTextV == nil) {
        _actualTextV = [[UITextView alloc] init];
        [self.LJDayLIstContentView addSubview:_actualTextV];
        
        _actualTextV.backgroundColor = self.customColor;
        [self setupLayerCornerRedius:8 withLayer:_actualTextV.layer];
        _actualTextV.textColor = [UIColor whiteColor];
        _actualTextV.font = [UIFont systemFontOfSize:16];
        _actualTextV.delegate = self;
        _actualTextV.text = @"实际结果：";
        
        CGRect frame = self.expectTextV.frame;
        [_actualTextV setFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + 10, frame.size.width, frame.size.height)];
        
        
    }
    return _actualTextV;
}

- (UIView *)standV {
    if(_standV == nil) {
        _standV = [[UIView alloc] init];
        [self.LJDayLIstContentView addSubview:_standV];
        
        _standV.layer.borderColor = self.customColor.CGColor;
        _standV.layer.borderWidth = 2.0;
        _standV.layer.masksToBounds = YES;
        
        CGRect frame = self.timeLabel.frame;
        CGFloat height = self.LJDayLIstContentView.frame.size.height;
        [_standV setFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + 10, frame.size.width, height - frame.origin.y - frame.size.height - 10 - 10)];
    }
    return _standV;
}


- (UIColor *)customColor {
	if(_customColor == nil) {
        _customColor = [UIColor firColor];
	}
	return _customColor;
}

@end
