//
//  RecommendModel.h
//  Mofish
//
//  Created by zhouli on 16/6/16.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *icon;

@property(nonatomic,copy) NSString *recommend;

+(instancetype) creat:(NSDictionary *) dic:(NSMutableDictionary *)recommenddic;

-(instancetype) initrecommendmodel:(NSDictionary *) dic:(NSMutableDictionary *)recommenddic;

@end
