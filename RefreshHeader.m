//
//  MJDIYHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "RefreshHeader.h"
#import "RSLoadingIndicator.h"
@interface RefreshHeader()<RSLoadingIndicatorDelegate>
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation RefreshHeader

RSLoadingIndicator *indicator;

NSTimer *ticker;

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 63;
    
    // 添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2, 0,100, 63)];
    label.textColor = [UIColor whiteColor];
    
    label.font = [UIFont boldSystemFontOfSize:15];
    
    self.label = label;
    
    indicator = [[RSLoadingIndicator alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width-80 , 63)];
    
    indicator.backgroundColor=[UIColor clearColor];
    
    indicator.delegate = self;
    
    [self addSubview:indicator];
    
    [self addSubview:label];

}


- (void)startLoading {
    NSLog(@"哈哈哈");

    ticker = [NSTimer scheduledTimerWithTimeInterval:1.0f / 30.0f target:self selector:@selector(loading) userInfo:nil repeats:YES];
}

- (void)stopLoading {
    [ticker invalidate];
    

    [indicator restart];

    ticker = nil;
}

-(void )loading{
   

    [indicator didScroll:1];
}


#pragma mark 在这里设置子控件的位置和尺寸
//- (void)placeSubviews
//{
//    [super placeSubviews];
//
//    self.label.frame = self.bounds;
//    
//    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
//    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 20);
//    
//    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
//}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
   // NSLog(@"%f",self.scrollView.contentOffset.y);
   
    
    [indicator didScroll:-self.scrollView.contentOffset.y];
    
    [super scrollViewContentOffsetDidChange:change];

}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];

}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 self.label.text = @"下拉刷新";
                [self stopLoading];
                           });
            
        }
            break;
        case MJRefreshStatePulling:
          
            self.label.text = @"松开刷新";
            break;
        case MJRefreshStateRefreshing:
           
            self.label.text = @"加载中...";
            break;
    
        default:
            break;
    }
}

- (void)endRefreshing{
    
    [ticker invalidate];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [super endRefreshing];
        });
   
     self.label.text = @"加载完成";
    
    
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    
   //NSLog(@"哈哈哈baifenbi%f",pullingPercent);

//    if (pullingPercent<0.2) {
//        self.label.text = @"下拉刷新";
//      }
//    [super setPullingPercent:pullingPercent];
//    
//    // 1.0 0.5 0.0
//    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
