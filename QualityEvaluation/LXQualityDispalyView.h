//
//  LXQualityDispalyView.h
//  QualityEvaluation
//
//  Created by IDEAL YANG on 2017/11/6.
//  Copyright © 2017年 IDEAL YANG. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat kLXQualityDispalyViewWidth;
extern const CGFloat kLXQualityDispalyViewHeight;

@interface LXQualityDispalyView : UIView

@property (nonatomic, strong) UIColor *displayColor;
@property (nonatomic,   copy) NSString *displayName;

@property (nonatomic, assign) NSInteger currentQuality;

@end
