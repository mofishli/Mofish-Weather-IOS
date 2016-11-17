//
//  Utils.h
//  Mofish
//
//  Created by zhouli on 16/7/2.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherCodePic.h"
#import "FetchNet.h"
#define  ColorFromHex(s,a) [[UIColor alloc] initWithRed:((s & 0xFF0000) >> 16)/255.0 green:((s & 0xFF00) >> 8)/255.0 blue:((s & 0xFF))/255.0 alpha:a]

#define  ZLKEY   @"76856e888fac43acaebc5f3030b979d6"
#define  WeatherKey @"WeatherKey"
#define  CityKey @"CityKey"




@interface Utils :NSObject

+(NSString*)getcodepic:(NSString *)code;

+(void)requestWeather :(NSInteger)index:(void (^)())block;

+(void) requestCity;

+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

+(void)showToast:(UIView*)view:(NSString *)text;

@end


@interface UIColor(HEX)

//颜色

+(UIColor *)navycolor:(CGFloat)alpha;

+(UIColor *)blackcolor:(CGFloat)alpha;

+(UIColor *)graybackground;

+(UIColor *)graytext;

+(UIColor *)blacktext;

+(UIColor *)bordercolor;

+(UIColor *)systembluercolor;

+(UIColor *)toastcolor;

+(UIColor *)downloadcolor;

+(UIColor *)greendownload;

+(UIColor *)textcolor;

+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height;


@end

