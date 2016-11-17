//
//  HeaderModel.h
//  Mofish
//
//  Created by zhouli on 16/6/4.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject

@property(nonatomic,copy) NSString *bigtemper;
@property(nonatomic,copy) NSString *state;
@property(nonatomic,copy) NSString *statecode;
@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *temperrange;
@property(nonatomic,copy) NSString *hum;
@property(nonatomic,copy) NSString *aqi;
@property(nonatomic,copy) NSString *quality;
-(instancetype) initheadmodel:(NSMutableDictionary *) headlmodel:(NSString *)cityname;

@end
