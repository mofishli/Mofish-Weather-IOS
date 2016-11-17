//
//  WeatherSaveModel.h
//  Mofish
//
//  Created by zhouli on 16/7/4.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherSaveModel : NSMutableDictionary

-(id)initWeatherModel:(NSString *)cityname:(NSString *)citycode:(id)jsondata:(BOOL)location
:(BOOL)care;

@end
