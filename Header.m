//
//  Header.m
//  Mofish
//
//  Created by zhouli on 16/6/4.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "Header.h"
#import "HeaderModel.h"
#import "Utils.h"
@interface Header()

@property(nonatomic,strong) UIView *header;
@property(nonatomic,strong) UILabel *city;
@property(nonatomic,strong) UIImageView *weaherIcon;
@property(nonatomic,strong) UILabel *temperstate;
@property(nonatomic,strong) UILabel *Bigtemperature;
@property(nonatomic,strong) UILabel *Bigsymbol;
@property(nonatomic,strong) UILabel *hum;
@property(nonatomic,strong) UILabel *temperrange;
@property(nonatomic,assign) CGSize screen;
@property(nonatomic,assign) CGRect headerframe;
@property(nonatomic,assign) CGRect cityframe;
@property(nonatomic,assign) CGRect weaherIconframe;
@property(nonatomic,assign) CGRect humIconframe;

@property(nonatomic,assign) CGRect Bigtemperatureframe;
@property(nonatomic,assign) CGRect Bigsymbolframe;
@property(nonatomic,assign) CGRect temperstateframe;
@property(nonatomic,assign) CGRect temperrangeframe;
@property(nonatomic,assign) CGRect humframe;
@property(nonatomic,copy) HeaderModel *headermodel;

@property(nonatomic,assign) CGRect humbackframe;
@property(nonatomic,assign) CGRect qualitybackframe;
@property(nonatomic,assign) CGRect qualityIconframe;
@property(nonatomic,strong) UILabel *quality;
@property(nonatomic,assign) CGRect qualityframe;

@end


@implementation Header



-(instancetype)creatheader:(HeaderModel *)headermodel{
    
    _screen=[UIScreen mainScreen].bounds.size;
    
    _headermodel=headermodel;
    
    [self setframe];
    
    [self setui];
    
    [self setdata];
   
    return _header;
}


-(void)setframe{

    CGFloat width= _screen.width;
    CGFloat height=_screen.height;
    
    _headerframe=CGRectMake(0, 0,width,height);
    
    _weaherIconframe=CGRectMake(20,height*3/5+20, 30, 30);
    
     CGSize city=  [_headermodel.city boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:51]} context:nil].size;
    
    _cityframe=CGRectMake((width-city.width)/2,height/8, city.width, city.height);
    
     CGSize temperstate=  [_headermodel.state boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]} context:nil].size;
    
    _temperstateframe=CGRectMake(60,height*3/5+50-temperstate.height,temperstate.width, temperstate.height);
    
    CGSize bigtemper=  [_headermodel.bigtemper boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:120]} context:nil].size;

    _Bigtemperatureframe=CGRectMake(20,height*3/5+50,bigtemper.width, bigtemper.height);
    
    CGSize bigsymbol=  [@"℃" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:50]} context:nil].size;
    
    _Bigsymbolframe=CGRectMake(bigtemper.width+20,height*3/5+bigtemper.height-20,bigsymbol.width, bigsymbol.height);
    
    CGSize temperrange=  [_headermodel.temperrange  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:35]} context:nil].size;
    
    _temperrangeframe=CGRectMake(23,height*3/5+bigtemper.height+50,temperrange.width, temperrange.height);
    
    _humbackframe=CGRectMake(width*2/3,height*3/5+bigtemper.height+50+(temperrange.height-27)/2,_screen.width/3.8, 27);
    
    CGSize humsize=  [_headermodel.hum  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    _humframe=CGRectMake(width/3.8-humsize.width-10,(27-humsize.height)/2,humsize.width, humsize.height);

    _humIconframe=CGRectMake(6,(27-20)/2, 20, 20);
    
    CGSize qualitysize=  [_headermodel.quality  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    _qualityframe=CGRectMake(35,(27-qualitysize.height)/2,qualitysize.width, qualitysize.height);
    
    _qualityIconframe=CGRectMake(6,(27-20)/2, 20, 20);
    
    _qualitybackframe=CGRectMake(width-qualitysize.width-64,height/8+city.height+20,qualitysize.width+44, 27);
}


-(void)setui{

    _header=[[UIView alloc]initWithFrame:_headerframe];
    
    _weaherIcon=[[UIImageView alloc] initWithFrame:_weaherIconframe];
    
    _city=[[UILabel alloc] initWithFrame:_cityframe];
    
    _city.textColor=[UIColor whiteColor];
    
    _city.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50];
    
    _temperstate=[[UILabel alloc] initWithFrame:_temperstateframe];
    
    _temperstate.textColor=[UIColor whiteColor];
    
    _temperstate.font=[UIFont  fontWithName:@"HelveticaNeue-Light" size:20];
    
    _Bigtemperature=[[UILabel alloc] initWithFrame:_Bigtemperatureframe];
    
    _Bigtemperature.textColor=[UIColor whiteColor];
    
    _Bigtemperature.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:115];
    
    _Bigsymbol=[[UILabel alloc] initWithFrame:_Bigsymbolframe];
    
    _Bigsymbol.textColor=[UIColor whiteColor];
    
    _Bigsymbol.font=[UIFont  fontWithName:@"HiraKakuProN-W3" size:35];
    
    _temperrange=[[UILabel alloc] initWithFrame:_temperrangeframe];
    
    _temperrange.textColor=[UIColor whiteColor];
    
    _temperrange.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    
    UIView *humbackground=[[UIView alloc] initWithFrame:_humbackframe];
    
    humbackground.backgroundColor=[UIColor blackcolor:0.3];

    humbackground.layer.cornerRadius=13.5;
    
    _hum=[[UILabel alloc] initWithFrame:_humframe];
    
    _hum.textColor=[UIColor whiteColor];
    
    _hum.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    UIImageView *humicon=[[UIImageView alloc] initWithFrame:_humIconframe];
    
    humicon.image=[UIImage imageNamed:@"humidity.png"];
    
    [humbackground addSubview:_hum];
    
    [humbackground addSubview:humicon];

    UIView *qualitybackground=[[UIView alloc] initWithFrame:_qualitybackframe];
    
    qualitybackground.backgroundColor=[UIColor blackcolor:0.2];
    
    qualitybackground.layer.cornerRadius=13.5;
    
    _quality=[[UILabel alloc] initWithFrame:_qualityframe];
    
    _quality.textColor=[UIColor whiteColor];
    
    _quality.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    UIImageView *qualityicon=[[UIImageView alloc] initWithFrame:_qualityIconframe];
    
    qualityicon.image=[UIImage imageNamed:_headermodel.aqi];
    
    [qualitybackground addSubview:_quality];
    
    [qualitybackground addSubview:qualityicon];
    
    [_header addSubview:_weaherIcon];
    
    [_header addSubview:_city];
    
    [_header addSubview:_temperstate];
    
    [_header addSubview:_Bigtemperature];

    [_header addSubview:_Bigsymbol];

    [_header addSubview:_temperrange];
    
    [_header addSubview:humbackground];
    
    [_header addSubview:qualitybackground];
}

-(void)setdata{
 
    _city.text=_headermodel.city;
    
    NSString *weathericonUrl=[Utils getcodepic:_headermodel.statecode];
    
    _weaherIcon.image=[UIImage imageNamed:weathericonUrl];
    
    _temperstate.text=_headermodel.state;
    
    _Bigtemperature.text=_headermodel.bigtemper;
    
    _Bigsymbol.text=@"℃";
    
    _quality.text=_headermodel.quality;
    
    _hum.text=_headermodel.hum;
    
    _temperrange.text=_headermodel.temperrange;
    
}


@end
