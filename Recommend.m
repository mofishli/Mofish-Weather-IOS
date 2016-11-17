//
//  Footer.m
//  Mofish
//
//  Created by zhouli on 16/6/15.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "Recommend.h"
#import "RecommendModel.h"
#import "Utils.h"
#import <math.h>
#define margin 2

@implementation Recommend


-(UIView *)creatrecommend:(NSMutableDictionary *)recommenddic{
   
    CGSize screen=[UIScreen mainScreen].bounds.size;
    
    NSMutableArray *dataarry=[self getdata:recommenddic];
    
    NSInteger number=dataarry.count;
    
    NSInteger column= number%2==0?number/2:number/2+1;
   
    CGFloat width=screen.width/2.0-margin/2.0;
    
    CGFloat height=screen.width/5;
    
    UITableViewCell *recommend=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Recommend"];
    
    recommend.selectionStyle=UITableViewCellSelectionStyleNone;
    
    recommend.backgroundColor=[UIColor clearColor];
    
    for (NSInteger i=0; i<number; i++) {
        
        RecommendModel *rm=dataarry[i];
      
        CGFloat x=i%2==0?0:screen.width/2+margin;
        
        CGFloat y=i/2==0?5:(i/2)*height+5;
        
        UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(x,  y,width, height-margin)];
        
        UIColor *color=[UIColor blackcolor:0.3];
        
        cell.backgroundColor=color;
        
        UIImageView *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, (screen.width/5-30)/2, 30, 30)];
        
        icon.image=[UIImage imageNamed:rm.icon];
        
        CGSize recommendtitle=[rm.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
        
        CGFloat titlex=width-recommendtitle.width-15;
        
        UILabel *recommendlabeltitle=[[UILabel alloc]initWithFrame:CGRectMake(titlex, 12, recommendtitle.width, recommendtitle.height)];
        
        recommendlabeltitle.text=rm.title;
        
        recommendlabeltitle.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:19];
        
        recommendlabeltitle.textColor=[UIColor whiteColor];
        
        CGSize recommendcontent=[rm.recommend boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        
        CGFloat contentx=width-recommendcontent.width-15;
        
        UILabel *recommendcontentlabel=[[UILabel alloc]initWithFrame:CGRectMake(contentx,recommendtitle.height+20, recommendcontent.width, recommendcontent.height)];
        
        recommendcontentlabel.text=rm.recommend;
        
        recommendcontentlabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        
        recommendcontentlabel.textColor=[UIColor whiteColor];
        
        [cell addSubview:recommendlabeltitle];
        
        [cell addSubview:recommendcontentlabel];
        
        [cell addSubview:icon];

                              
         [recommend.contentView addSubview:cell];
        
        
    }

     return recommend;
    
}

-(NSMutableArray *)getdata:(NSMutableDictionary *)recommenddic{
    NSMutableArray *recommend=[NSMutableArray array];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Recommend.plist" ofType:nil];
    
    NSArray *arry=[NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dic in arry) {
        
        RecommendModel *recommendmodel=[RecommendModel creat:dic :recommenddic];
        
        [recommend addObject:recommendmodel];
    }
 
    
    return recommend;
}

@end


