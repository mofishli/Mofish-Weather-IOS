//
//  DayModel.m
//  Mofish
//
//  Created by zhouli on 16/6/3.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "DayModel.h"
#import "Utils.h"
@implementation DayModel



-(instancetype)initdaymodel:(NSDictionary *)hourdic:(NSDictionary *)nowdic{
  
    NSString *statecode=[nowdic valueForKey:@"statecode"];
    
    if ([[hourdic objectForKey:@"pop"] intValue]>50 ) {
         self.weahericon=@"weather-shower@2x.png";
    }else{
         self.weahericon=[Utils getcodepic:statecode];
    }
   
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date=[dateFormatter dateFromString:[hourdic objectForKey:@"date"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [formatter setDateFormat:@"HH:mm:a"];
    
    NSArray *datearry = [[formatter stringFromDate:date] componentsSeparatedByString:@":"];

    NSString *datestring=[[[[[datearry objectAtIndex:0] stringByAppendingString:@":"] stringByAppendingString:[datearry objectAtIndex:1]] stringByAppendingString:@" "]stringByAppendingString:[datearry objectAtIndex:2]];
    
    NSLog( @" datetttt %@",datestring);
    
    self.text1=datestring;
    
    self.text2=[[hourdic objectForKey:@"tmp"] stringByAppendingString: @"℃"];
    
    
    return self;
}

+(instancetype) creatmode:(NSDictionary *)hourdic:(NSDictionary *)nowdic{

    return [[self alloc] initdaymodel:hourdic:nowdic];
}




@end
