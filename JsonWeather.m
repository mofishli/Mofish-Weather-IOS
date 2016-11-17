//
//  JsonWeather.m
//  Mofish
//
//  Created by zhouli on 16/7/3.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "JsonWeather.h"

@interface JsonWeather()

@property(nonatomic,assign) NSString *temcurrent;            //当前温度
@property(nonatomic,assign) NSString *statecurrent;          //当前天气状态
@property(nonatomic,assign) NSString *wetcurrent;            //
@property(nonatomic,assign) NSString *pressurecurrent;
@property(nonatomic,assign) NSString *windlevel;



@end

@implementation JsonWeather

-(id)initJsonweather:(id)responseobj{
    NSMutableArray *mutable=[NSMutableArray array];
   
    self=[super init];
    
    for (NSDictionary *dic in responseobj) {
         mutable=[responseobj objectForKey:dic];
        if(mutable.count>0){
            
            _weatherdic=mutable[0];
            
            break;
        }
    }
    
   
    return self;
}

-(id)getheadmodel{
    
    NSDictionary *now= [_weatherdic objectForKey:@"now"];
    
    NSMutableArray *daily_forecast= [_weatherdic objectForKey:@"daily_forecast"];

    NSString *bigtemper=[now objectForKey:@"tmp"];
    
    NSString *state=[[now objectForKey:@"cond"] objectForKey:@"txt"];
    
    NSString *statecode=[[now objectForKey:@"cond"] objectForKey:@"code"];
    
    NSString *hightmp=[[daily_forecast[0] objectForKey:@"tmp"] objectForKey:@"max"];
    
    NSString *lowtmp=[[daily_forecast[0] objectForKey:@"tmp"] objectForKey:@"min"];
    
    NSString *hum=[[now objectForKey:@"hum"] stringByAppendingString:@"%"];
    
    NSLog(@"_headermodel.hum %@",hum);
    
    NSDictionary *aqidic=[[_weatherdic objectForKey:@"aqi"] objectForKey:@"city"];
    
    NSString *aqi=[aqidic objectForKey:@"aqi"];
    
    NSString *quality=[aqidic objectForKey:@"qlty"];
    
    NSString *temperrange=[[[hightmp stringByAppendingString:@"°/"] stringByAppendingString:lowtmp] stringByAppendingString:@"°"];
    
    NSMutableDictionary *headmodel=[NSMutableDictionary dictionary ];
    
     [headmodel setValue:bigtemper forKey:@"bigtemper"];
    
     [headmodel setValue:state forKey:@"state"];
    
     [headmodel setValue:statecode forKey:@"statecode"];
    
     [headmodel setValue:temperrange forKey:@"temperrange"];
    
     [headmodel setValue:hightmp forKey:@"hightmp"];
    
     [headmodel setValue:lowtmp forKey:@"lowtmp"];
    
     [headmodel setValue:hum forKey:@"hum"];
    
     [headmodel setValue:aqi forKey:@"aqi"];

     [headmodel setValue:quality forKey:@"quality"];
    
     return headmodel;
}

-(id)getforecastmodel{
  
    NSMutableArray *daily_forecast= [_weatherdic objectForKey:@"daily_forecast"];
    
    return daily_forecast;
}

-(id)getinformodel{
   NSDictionary *now= [_weatherdic objectForKey:@"now"];
   
    NSDictionary *wind=[now objectForKey:@"wind"];
    
    NSMutableArray *daily_forecast= [_weatherdic objectForKey:@"daily_forecast"];

    NSDictionary *sun=[[daily_forecast objectAtIndex:0] objectForKey:@"astro"];
    
    NSMutableDictionary *infordic=[NSMutableDictionary dictionary];
    
    [infordic setValue:wind forKey:@"wind"];
    
    [infordic setValue:sun forKey:@"sun"];
    
    return infordic;

}

-(id)getrecommendmodel{
    
    NSMutableDictionary *suggestion= [_weatherdic objectForKey:@"suggestion"];
    
    return suggestion;
}

-(id)gethourmodel{

    NSMutableArray *hourly_forecast= [_weatherdic objectForKey:@"hourly_forecast"];
    
    return hourly_forecast;
}


@end
