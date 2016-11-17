//
//  JsonWeather.h
//  Mofish
//
//  Created by zhouli on 16/7/3.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonWeather : NSObject

@property(nonatomic,assign) NSDictionary *weatherdic;

-(id)initJsonweather:(id )responseobj;

-(id)getheadmodel;

-(id)gethourmodel;

-(id)getinformodel;

-(id)getforecastmodel;

-(id)getrecommendmodel;

@end
