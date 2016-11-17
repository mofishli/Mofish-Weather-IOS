//
//  CityCell.h
//  Mofish
//
//  Created by zhouli on 16/6/30.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherSaveModel.h"

@protocol CityCellDelegate

-(void)reloacitydata:(WeatherSaveModel *)weatherdata:(NSInteger)index;

@end


@interface CityCell : UIView

-(UIView *) initcitycell:(WeatherSaveModel *) weathermodel:(NSInteger)index;

@property(nonatomic,weak) id<CityCellDelegate>  delegate;

@end
