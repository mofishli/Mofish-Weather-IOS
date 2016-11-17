//
//  WeatherCodePic.m
//  Mofish
//
//  Created by zhouli on 16/9/22.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "WeatherCodePic.h"

@implementation WeatherCodePic


+(NSString *)getcodepic:(NSString *)code{

   NSInteger codeint= [code intValue];
    NSString *picurl;
    
    if (codeint==100) {
        
        picurl=@"weather-clear@2x.png";
        
    }else if (codeint==101||codeint==102||codeint==104){
        
        picurl=@"weather-broken@2x.png";
        
    }else if (codeint==103){
        
        picurl=@"weather-few@2x.png";

    }else if (199<codeint&&codeint<214){
        
        picurl=@"weather-wind.png";

    }else if (299<codeint&&codeint<302){
        
        picurl=@"weather-rain@2x.png";

    }else if (301<codeint&&codeint<314){
        
        picurl=@"weather-tstorm@2x.png";

    }else if (304<codeint&&codeint<305){
        
        picurl=@"weather-shower@2x.png";

    }else if (399<codeint&&codeint<408){
        
        picurl=@"weather-snow@2x.png";

    }else if (499<codeint&&codeint<503){
        
        picurl=@"weather-mist@2x.png";

    }else if (503<codeint&&codeint<509){
        picurl=@"weather-sand.png";

    }else if (codeint==900){
        picurl=@"weather-hot.png";

    }else if (codeint==901){
        picurl=@"weather-cold.png";
        
    }else{
        picurl=@"weather-none.png";
    }
    
    return picurl;
}

@end
