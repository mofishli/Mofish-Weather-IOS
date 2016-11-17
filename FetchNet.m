//
//  FetchNet.m
//  Mofish
//
//  Created by zhouli on 16/9/22.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "FetchNet.h"
#import "Utils.h"
#import "JsonWeather.h"
@implementation FetchNet

+(void)requestCity{
     NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

     NSString *url=[@"https://api.heweather.com/x3/citylist?search=allchina&key=" stringByAppendingString:ZLKEY];
    
        [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
        }
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
                 NSMutableArray *citymutable;
    
                 for (NSDictionary *dic in responseObject) {
                      citymutable=[responseObject objectForKey:dic];
                     if (citymutable.count>0) {
                         break;
                     }
                  }
    
                // NSLog(@"城市列表  %@",citymutable);
    
                 [defaults setObject:citymutable forKey:CityKey];
             }
    
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
    
                 NSLog(@"%@",error);  //这里打印错误信息
                 
             }];

}


+(void)requestWeather:(NSInteger)index :(void (^)())block{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray *updateweatherarry=[[defaults arrayForKey:WeatherKey] mutableCopy];
    
    NSMutableDictionary *updateweatherdic=[updateweatherarry[index] mutableCopy];
    
    NSString *citycode=[updateweatherdic objectForKey:@"citycode"];

    NSString *url=[[[@"https://api.heweather.com/x3/weather?cityid=" stringByAppendingString:citycode]stringByAppendingString:@"&key="] stringByAppendingString:ZLKEY];
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             JsonWeather *jsw=[[JsonWeather alloc] initJsonweather:responseObject];
             
             NSMutableDictionary *headdic= [jsw getheadmodel];
             
             NSMutableArray *hourarry=[jsw gethourmodel];
             
             NSMutableArray *linearry=[jsw getforecastmodel];
             
             NSMutableDictionary *recommenddic=[jsw getrecommendmodel];
             
             NSMutableArray *infordic=[jsw getinformodel];
             
             NSMutableDictionary *weatherviewdata=[[updateweatherdic objectForKey:@"jsondata"] mutableCopy];
             
             [weatherviewdata setValue:headdic forKey:@"head"];
             
             [weatherviewdata setValue:infordic forKey:@"infor"];
             
             [weatherviewdata setValue:hourarry forKey:@"hour"];
             
             [weatherviewdata setValue:linearry forKey:@"line"];
             
             [weatherviewdata setValue:recommenddic forKey:@"recommend"];
             
             [updateweatherdic setValue:weatherviewdata forKey:@"jsondata"];
             
             [updateweatherarry replaceObjectAtIndex:index withObject:updateweatherdic];
             
             [defaults setObject:updateweatherarry forKey:WeatherKey];
             
             NSDictionary *nsdic=[NSDictionary dictionaryWithObject:@(index) forKey:@"index"];
             
             NSNotificationCenter *notification=[NSNotificationCenter defaultCenter];
             
             NSString *broadcast=@"weatherbroast";
             
             
             [notification postNotificationName:broadcast object:self userInfo:nsdic];
             
             block();
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}




@end
