//
//  SelectCity.h
//  Mofish
//
//  Created by zhouli on 16/7/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherSaveModel;

@protocol SelectCityDelegate

-(void) addcity:(WeatherSaveModel *)weathersavemodel;

@end

@interface SelectCity : UIViewController

@property(nonatomic,strong) UIButton *closebutton;

@property(nonatomic,strong) UITableView *searchview;

@property(nonatomic,strong) NSMutableArray *searchresultarry;

@property(nonatomic,strong) NSMutableArray *searchsourcearry;

@property(nonatomic,weak) id<SelectCityDelegate> delegate;

-(void) getselectcityarry:(NSArray *)selectcityarry;

@end

