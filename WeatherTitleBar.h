//
//  TitleBar.h
//  Mofish
//
//  Created by zhouli on 16/6/18.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
@protocol WeatherTitleBarDelegate <NSObject>



@end


@interface WeatherTitleBar : UIView

-(instancetype) inittitlebar:(Weather *)weather;

-(void) changealpha:(CGFloat) alpha;

-(void) changecityname:(NSString *) cityname;

@end
