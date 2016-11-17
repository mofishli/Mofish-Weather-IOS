//
//  DayModel.h
//  Mofish
//
//  Created by zhouli on 16/6/3.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayModel : NSObject

@property(nonatomic,copy) NSString *weahericon;
@property(nonatomic,copy) NSString *text1;
@property(nonatomic,copy) NSString *text2;

-(instancetype) initdaymodel:(NSDictionary *)hourdic;

+(instancetype) creatmode:(NSDictionary *)hourdic:(NSDictionary *)nowdic;
@end
