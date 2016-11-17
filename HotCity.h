//
//  HotCity.h
//  Mofish
//
//  Created by zhouli on 16/7/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  WeatherSaveModel;

@protocol HotCityDelegate

-(void) cellbacksource:(WeatherSaveModel *)weathersavemodel;

@end

@interface HotCity : UITableViewCell

@property(nonatomic,weak) id<HotCityDelegate> delegate;

-(void) initwitharry:(NSArray *)selectcityarry;

@end
