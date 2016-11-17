//
//  HeaderModel.m
//  Mofish
//
//  Created by zhouli on 16/6/4.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "HeaderModel.h"
#import "Utils.h"
@implementation HeaderModel


-(instancetype)initheadmodel:(NSMutableDictionary *)headlmodel:(NSString *)cityname{
 
    //[headlmodel setValue:@"33" forKey:@"bigtemper"];
   
     NSString *sss= [headlmodel valueForKey:@"bigtemper"];
    
    
    self.bigtemper=[headlmodel valueForKey:@"bigtemper"];
    self.state=[headlmodel valueForKey:@"state"];
    self.statecode=[headlmodel valueForKey:@"statecode"];
    self.city=cityname;
    self.temperrange=[headlmodel valueForKey:@"temperrange"];
    NSString *aqiiconstring=[headlmodel valueForKey:@"aqi"];
    
    NSInteger aqivalue=[aqiiconstring intValue];
    
    NSLog(@"aqivalue %d",aqivalue);
    
    if (aqivalue<51) {
         self.aqi=@"air_icon_3.png";
    }else if (50<aqivalue&&aqivalue<101){
         self.aqi=@"air_icon_1.png";
    }else if (100<aqivalue&&aqivalue<151){
         self.aqi=@"air_icon_2.png";
    }else if (150<aqivalue&&aqivalue<=201){
         self.aqi=@"air_icon_4.png";
    }else if (200<aqivalue&&aqivalue<251){
         self.aqi=@"air_icon_6.png";
    }else if (250<aqivalue&&aqivalue<301){
         self.aqi=@"air_icon_5.png";
    }

    
    self.hum=[headlmodel valueForKey:@"hum"];
    self.quality=[[[headlmodel valueForKey:@"aqi"] stringByAppendingString:@" · "]stringByAppendingString:[headlmodel valueForKey:@"quality"]];
    return self;
}


@end
