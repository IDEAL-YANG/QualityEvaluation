//
//  LXQualityDispalyView.m
//  QualityEvaluation
//
//  Created by IDEAL YANG on 2017/11/6.
//  Copyright © 2017年 IDEAL YANG. All rights reserved.
//

#import "LXQualityDispalyView.h"

const CGFloat kLXQualityDispalyViewCellLength = 15.0;

@interface LXQualityDispalyView ()

@property (nonatomic, strong) UILabel *displayNameLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) NSInteger totalQuality;

@end

@implementation LXQualityDispalyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 25 * 0.5;
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
        self.layer.borderColor = [[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1/1.0] CGColor];
        
        [self addSubview:self.displayNameLabel];
        
        CGFloat maxHeight = CGRectGetHeight(frame) * 196/432.0;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(3, maxHeight, CGRectGetWidth(frame) - 6, 1.0/[UIScreen mainScreen].scale)];
        lineView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1/1.0];
        [self addSubview:lineView];
        self.lineView = lineView;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - maxHeight)];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        self.displayName = @"印制质量";
        self.displayColor = [UIColor colorWithRed:0/255.0 green:199/255.0 blue:106/255.0 alpha:1/1.0];
        self.totalQuality = 5;
        self.currentQuality = 3;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"==release:%@",self);
}

#pragma mark - Setters

- (void)setFrame:(CGRect)frame{
    super.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 25, 216);
}

- (void)setDisplayName:(NSString *)displayName{
    _displayName = displayName;
    [self settingUI];
    
    self.displayNameLabel.text = [self verticalString:displayName];
}

- (void)setDisplayColor:(UIColor *)displayColor{
    _displayColor = displayColor;
    [self drawCycle];
}

- (void)setCurrentQuality:(NSInteger)currentQuality{
    _currentQuality = currentQuality;
    [self drawCycle];
}

#pragma mark - Private

- (void)settingUI{
    if (self.displayName) {
        UIFont *font = [UIFont systemFontOfSize:12];
        UIColor *textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        NSString *aWord = @"一";
        CGSize aWordSize = [aWord boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor} context:nil].size;
        
        CGFloat maxWidth = CGRectGetWidth(self.frame);
        CGFloat maxHeight = CGRectGetHeight(self.frame) * 196/432.0;
        
        CGFloat height = MIN(aWordSize.height * self.displayName.length, maxHeight);
        
        self.displayNameLabel.frame = CGRectMake((maxWidth - aWordSize.width) * 0.5, (maxHeight - height) * 0.5, aWordSize.width, height);
    }
}

- (NSString *)verticalString:(NSString*)content{
    NSMutableString * str = [[NSMutableString alloc] initWithString:content];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

- (UILabel *)displayNameLabel{
    if (!_displayNameLabel) {
        UIFont *font = [UIFont systemFontOfSize:12];
        UIColor *textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        
        _displayNameLabel = [[UILabel alloc] init];
        _displayNameLabel.font = font;
        _displayNameLabel.textColor = textColor;
        _displayNameLabel.numberOfLines = 0;
        _displayNameLabel.adjustsFontSizeToFitWidth = true;
    }
    return _displayNameLabel;
}

- (void)drawCycle{
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat beginX = CGRectGetMidX(self.contentView.frame) - kLXQualityDispalyViewCellLength*0.5;
    CGFloat beginY = 10.5;
    
    for (NSInteger index = 0; index < self.totalQuality; index++) {
        CGRect frame = CGRectMake(beginX, beginY + index*(kLXQualityDispalyViewCellLength+5), kLXQualityDispalyViewCellLength, kLXQualityDispalyViewCellLength);
        [self drawCircleWithFrame:frame gray:index>self.currentQuality-1];
    }
}

- (void)drawCircleWithFrame:(CGRect)frame gray:(BOOL)gray{
    // 贝塞尔曲线(创建一个圆)
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kLXQualityDispalyViewCellLength/2.f, kLXQualityDispalyViewCellLength/2.f) radius:kLXQualityDispalyViewCellLength/2.f startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    // 创建一个shapeLayer
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame         = frame;                     // 与showView的frame一致
////    layer.strokeColor   = [UIColor greenColor].CGColor;   // 边缘线的颜色
//    layer.fillColor     = gray ? [UIColor grayColor].CGColor: self.displayColor.CGColor;   // 闭环填充的颜色
//    layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
//    layer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
//    layer.lineWidth     = 1.0f;                           // 线条宽度
////    layer.strokeStart   = 0.0f;
////    layer.strokeEnd     = 0.1f;
//
//    // 将layer添加进图层
//    [self.layer addSublayer:layer];
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = gray ? [UIColor grayColor]: self.displayColor;
    view.layer.cornerRadius = CGRectGetWidth(frame) * 0.5;
    view.layer.masksToBounds = true;
    [self.contentView addSubview:view];
}



@end
