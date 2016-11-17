//
//  WeatherSaveModel.m
//  Mofish
//
//  Created by zhouli on 16/7/4.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "WeatherSaveModel.h"

@implementation WeatherSaveModel


-(id)initWeatherModel:(NSString *)cityname :(NSString *)citycode :(NSMutableArray *)jsondata :(BOOL)location :(BOOL)care{


    self=[NSMutableDictionary dictionary];
    
    [self setValue:cityname forKey:@"cityname"];
    
    [self setValue:citycode forKey:@"citycode"];
    
    [self setValue:jsondata forKey:@"jsondata"];
    
    [self setValue:@(location) forKey:@"location"];
    
    [self setValue:@(care) forKey:@"care"];

    return self;
}


@end
