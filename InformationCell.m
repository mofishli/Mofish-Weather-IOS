//
//  InformationCell.m
//  Mofish
//
//  Created by zhouli on 16/9/13.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "InformationCell.h"
#import "Utils.h"
#import "WindSpeedView.h"
#import "SunInfoView.h"
@interface InformationCell()
@property(nonatomic,strong) UIView *backview;

@end


@implementation InformationCell


-(instancetype)creatinformation:(NSDictionary *)informationdic{

    UITableViewCell *inforcell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"null"];
    
    inforcell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    inforcell.backgroundColor=[UIColor clearColor];
    
    _backview=[[UIView alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 145)];
    
    _backview.backgroundColor=[UIColor blackcolor:0.3];
    
    [inforcell.contentView addSubview:_backview];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(Width/2, 20,1, 105)];
    
    line.backgroundColor=[UIColor graybackground];
    
    line.alpha=0.1;
    
    [_backview addSubview:line];
    
    [self setwindspeed:[informationdic objectForKey:@"wind"]];
    
    [self setsun:[informationdic objectForKey:@"sun"]];
    
    return inforcell;
}

-(void)setwindspeed:(NSDictionary*)windic{
 
    WindSpeedView *windview=[[WindSpeedView alloc ] initWithFrame:CGRectMake(Width/7,15, 0, 0)];
    
    [windview buildView];
    
   NSInteger windinterger=[[windic objectForKey:@"spd"] intValue];
    
    windview.circleByOneSecond=(windinterger/16)||1;
    
    [windview show];
    
    NSString *windadgelstring=[windic objectForKey:@"dir"];
    
    NSString *windlevelstring=[[windic objectForKey:@"sc"] stringByAppendingString:@"级"];
    
     CGSize windanglesize=  [windadgelstring boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
      CGSize windlevelsize=  [windlevelstring boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    CGFloat anglex=(Width/3-windlevelsize.width-windanglesize.width)/2;
    
    UILabel *windangle=[[UILabel alloc] initWithFrame:CGRectMake(anglex, 135-windanglesize.height, windanglesize.width, windanglesize.height)];
    
    windangle.textColor=[UIColor whiteColor];
    
    windangle.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    
    windangle.text=windadgelstring;
    
    UILabel *windlevel=[[UILabel alloc] initWithFrame:CGRectMake(anglex+Width/6, 135-windlevelsize.height, windlevelsize.width, windlevelsize.height)];
    
    windlevel.textColor=[UIColor whiteColor];
    
    windlevel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    
    windlevel.text=windlevelstring;
    
    [_backview addSubview:windangle];
    
    [_backview addSubview:windlevel];
    
    [_backview addSubview:windview];
}

-(void)setsun:(NSDictionary*)sundic{

    SunInfoView *sun=[[SunInfoView alloc] initWithFrame:CGRectMake(Width*3/4-60, 20, 0,0)];
    
    [sun buildView];
    
    sun.sunsireValue.timeString=[sundic objectForKey:@"sr"];
    
    sun.sunsetValue.timeString=[sundic objectForKey:@"ss"];
    
    [sun show];
    
    
    CGSize risesize=  [@"日出" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    CGSize setsize=  [@"日落" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    CGFloat anglex=(Width*4/3-setsize.width-risesize.width)/2;
    
    UILabel *rise=[[UILabel alloc] initWithFrame:CGRectMake(Width*3/4-40-risesize.width/2, 135-risesize.height, risesize.width, risesize.height)];
    
    rise.textColor=[UIColor whiteColor];
    
    rise.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    
    rise.text=@"日出";
    
    UILabel *set=[[UILabel alloc] initWithFrame:CGRectMake(Width*3/4+27-setsize.width/2, 135-setsize.height, setsize.width, setsize.height)];
    
    set.textColor=[UIColor whiteColor];
    
    set.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    
    set.text=@"日落";
    
    [_backview addSubview:rise];
    
    [_backview addSubview:set];

    [_backview addSubview:sun];
}

@end
