//
//  Weather.m
//  Mofish
//
//  Created by zhouli on 16/6/7.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "Weather.h"
#import "DayCell.h"
#import "DayFrame.h"
#import "DayModel.h"
#import "Header.h"
#import "Recommend.h"
#import "Utils.h"
#import "HeaderModel.h"
#import "RefreshHeader.h"
#import "WeatherLine.h"
#import "InformationCell.h"
#import "MJRefresh.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "WeatherTitleBar.h"
#import "ViewController.h"
#import "UIViewController+AMSlideMenu.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
@interface Weather ()<UITableViewDataSource,UIScrollViewDelegate,SwipeViewDataSource,SwipeViewDelegate,UIGestureRecognizerDelegate,AMSlideMenuDelegate>
@property(nonatomic,strong) SwipeView *swiperview;
@property(nonatomic,strong) UIImageView *backgroundImage;
@property(nonatomic,strong) UIImageView *blurImage;
@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) WeatherTitleBar *titlebar;
@property(nonatomic,copy) NSMutableDictionary *diccccccc;
@property(nonatomic,copy) NSDictionary *headdic;
@property(nonatomic,copy) NSMutableArray *weatherarry;
@property(nonatomic,copy) NSMutableArray *hourarry;
@property(nonatomic,copy) NSMutableArray *linearry;
@property(nonatomic,copy) NSDictionary *infodic;
@property(nonatomic,copy) NSMutableDictionary *recommenddic;
@property(nonatomic,copy) NSArray *cityarry;

@end

@implementation Weather

static NSString *DayCellIdentifier = @"DayCell";
static NSString *WeatherLineIdentifier= @"WeatherLine";
static NSString *InfomationIdentifier= @"Information";
static NSString *RecommendIdentifier = @"Recommend";



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    
    [self getdata];
    
    _diccccccc=[NSMutableDictionary dictionary];
    
     [super viewDidLoad];
    
    [self broadcast];
    
     [self setbackgroud];
    
     self.tapGesture = [[UIPanGestureRecognizer alloc] init];
   
     self.tapGesture.delegate = self;
    
    _swiperview=[[SwipeView alloc] initWithFrame:self.view.frame];
    
    _swiperview.pagingEnabled = YES;
    
    _swiperview.dataSource=self;
    
    _swiperview.delegate=self;
    
   [_swiperview addGestureRecognizer:self.tapGesture];
    
    _titlebar=[[WeatherTitleBar alloc]inittitlebar:self];
    
    NSString *cityname=[[_cityarry objectAtIndex:0] objectForKey:@"cityname"];
    
    [_titlebar changecityname:cityname];
    
   [self.view addSubview:_swiperview];
    
   [self.view addSubview:_titlebar];
    
    


    
    
    
  //[self networking];
}

-(void)getdata{
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    _weatherarry=[defaults arrayForKey:WeatherKey];
    
    
}


-(void)broadcast{
    
    NSString *broadcast=@"weatherbroast";
    
    NSNotificationCenter *notification=[NSNotificationCenter defaultCenter];
    
    [notification addObserver:self selector:@selector(broadcastreceive:) name:broadcast object:nil];

}

-(void)broadcastreceive:(NSNotification *)notify{

     NSDictionary *dic=[notify userInfo];
    
     NSInteger index= [dic objectForKey:@"index"];
    
     [_swiperview reloadItemAtIndex:index];
    
     NSLog(@"收到广播 %@",[dic objectForKey:@"index"]);

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    CGPoint velocity = [self.tapGesture velocityInView:self.tapGesture.view];
    BOOL isHorizontalGesture = fabs(velocity.y) < fabs(velocity.x);
    
        if (isHorizontalGesture) {
            BOOL directionIsLeft = velocity.x < 0;
            if (directionIsLeft) {
                _swiperview.scrollEnabled=YES;

             } else {
                     if (_swiperview.currentItemIndex==0) {
                         _swiperview.scrollEnabled=NO;
                         _swiperview.scrollEnabled=YES;
                     }else{
                         _swiperview.scrollEnabled=YES;
                     }
                 
        }
    }
    return true;
}

/*
 *切换城市页面回调
 */
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    
    [_titlebar changealpha:0];
    
    _blurImage.alpha=0;
    
    NSString *cityname=[[_cityarry objectAtIndex:swipeView.currentItemIndex] objectForKey:@"cityname"];
    
    [_titlebar changecityname:cityname];
    
//    NSLog(@"didSelectItemAtIndex  %d",_swiperview.currentItemIndex);
    
    NSInteger index= arc4random()%8+1;
    
       NSString *urlstring=[[ @"http://mofish.oss-cn-shanghai.aliyuncs.com/main_bg_" stringByAppendingString:[NSString stringWithFormat:@"%d",index] ] stringByAppendingString:@".jpg"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    
    CATransition *transition = [CATransition animation];
    
    transition.duration = 0.5;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.backgroundImage.layer addAnimation:transition forKey:@"backgroundImage"];
    
      [_backgroundImage sd_setImageWithURL:url];
    
}




- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    
    return _weatherarry.count;
    
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return _swiperview.bounds.size;
}

-(UIView*)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    view=[[UIView alloc]initWithFrame:self.view.frame];
    
    [self  settableview:view:index];
    
    return view;
    
}



-(void)setbackgroud{
    _backgroundImage=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _backgroundImage.image=[UIImage imageNamed:@"haha1.jpg"];
    
      NSString *urlstring= @"http://mofish.oss-cn-shanghai.aliyuncs.com/main_bg_4.jpg";
    
     NSURL *url = [NSURL URLWithString:urlstring];
    
    [_backgroundImage sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"下载完成");

    }];
    
    _blurImage=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _blurImage.alpha=0;
    
    [_blurImage setImageToBlur:[UIImage imageNamed:@"haha1.jpg"] blurRadius:10 completionBlock:nil];
    
   [self.view addSubview:_backgroundImage];
    
   [self.view addSubview:_blurImage];
}

-(void)settableview:(UIView*)citypage:(NSInteger)index{
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(2, 0, self.view.frame.size.width-4, self.view.frame.size.height)];
    
    _tableview.mj_header= [RefreshHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//
//        });
        
        [Utils requestWeather:index :^{
            
            
            
            [_tableview.mj_header endRefreshing];
            
            [Utils showToast:self.view :@"更新完成！"];
          //  NSLog(@"你完成刷新第 %d",index);
        }];
    }];
    
    _tableview.backgroundColor=[UIColor clearColor];
    
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
   // _tableview.pagingEnabled=YES;
    
    _tableview.showsVerticalScrollIndicator=NO;
    
    _tableview.delegate=self;
    
    _tableview.dataSource=self;
    
    //
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    _cityarry=[defaults arrayForKey:WeatherKey];
    
    NSDictionary *citydic=_cityarry[index];
  
    _headdic=[[citydic objectForKey:@"jsondata" ] objectForKey:@"head"];
    
    _linearry=[[citydic objectForKey:@"jsondata" ] objectForKey:@"line"];
    
    _infodic=[[citydic objectForKey:@"jsondata" ] objectForKey:@"infor"];
    
    _hourarry=[[citydic objectForKey:@"jsondata" ] objectForKey:@"hour"];
    
    _recommenddic=[[citydic objectForKey:@"jsondata" ] objectForKey:@"recommend"];
    
    HeaderModel *headermodel=[[HeaderModel alloc] initheadmodel:_headdic:[citydic objectForKey:@"cityname"]];
    
    Header *header=[[Header alloc] creatheader:headermodel];
        
    _tableview.tableHeaderView=header;

    [citypage addSubview:_tableview];
    
      
}





-(void)networking{
    
    NSString *url = @"https://api.heweather.com/x3/weather?cityid=CN101190101&key=76856e888fac43acaebc5f3030b979d6";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             //      NSLog(@"这里打印请求成功要做的事 %@",responseObject);
             
             JsonWeather *jsw=[[JsonWeather alloc] initJsonweather:responseObject];
             
            _diccccccc= [jsw getheadmodel];
             
            // NSLog(@"s哈哈哈哈哈 %@",[_diccccccc objectForKey:@"bigtemper"]);
                         
            NSLog(@"ssadsad %@",jsw);
             
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
    
}







-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
            return 225;
            break;
        case 2:
            return 150;
            break;
        case 3:
            return 400;
            break;
        default:
            return 0;
            break;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _hourarry.count;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        default:
            return 0;
            break;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            DayCell *daycell=[tableView dequeueReusableCellWithIdentifier:DayCellIdentifier];
            
            if (daycell==nil) {
                
                DayFrame *dayframe=[[DayFrame alloc] init];
                
                
                
                dayframe.daymodel=[DayModel creatmode:[_hourarry objectAtIndex:indexPath.row]:_headdic];
                
                daycell=[[DayCell alloc] initcell:dayframe];
            }
            
            return daycell;
            
            }
            break;
        case 1:
        {
            WeatherLine *weatherline=[tableView dequeueReusableCellWithIdentifier:WeatherLineIdentifier];
            
            if (weatherline==nil) {
                weatherline=[[WeatherLine alloc] initline:_linearry];
            }
            
             return weatherline;
        }
            break;
        case 2:
        {
            InformationCell *informationcell=[tableView dequeueReusableCellWithIdentifier:InfomationIdentifier];
            
            if (informationcell==nil) {
                informationcell=[[InformationCell alloc] creatinformation:_infodic];
            }
            
            return informationcell;
        }
            break;
        case 3:
        {
            Recommend *recommend=[tableView dequeueReusableCellWithIdentifier:RecommendIdentifier];
            
            if (recommend==nil) {
                
                recommend=[[Recommend alloc] creatrecommend:_recommenddic];
            }
            
            return recommend;
        }
            break;
            
        default:break;
    }
    
    return nil;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    
    CGFloat postion=MAX(scrollView.contentOffset.y, 0);
    
    CGFloat percent=MIN(postion*2/height,1);
    
    _blurImage.alpha=percent/1.2;
    
   [_titlebar changealpha:percent];
    
}






@end
