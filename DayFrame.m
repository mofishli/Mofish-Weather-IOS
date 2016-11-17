//
//  DayFrame.m
//  Mofish
//
//  Created by zhouli on 16/6/4.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "DayFrame.h"

@implementation DayFrame

-(void)setDaymodel:(DayModel *)daymodel{
 
    _daymodel=daymodel;
    
    
    
    CGSize text1size=[_daymodel.text1 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
      CGSize text2size=[_daymodel.text2 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    
    _weatherIconframe=CGRectMake(15, 10, 25, 25);
    
    _textframe=CGRectMake(60,(50-text1size.height)/2, text1size.width, text1size.height);
    
    _text2frame=CGRectMake([UIScreen mainScreen].bounds.size.width- text2size.width-20,(50-text2size.height)/2, text2size.width, text2size.height);


}

@end
