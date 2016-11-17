//
//  DayFrame.h
//  Mofish
//
//  Created by zhouli on 16/6/4.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DayModel.h"

@interface DayFrame : NSObject

@property(nonatomic,assign) CGRect weatherIconframe;

@property(nonatomic,assign) CGRect textframe;

@property(nonatomic,assign) CGRect text2frame;

@property(nonatomic,copy)DayModel *daymodel;

@end
