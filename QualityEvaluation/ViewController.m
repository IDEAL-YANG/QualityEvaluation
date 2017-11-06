//
//  ViewController.m
//  QualityEvaluation
//
//  Created by IDEAL YANG on 2017/11/6.
//  Copyright © 2017年 IDEAL YANG. All rights reserved.
//

#import "ViewController.h"
#import "LXQualityDispalyView.h"

@interface ViewController ()

@property (nonatomic, strong) LXQualityDispalyView *disView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor redColor];
    
    self.disView =  [[LXQualityDispalyView alloc] initWithFrame:CGRectMake(15, 125, 25, 216)];
    [self.view addSubview:self.disView];
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.disView.currentQuality = 4;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.disView.currentQuality = 1;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.disView.displayName = @"改个名";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.disView.displayColor = [UIColor blueColor];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.disView.currentQuality = 4;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.disView.displayName = @"印制质量";
        weakSelf.disView.currentQuality = 3;
        weakSelf.disView.displayColor = [UIColor greenColor];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
