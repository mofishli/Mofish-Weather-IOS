//
//  RecommendModel.m
//  Mofish
//
//  Created by zhouli on 16/6/16.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

-(instancetype)initrecommendmodel:(NSDictionary *)dic:(NSMutableDictionary *)recommenddic{
  
    self.title=dic[@"title"];
    
    self.icon=dic[@"icon"];
    
   // NSLog(@"recommenddicrecommenddicrecommenddic %@",recommenddic);
    
    NSDictionary *tips;
    
    if ([_title isEqualToString:@"穿衣"]) {
       
        tips=[recommenddic objectForKey:@"drsg"];
   
    }else if([_title isEqualToString:@"舒适度"]){
       
        tips=[recommenddic objectForKey:@"comf"];

    }else if([_title isEqualToString:@"运动"]){
        
        tips=[recommenddic objectForKey:@"sport"];
        
    }else if([_title isEqualToString:@"感冒"]){
        
        tips=[recommenddic objectForKey:@"flu"];
        
    }else if([_title isEqualToString:@"紫外线"]){
        
        tips=[recommenddic objectForKey:@"uv"];
        
    }else if([_title isEqualToString:@"洗车"]){
        
        tips=[recommenddic objectForKey:@"cw"];
        
    }else if([_title isEqualToString:@"晾晒"]){
        
        tips=[recommenddic objectForKey:@"sport"];
        
    }else if([_title isEqualToString:@"出游"]){
        
        tips=[recommenddic objectForKey:@"trav"];
        
    }
    
    
 
    
    self.recommend=[tips objectForKey:@"brf"];

    return self;
}

+(instancetype)creat:(NSDictionary *)dic:(NSMutableDictionary *)recommenddic{
  
    return [[self alloc] initrecommendmodel:dic :recommenddic];
}

@end
