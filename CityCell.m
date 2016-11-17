//
//  CityCell.m
//  Mofish
//
//  Created by zhouli on 16/6/30.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "CityCell.h"
#import "Utils.h"
#import "JsonWeather.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>

@implementation CityCell



-(UIView *)initcitycell:(WeatherSaveModel *)weathermodel :(NSInteger)index{
    
    CGSize  size=[UIScreen mainScreen].bounds.size;
    
    CGFloat width=(size.width-10*4)/3;
  
    [super initWithFrame:CGRectMake(0, 0,width, width*1.3)];
    
    self.backgroundColor=[UIColor whiteColor];
    
    CGSize citynamesize=[[weathermodel objectForKey:@"cityname" ] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    UILabel *citynamelabel=[[UILabel alloc] initWithFrame:CGRectMake((width-citynamesize.width)/2, 7, citynamesize.width, citynamesize.height)];
    
    citynamelabel.text=[weathermodel objectForKey:@"cityname"];
    
    NSDictionary *jsondata=[weathermodel objectForKey:@"jsondata"];
    
    citynamelabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(5,14+citynamesize.height, width-10, 0.5)];
    
    line1.backgroundColor=[UIColor graybackground];
    
    NSString *highlabeltext=[[[jsondata objectForKey:@"head"] objectForKey:@"hightmp"] stringByAppendingString:@"℃"];
    
    NSString *lowlabeltext=[[[jsondata objectForKey:@"head"] objectForKey:@"lowtmp"] stringByAppendingString:@"℃"];
    
    NSString *tipslabeltext=[[jsondata objectForKey:@"head"] objectForKey:@"state"];
    
    UIImageView *weathericon=[[UIImageView alloc] initWithFrame:CGRectMake(10, 20+citynamesize.height, 55, 49)];
    
    weathericon.image=[UIImage imageNamed:@"settings_icon_city_w_03"];
    
    CGSize highsize=[highlabeltext boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    UILabel *highlabel=[[UILabel alloc] initWithFrame:CGRectMake(75,  25+citynamesize.height,highsize.width,highsize.height)];
    
    highlabel.text=highlabeltext;
    
    highlabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    
    CGSize lowsize=[lowlabeltext boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    UILabel *lowlabel=[[UILabel alloc] initWithFrame:CGRectMake(75, 45+citynamesize.height, lowsize.width, lowsize.height)];
    
    lowlabel.text=lowlabeltext;
    
    lowlabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    
    CGSize tipsize=[tipslabeltext boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    UILabel *tipslabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 75+citynamesize.height, tipsize.width, tipsize.height)];
    
    tipslabel.text=tipslabeltext;
    
    tipslabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:15];

    
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(5,85+citynamesize.height+tipsize.height, width-10, 0.5)];
    
    line2.backgroundColor=[UIColor graybackground];
    
    UIImageView *locationicon=[[UIImageView alloc] initWithFrame:CGRectMake(15, 95+citynamesize.height+tipsize.height,20, 20)];
    
    locationicon.image=[UIImage imageNamed:@"city-weather-location.png"];

    UIImageView *careicon=[[UIImageView alloc] initWithFrame:CGRectMake(width-35, 95+citynamesize.height+tipsize.height,20, 20)];
    
    careicon.image=[UIImage imageNamed:@"mycenter_collect_sel.png"];
    
    UIActivityIndicatorView *Indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    Indicator.center = CGPointMake(width/2,width*1.3/2);
    
    Indicator.color = [UIColor graytext];
    
    [Indicator startAnimating];
    
    [self addSubview:citynamelabel];
    
    [self addSubview:line1];
    
    
    if ([jsondata objectForKey:@"head"]) {
        
        [self addSubview:weathericon];
        
        [self addSubview:highlabel];
        
        [self addSubview:lowlabel];
        
        [self addSubview:tipslabel];

        
    }else{
        
        [self loadcitydata:weathermodel :index :Indicator];
        
        [self addSubview:Indicator];

    }
    
    [self addSubview:line2];
    
    [self addSubview:locationicon];
    
    [self addSubview:careicon];
  
    return self;
}

-(void)loadcitydata:(WeatherSaveModel *)weathermodel:(NSInteger)index:(UIActivityIndicatorView *)Indicator{
    
    
    NSString *citycode=[weathermodel objectForKey:@"citycode"];
    
    NSString *url=[[@"https://api.heweather.com/x3/weather?cityid=" stringByAppendingString:citycode]stringByAppendingString:@"&key=76856e888fac43acaebc5f3030b979d6"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             JsonWeather *jsw=[[JsonWeather alloc] initJsonweather:responseObject];
             
             NSMutableDictionary *headdic= [jsw getheadmodel];
             
             NSMutableDictionary *weatherviewdata=[[weathermodel objectForKey:@"jsondata"] mutableCopy];

             [weatherviewdata setValue:headdic forKey:@"head"];
             
             NSMutableDictionary *dic=weathermodel;
             
             [dic setValue:weatherviewdata forKey:@"jsondata"];
             
             NSLog(@"从cell访问网络回调   %@      ,%d",dic,index);
             
             [self.delegate reloacitydata:dic :index];
                          
             [Indicator stopAnimating];
           
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];


    

}


@end
