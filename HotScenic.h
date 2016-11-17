//
//  HotScenic.h
//  Mofish
//
//  Created by zhouli on 16/7/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  WeatherSaveModel;

@protocol HotScenicDelegate

-(void) cellbacksource:(WeatherSaveModel *)weathersavemodel;

@end

@interface HotScenic : UITableViewCell

@property(nonatomic,weak) id<HotScenicDelegate> delegate;

-(void) initwitharry:(NSArray *)selectcityarry;

@end
