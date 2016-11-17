//
//  HotCity.m
//  Mofish
//
//  Created by zhouli on 16/7/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "HotCity.h"
#import "Utils.h"
#import "WeatherSaveModel.h"
@interface HotCity()

@property(nonatomic,assign) CGSize size;
@property(nonatomic,copy) NSArray *hotcityarry;

@end

@implementation HotCity


-(instancetype)init{

    static NSString *Identifier=@"HotCityCell";
    
    self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    return self;
}


-(instancetype)initwitharry:(NSArray *)selectcityarry{
    
    _hotcityarry=[self getdata];

    _size=[UIScreen mainScreen].bounds.size;
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    UIView *titleview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _size.width, 40)];
    
    CGSize titlesize=[@"热门城市" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    UIView *leftline=[[UIView alloc] initWithFrame:CGRectMake(20, 20+titlesize.height/2, (_size.width-80-titlesize.width)/2, 0.3)];
    
    UIView *rightline=[[UIView alloc] initWithFrame:CGRectMake((_size.width+titlesize.width)/2+20, 20+titlesize.height/2, (_size.width-80-titlesize.width)/2, 0.3)];
    
    leftline.backgroundColor=[UIColor bordercolor];
    
    rightline.backgroundColor=[UIColor bordercolor];
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake((_size.width-titlesize.width)/2, 20, titlesize.width, titlesize.height)];
    
    title.text=@"热门城市";
    
    title.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    
    title.textColor=[UIColor bordercolor];
    
    [titleview addSubview:leftline];
    
    [titleview addSubview:rightline];
    
    [titleview addSubview:title];
    
    UIView *city=[[UIView alloc] init];
    
    for (int i=0; i<_hotcityarry.count; i++) {
        
        NSDictionary *hotcitydic=[_hotcityarry objectAtIndex:i];
        
        BOOL selected=NO;
        
        for (NSDictionary *dic in selectcityarry) {
            
            if ([[dic objectForKey:@"citycode"] isEqualToString: [hotcitydic objectForKey:@"citycode"]]) {
                selected=YES;
            }
        }
        
        [city addSubview:[self initcell:i :hotcitydic:selected]];
        
    }
    
    city.frame=CGRectMake(0, 40, _size.width, _size.width*5/14+90);
    
    [self addSubview:titleview];
    
    [self addSubview:city];
    
     return self;
}

-(instancetype)initcell:(NSInteger) index:(NSDictionary *)hotcitydic:(BOOL)selected{
    
    CGFloat width=_size.width/4.5,height=_size.width/14;
   
    CGFloat widthmargin=(_size.width-width*3)/4;
    
    CGFloat heightmargin=15;
    
    CGFloat widthframe=index%3*(widthmargin+width)+widthmargin;
    
    CGFloat heightframe=index/3*(heightmargin+height)+heightmargin;
    
    UIButton *cellbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    cellbutton.tag=index;
    
    cellbutton.frame=CGRectMake(widthframe, heightframe, width, height);
    
    UIView  *cell =[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    [cellbutton addSubview:cell];
    
    [cellbutton addTarget:self action:@selector(cellbacksource:) forControlEvents:UIControlEventTouchUpInside];

    cell.layer.borderColor=selected?[UIColor systembluercolor].CGColor:[UIColor bordercolor].CGColor;
    
    cell.layer.borderWidth=0.4;
    
    cell.layer.cornerRadius=width/6;
    
    UILabel *cityname=[[UILabel alloc] init];
    
    cityname.userInteractionEnabled=NO;
    
    cell.userInteractionEnabled=NO;
    
    CGSize citynamesize=[[hotcitydic objectForKey:@"cityname"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    cityname.frame=CGRectMake((width-citynamesize.width)/2,(height-citynamesize.height)/2 , citynamesize.width, citynamesize.height);
    
    cityname.textColor=selected?[UIColor systembluercolor]:[UIColor bordercolor];
    
    cityname.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
    
    cityname.text=[hotcitydic objectForKey:@"cityname"];
    
    [cell addSubview:cityname];
    
    return cellbutton;
    
}

-(NSArray *)getdata{
    
    NSMutableArray *recommend=[NSMutableArray array];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Hotplist.plist" ofType:nil];
    
    NSArray *arry=[NSArray arrayWithContentsOfFile:path];
    
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *hotcityarry=[dic objectForKey:@"HotCity"];
        
    return hotcityarry;
    
}



-(void) cellbacksource:(UIButton *) btn{
    
    NSLog(@"点击到了");
    
    NSDictionary *hotcitydic=[_hotcityarry objectAtIndex:btn.tag];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];

    
    WeatherSaveModel *weathersavemodel =[[WeatherSaveModel alloc] initWeatherModel:[hotcitydic objectForKey:@"cityname"] :[hotcitydic objectForKey:@"citycode"] :dic :NO :NO];

    [self.delegate cellbacksource:weathersavemodel];

}



@end
