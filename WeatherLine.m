//
//  WeatherLine.m
//  Mofish
//
//  Created by zhouli on 16/6/16.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "WeatherLine.h"
#import "SCChart.h"
#import "Utils.h"
@interface WeatherLine()<SCChartDataSource>
{
    SCChart *chartView;
    
    NSArray *weatherlinearry;
}
@end

@implementation WeatherLine


-(instancetype)initline:(NSArray*)linearry{
  
    weatherlinearry=linearry;
    
    [self configUI];
    
    UITableViewCell *linecell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeatherLine"];
    
    linecell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    linecell.backgroundColor=[UIColor clearColor];
    
    UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 220)];
    
    UIColor *color=[UIColor blackcolor:0.3];
    
    backview.backgroundColor=color;
    
    [chartView showInView:backview:weatherlinearry];
    
    [linecell.contentView addSubview:backview];
    
    return linecell;
    
}

- (void)configUI {
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    chartView = [[SCChart alloc] initwithSCChartDataFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 210)
                                               withSource:self
                                                withStyle:SCChartLineStyle];
    
    chartView.backgroundColor=[UIColor clearColor];
}

//数值多重数组
- (NSArray *)SCChart_yValueArray:(SCChart *)chart {
   
    
    NSMutableArray *highary = [NSMutableArray array];
    NSMutableArray *lowary = [NSMutableArray array];
//    for (NSInteger i = 0; i < 7; i++) {
//        CGFloat num = arc4random_uniform(100);
//        NSString *str = [NSString stringWithFormat:@"%f",num];
//        [ary addObject:str];
//    }
//
//    for (NSInteger i = 0; i < 7; i++) {
//        CGFloat num = arc4random_uniform(100);
//        NSString *str = [NSString stringWithFormat:@"%f",num];
//        [ary2 addObject:str];
//    }
    
    for (NSDictionary *dic in weatherlinearry) {
        NSDictionary *tmp=[dic objectForKey:@"tmp"];

        NSString *hightmp=[tmp objectForKey:@"max"];
        
        NSString *lowtmp=[tmp objectForKey:@"min"];
        
//        hightmp=@"0";
//        
//        lowtmp=@"4";
        
        [highary addObject:hightmp];
        
        [lowary addObject:lowtmp];
    }
    
    return @[highary,lowary];
  }


- (NSArray *)getXTitles:(int)num {
    NSMutableArray *xTitles = [NSMutableArray array];
    for (NSDictionary *dic in weatherlinearry) {
    
        NSString *date=[dic objectForKey:@"date"];
        
        date=[date substringFromIndex:5];

       [xTitles addObject:date];
    }
    
    
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)SCChart_xLableArray:(SCChart *)chart {
    return [self getXTitles:7];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)SCChart_ColorArray:(SCChart *)chart {
    return @[SCRed,SCBlue];
}

#pragma mark 折线图专享功能
//标记数值区域
- (CGRange)SCChartMarkRangeInLineChart:(SCChart *)chart {
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)SCChart:(SCChart *)chart ShowHorizonLineAtIndex:(NSInteger)index {
    return YES;
}

//判断显示最大最小值
- (BOOL)SCChart:(SCChart *)chart ShowMaxMinAtIndex:(NSInteger)index {
    return YES;
}

@end
