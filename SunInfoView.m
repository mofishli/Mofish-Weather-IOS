//
//  SunInfoView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "SunInfoView.h"
#import "SunriseView.h"
#import "SunsetView.h"
#import "CGRectStoreValue.h"
@interface SunInfoView ()

@property (nonatomic, strong) SunriseView       *sunriseView;
@property (nonatomic, strong) UILabel           *sunriseTimeLabel;
@property (nonatomic, strong) CGRectStoreValue  *sunriseViewStoreValue;
@property (nonatomic, strong) SunsetView        *sunsetView;
@property (nonatomic, strong) UILabel           *sunsetTimeLabel;
@property (nonatomic, strong) CGRectStoreValue  *sunsetViewStoreValue;

@end

@implementation SunInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.sunsireValue = [SunriseAndSunset new];
        self.sunsetValue  = [SunriseAndSunset new];
    }
    
    return self;
}

/**
 *  创建出view
 */
- (void)buildView {
    
  
    
    // 日出的view
    if (iPhone5_5s || iPhone4_4s) {
        
        self.sunriseView = [[SunriseView alloc] initWithFrame:CGRectMake(0, 0, 31, 62)];
        
    } else if (iPhone6_6s) {
        
        self.sunriseView = [[SunriseView alloc] initWithFrame:CGRectMake(0, 0, 35, 70)];
        
    } else {
        
        self.sunriseView = [[SunriseView alloc] initWithFrame:CGRectMake(0, 0, 40, 80)];
    }
    
    [self.sunriseView buildView];
    [self addSubview:self.sunriseView];
    self.sunriseViewStoreValue = [CGRectStoreValue new];
    self.sunriseViewStoreValue.midRect   = self.sunriseView.frame;
    self.sunriseView.y                  += 10;
    self.sunriseViewStoreValue.startRect = self.sunriseView.frame;
    self.sunriseView.y                  -= 20;
    self.sunriseViewStoreValue.endRect   = self.sunriseView.frame;
    self.sunriseView.frame = self.sunriseViewStoreValue.startRect;
    
    // 日出时间标签
    if (iPhone5_5s || iPhone4_4s) {
        
        self.sunriseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 31, 20)];
        
    } else if (iPhone6_6s) {
        
        self.sunriseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 35, 25)];
        
    } else {
        
        self.sunriseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 40, 25)];
    }
    
    self.sunriseTimeLabel.textColor=[UIColor whiteColor];
    self.sunriseTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.sunriseTimeLabel.font          = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    [self.sunriseView addSubview:self.sunriseTimeLabel];
    
    // 日落的view
    if (iPhone5_5s || iPhone4_4s) {
        
        self.sunsetView = [[SunsetView alloc] initWithFrame:CGRectMake(55, 0, 31, 62)];
        
    } else if (iPhone6_6s) {
        
        self.sunsetView = [[SunsetView alloc] initWithFrame:CGRectMake(65, 0, 35, 70)];
        
    } else {
        
        self.sunsetView = [[SunsetView alloc] initWithFrame:CGRectMake(65, 0, 40, 80)];
    }
    
    [self.sunsetView buildView];
    [self addSubview:self.sunsetView];
    self.sunsetViewStoreValue           = [CGRectStoreValue new];
    self.sunsetViewStoreValue.midRect   = self.sunsetView.frame;
    self.sunsetView.y                  -= 10;
    self.sunsetViewStoreValue.startRect = self.sunsetView.frame;
    self.sunsetView.y                  += 20;
    self.sunsetViewStoreValue.endRect   = self.sunsetView.frame;
    self.sunsetView.frame = self.sunsetViewStoreValue.startRect;
    
    // 日落时间标签
    if (iPhone5_5s || iPhone4_4s) {
        
        self.sunsetTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 31, 20)];
        
    } else if (iPhone6_6s) {
        
        self.sunsetTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 35, 25)];
        
    } else {
        
        self.sunsetTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 40, 25)];
    }
    
    self.sunsetTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.sunsetTimeLabel.textColor=[UIColor whiteColor];
    self.sunsetTimeLabel.font          = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    [self.sunsetView addSubview:self.sunsetTimeLabel];
}

/**
 *  显示
 */
- (void)show {
    
    
    // 动画持续时间
    CGFloat duration = 1.75f;
    
    // 日出动画
    [self.sunriseView showWithDuration:1.5];
    
    // 日落动画
    [self.sunsetView showWithDuration:1.5];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.sunriseView.frame = self.sunriseViewStoreValue.midRect;
        self.sunsetView.frame  = self.sunsetViewStoreValue.midRect;
        
       
        
        self.sunriseTimeLabel.text  = self.sunsireValue.timeString;
        
        self.sunsetTimeLabel.text   = self.sunsetValue.timeString;
    }];
}

/**
 *  隐藏
 */
- (void)hide {
    
    CGFloat duration = 0.75f;
    
    
    // 日出动画隐藏
    [self.sunriseView hideWithDuration:duration];
    
    // 日落动画隐藏
    [self.sunsetView hideWithDuration:duration];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.sunriseView.frame = self.sunriseViewStoreValue.endRect;
        self.sunsetView.frame  = self.sunsetViewStoreValue.endRect;
        
    
        
    } completion:^(BOOL finished) {
        
        self.sunriseView.frame = self.sunriseViewStoreValue.startRect;
        self.sunsetView.frame = self.sunsetViewStoreValue.startRect;
    }];
}

@end
