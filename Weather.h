//
//  Weather.h
//  Mofish
//
//  Created by zhouli on 16/6/7.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import <AMSlideMenuMainViewController.h>
#import "LeftMenuView.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "JsonWeather.h"

@class LeftMenuView;
@interface Weather : AMSlideMenuMainViewController

@property (strong, nonatomic) UIPanGestureRecognizer *tapGesture;

@end
