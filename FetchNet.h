//
//  FetchNet.h
//  Mofish
//
//  Created by zhouli on 16/9/22.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface FetchNet : NSObject


+(void)requestWeather :(NSInteger)index:(void (^)())block;

+(void) requestCity;

@end
