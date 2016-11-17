//
//  TitleBar.m
//  Mofish
//
//  Created by zhouli on 16/6/18.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "WeatherTitleBar.h"
#import <AMSlideMenuMainViewController.h>
#import "UIViewController+AMSlideMenu.h"
#import "SGActionView.h"
#import "SGGridMenu.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>
#import <ShareSDK/ShareSDK.h>


@class UMSocialControllerService;
@interface WeatherTitleBar()

@property(nonatomic,copy) UIColor *backcolor;
@property(nonatomic,strong) WeatherTitleBar *titlebar;
@property(nonatomic,copy) Weather *weather;
@property(nonatomic,strong) UIView *centerview;
@property(nonatomic,strong) UILabel *city;

@end

@implementation WeatherTitleBar



-(instancetype)inittitlebar:(Weather *)weather{
    
    _weather=weather;

    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    
    [super initWithFrame:CGRectMake(0, 0, width,64)];
    
    _backcolor= [UIColor navycolor:0];
    
    self.backgroundColor=_backcolor;
    
    [self creatcenterview];
    
    UIButton *menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *sharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
  
    UIImageView *shareimg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    UIImageView *menuimg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    menuimg.image=[UIImage imageNamed:@"menu.png"];
    
    shareimg.image=[UIImage imageNamed:@"share.png"];
    
    menubtn.frame = CGRectMake(15, 35, 60, 60);
    
    sharebtn.frame = CGRectMake(width-35, 35, 60, 60);
    
    [menubtn addSubview:menuimg];
    
    [sharebtn addSubview:shareimg];
    
    [self addSubview:menubtn];
    
    [self addSubview:sharebtn];
    
    shareimg.userInteractionEnabled=NO;
    
    [menubtn addTarget:self action:@selector(menuaction) forControlEvents:UIControlEventTouchUpInside];
    
    [sharebtn addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)creatcenterview{
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    
    CGFloat margin=11;
   
    _centerview=[[UIView alloc] init];
    
    UIImageView *location=[[UIImageView alloc] init];
    
    _city=[[UILabel alloc] init];
    
    UILabel *temper=[[UILabel alloc] init];
    
    CGSize citysize=[@"哈哈" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]} context:nil].size;
    
    CGSize tempersize=[@"28℃" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    _centerview.frame=CGRectMake((width-15-2*margin-citysize.width)/2,30, 15+2*margin+citysize.width, citysize.height);
    
    location.frame=CGRectMake(0, (citysize.height-12)/2, 12, 15);
    
    _city.frame=CGRectMake(15+margin, 0, citysize.width, citysize.height);
    
    temper.frame=CGRectMake(15+2*margin+citysize.width, (citysize.height-tempersize.height)/2, tempersize.width, tempersize.height);
    
    location.image=[UIImage imageNamed:@"location.png"];
    
    _city.text=@"哈哈";
    
    _city.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    
    temper.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    
    _city.textColor=[UIColor whiteColor];
    
    temper.textColor=[UIColor whiteColor];
    
    _centerview.alpha=0;
    
    [_centerview addSubview:location];
    
    [_centerview addSubview:_city];

   // [_centerview addSubview:temper];
    
    [self addSubview:_centerview];

}

-(void)changecityname:(NSString *)cityname{
  
     CGSize citysize=[cityname boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]} context:nil].size;
    
    _city.frame=CGRectMake(15+11, 0, citysize.width, citysize.height);
    
    _city.text=cityname;

}


-(void)menuaction{
    
   [_weather.mainSlideMenu openLeftMenu];
}

-(void) share:(NSInteger) index{
    
    NSInteger MyShareType=0;
    
    switch (index) {
        case 1:
            MyShareType=ShareTypeSMS;
            break;
        case 2:
            MyShareType=ShareTypeWeixiSession;
            break;
        case 3:
            MyShareType=ShareTypeWeixiTimeline;
            break;
        case 4:
            MyShareType=ShareTypeQQ;
            break;
        case 5:
            MyShareType=ShareTypeQQSpace;
            break;
        case 6:
            MyShareType=ShareTypeSinaWeibo;
            break;
        default:
            break;
    }
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
    
    id<ISSContent> publishContent = [ShareSDK content:@"木鱼分享"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"木鱼天气"
                                                  url:@"http://www.mofish.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK clientShareContent:publishContent
                            type:MyShareType
                   statusBarTips:YES
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                              }
                              else if (state == SSPublishContentStateFail)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
                              }
                          }];


   }


-(void) alert{
    
    SGMenuActionHandler myblock=^(NSInteger index){
        [self share:index];
    };
    
   // [SGActionView sharedActionView].style = SGActionViewStyleDark;
    
    [SGActionView showGridMenuWithTitle:@"分享"
                             itemTitles:@[ @"短信", @"微信", @"朋友圈", @"QQ",
                                           @"QQ空间", @"新浪微博"]
                                 images:@[ [UIImage imageNamed:@"sms"],
                                           [UIImage imageNamed:@"wechat"],
                                           [UIImage imageNamed:@"friend"],
                                           [UIImage imageNamed:@"QQ"],
                                           [UIImage imageNamed:@"QQzone"],
                                           [UIImage imageNamed:@"weibo"],
                                           ]
                         selectedHandle:myblock
                         
                            ];
   }


-(void)changealpha:(CGFloat) alpha{
    
    if (alpha>0.5) {
        [UIView animateWithDuration:1 animations:^{
            _centerview.alpha=1;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _centerview.alpha=0;
        }];
    
    }
  
    _backcolor=[UIColor navycolor:MIN(alpha, 0.9)];
  
    self.backgroundColor=_backcolor;

}



@end


