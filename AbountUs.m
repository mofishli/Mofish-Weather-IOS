//
//  AbountUs.m
//  Mofish
//
//  Created by zhouli on 16/8/17.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "AbountUs.h"
#import "TitleBar.h"
#import "Utils.h"


#define NAME @"木鱼天气"
#define VERSION @"Version 1.0.0"
#define GUANWANG @"官方网站：www.mofish.com"
#define GUANBO @"官方微博：木鱼天气"
#define GUANYOU @"官方邮箱：mofish@163.com"
#define DEVELOPER @"开发者：Netif"
#define TIPS  @"木鱼天气会使用您的HealthKit数据计算空气污染对您的危害程度"
#define BANQUAN @"Copyright © 2016 Mofish Corp.All Rights Reserved"



@interface AbountUs ()<TitleBarDelegate>

@end

@implementation AbountUs

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor graybackground];
    
    TitleBar *titlebar=[[TitleBar alloc] inittitlebar:@"关于我们" :NO:YES];
    
    titlebar.delegate=self;
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    CGFloat imagesize=150;
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake((size.width-imagesize)/2, 100, imagesize, imagesize)];
    
    logo.image=[UIImage imageNamed:@"AppIcon60x60@3x.png"];
    
    logo.layer.cornerRadius=10;
    
    logo.layer.masksToBounds=YES;
    
    CGSize appnamesize=[NAME boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]} context:nil].size;
    
    UILabel *appname=[[UILabel alloc] init];
    
    appname.frame=CGRectMake((size.width-appnamesize.width)/2,270, appnamesize.width, appnamesize.height);
    
    appname.text=NAME;
    
    appname.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    
    appname.textColor=[UIColor blackColor];
    
    CGSize versionsize=[VERSION boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    UILabel *version=[[UILabel alloc] init];
    
    version.frame=CGRectMake((size.width-versionsize.width)/2,285+appnamesize.height, versionsize.width, versionsize.height);
    
    version.text=VERSION;
    
    version.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    
    version.textColor=[UIColor blackColor];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(20, 300+appnamesize.height+versionsize.height, size.width-40, 0.5)];
    
    [Utils drawDashLine:line lineLength:6 lineSpacing:2.5 lineColor:[UIColor graytext]];
  
    //官网
    CGFloat guanwangheight=315+appnamesize.height+versionsize.height;
    
    CGSize guanwangsize=[GUANWANG boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    UILabel *guanwang=[[UILabel alloc] init];
    
    guanwang.frame=CGRectMake((size.width-guanwangsize.width)/2,guanwangheight, guanwangsize.width, guanwangsize.height);
    
    guanwang.text=GUANWANG;
    
    guanwang.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    guanwang.textColor=[UIColor blackColor];
   
  
    
    //官博
    CGFloat guanboheight=guanwangheight+guanwangsize.height+10;
    
    CGSize guanbosize=[GUANBO boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    UILabel *guanbo=[[UILabel alloc] init];
    
    guanbo.frame=CGRectMake((size.width-guanwangsize.width)/2,guanboheight, guanbosize.width, guanbosize.height);
    
    guanbo.text=GUANBO;
    
    guanbo.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    guanbo.textColor=[UIColor blackColor];
    
    
    //官邮
    CGFloat guanyouheight=guanboheight+guanbosize.height+10;
    
    CGSize guanyousize=[GUANYOU boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    UILabel *guanyou=[[UILabel alloc] init];
    
    guanyou.frame=CGRectMake((size.width-guanwangsize.width)/2,guanyouheight, guanyousize.width, guanyousize.height);
    
    guanyou.text=GUANYOU;
    
    guanyou.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    guanyou.textColor=[UIColor blackColor];
    
    
    //开发者
    CGFloat developerheight=guanyouheight+guanyousize.height+10;
    
    CGSize developersize=[DEVELOPER boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    UILabel *developer=[[UILabel alloc] init];
    
    developer.frame=CGRectMake((size.width-guanwangsize.width)/2,developerheight, developersize.width, developersize.height);
    
    developer.text=DEVELOPER;
    
    developer.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    developer.textColor=[UIColor blackColor];
    

    //提示
    
    CGSize tipssize=[TIPS boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    UILabel *tips=[[UILabel alloc] init];
    
    tips.frame=CGRectMake((size.width-tipssize.width)/2,size.height-100, tipssize.width, tipssize.height);
    
    tips.text=TIPS;
    
    tips.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    
    tips.textColor=[UIColor graytext];
    
    //版权
    
    CGSize banquansize=[BANQUAN boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    UILabel *banquan=[[UILabel alloc] init];
    
    banquan.frame=CGRectMake((size.width-banquansize.width)/2,size.height-40-banquansize.height, banquansize.width, banquansize.height);
    
    banquan.text=BANQUAN;
    
    banquan.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    
    banquan.textColor=[UIColor blackColor];
    
    [self.view addSubview:titlebar];
    
    [self.view addSubview:logo];
    
    [self.view addSubview:appname];
    
    [self.view addSubview:version];
    
    [self.view addSubview:line];
    
    [self.view addSubview:guanwang];
    
    [self.view addSubview:guanbo];
    
    [self.view addSubview:guanyou];
    
    [self.view addSubview:developer];
    
    [self.view addSubview:tips];
    
    [self.view addSubview:banquan];
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)back{
    
  //  [self dismissViewControllerAnimated:YES completion:nil];

    [self.navigationController popViewControllerAnimated:YES];
}


@end
