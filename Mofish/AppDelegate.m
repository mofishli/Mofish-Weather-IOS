//
//  AppDelegate.m
//  Mofish
//
//  Created by zhouli on 16/6/3.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "Guide.h"
#import "Utils.h"

#import <CoreLocation/CoreLocation.h>
#import "JsonWeather.h"
#import "ZYPinYinSearch.h"
#import "WeatherSaveModel.h"



@interface AppDelegate ()<CLLocationManagerDelegate>
@property(nonatomic,strong) NSMutableArray *weatherarry;
@property(nonatomic,copy) NSMutableDictionary *currentCity;
@property(nonatomic,retain) CLLocationManager *locationManager;
@end



@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
    [self judgefristboot];
    
    [self share];
    
    [self test];
    
    [self loadData];
    
    [self locate];
   
    return YES;
}

-(void)judgefristboot{
    
    NSString *bootkey=@"IsNotFristBoot";

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    BOOL *BootFlag=[defaults boolForKey:bootkey];
    
    

   // [defaults setBool:YES forKey:bootkey];

    if (BootFlag==YES) {
       
         
         Guide *mainVC = [[Guide alloc] init];
         [self loadview:mainVC];
        
    }else{
    
         ViewController *mainVC = [[ViewController alloc] init];
         [self loadview:mainVC];
    }

}

-(void)test{
 
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    _weatherarry=[defaults arrayForKey:WeatherKey];
    
    NSMutableArray *aarrr=[NSMutableArray array];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    NSDictionary *head=[NSDictionary dictionaryWithObject:@"--" forKey:@"bigtemper"];
    
    [dic setObject:head forKey:@"head"];
    
//     WeatherSaveModel *weathersavemodel1=[[WeatherSaveModel alloc] initWeatherModel:@"南京" :@"CN101190101" :dic :YES :YES ];
    
      WeatherSaveModel *weathersavemodel2=[[WeatherSaveModel alloc] initWeatherModel:@"杭州" :@"CN101210101" :dic :YES :NO ];
    
       WeatherSaveModel *weathersavemodel3=[[WeatherSaveModel alloc] initWeatherModel:@"常州" :@"CN101191101"
    :dic :YES :YES ];
    
       WeatherSaveModel *weathersavemodel4=[[WeatherSaveModel alloc] initWeatherModel:@"九寨沟" :@"CN10127190601A"
                                                                                  :dic :YES :YES ];
    
   //  [aarrr addObject:weathersavemodel1];
     [aarrr addObject:weathersavemodel2];
     [aarrr addObject:weathersavemodel3];
     [aarrr addObject:weathersavemodel4];
    
    //NSLog(@"   呵呵呵大 %@",aarrr);
    
  //  [defaults setObject:aarrr forKey:WeatherKey];

}

- (void)locate {
    // 判断是否开启定位
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        
         NSLog(@"开启定位");
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    } else {
        
        NSLog(@"没开启定位");
    
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"无法进行定位" message:@"请在“设置－隐私－定位服务”中检查您是否已开启定位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}




-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    
    NSLog(@"进行定位");
      CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
     CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placeMark = placemarks[0];
        
        
        [self citylocate];
        
        NSString *cityname=[self subcityname:placeMark.locality];
        
        NSString *smallcityname=[self subcityname:placeMark.subLocality];
        
        _currentCity=[NSMutableDictionary dictionary];

        [_currentCity setValue:cityname forKey:@"bigcity"];
       
        [_currentCity setValue:smallcityname forKey:@"smallcity"];
        
        NSLog(@"哈哈哈哈哈 %@",_currentCity);
    }];
    
    [manager stopUpdatingLocation];

}

-(NSString *)subcityname:(NSString*)cityname{
    

    cityname=[cityname stringByReplacingOccurrencesOfString:@"镇" withString:@""];
    cityname=[cityname stringByReplacingOccurrencesOfString:@"县" withString:@""];
    cityname=[cityname stringByReplacingOccurrencesOfString:@"区" withString:@""];
    cityname=[cityname stringByReplacingOccurrencesOfString:@"市" withString:@""];
    cityname=[cityname stringByReplacingOccurrencesOfString:@"省" withString:@""];

    return cityname;
}


-(void) citylocate{
    
    WeatherSaveModel *weathersavemodel;
    
    BOOL located=NO;

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray *cityarry=[[defaults arrayForKey:CityKey] mutableCopy];
    
    NSArray *smallarry=[ZYPinYinSearch searchWithOriginalArray:cityarry andSearchText:[_currentCity objectForKey:@"smallcity"]andSearchByPropertyName:@"city"];
    
    
    
    if (smallarry.count==0) {
      
        NSArray *bigarry=[ZYPinYinSearch searchWithOriginalArray:cityarry andSearchText:[_currentCity objectForKey:@"bigcity"]andSearchByPropertyName:@"city"];

        if (bigarry.count==0) {
            
//           [[[UIAlertView alloc] initWithTitle:@"定位失败" message:@"请手动添加您所想关注的城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            
        }else{
            
            located=YES;
            
         weathersavemodel=[[WeatherSaveModel alloc] initWeatherModel:[bigarry[0] objectForKey:@"city"] :[bigarry[0] objectForKey:@"id"] :nil :YES :YES ];
        }
    }else{
    
        located=YES;

     weathersavemodel=[[WeatherSaveModel alloc] initWeatherModel:[smallarry[0] objectForKey:@"city"] :[smallarry[0] objectForKey:@"id"] :nil :YES :YES ];
    }
    
    
    if (located) {
        for (NSDictionary *dic in _weatherarry) {
            
            if ([[dic objectForKey:@"citycode"] isEqualToString: [weathersavemodel  objectForKey:@"citycode"]]) {
                
                
                return;
            }
        }
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        _weatherarry=[[defaults arrayForKey:WeatherKey] mutableCopy];
        
       [_weatherarry insertObject:weathersavemodel atIndex:0];
        
        [defaults setObject:_weatherarry forKey:WeatherKey];
        
         NSLog(@"weathersavemodelweathersavemodelweathersavemodel %@",_weatherarry);

    }
    
   
    
   
    
}

-(void )loadData{
    
   
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSArray *weatherarry=[defaults arrayForKey:WeatherKey];
    
    
    for (int i=0; i<weatherarry.count; i++) {
        
        [Utils requestWeather:i :^{}];
       
    }
    
    [Utils requestCity];

}

-(void)loadview:(UIViewController *) mainVC{
    UINavigationController *startNVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = startNVC;
    [self.window makeKeyAndVisible];
    
    TAdLaunchImageView *adLaunchImageView = [[TAdLaunchImageView alloc]initWithImage:[UIImage ty_getLaunchImage]];
    adLaunchImageView.URLString = @"http://img1.126.net/channel6/2015/020002/2.jpg?dpi=6401136";
    [adLaunchImageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeAnimationWithDelay:0] completion:^(BOOL finished) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
}


- (void)pushAdViewCntroller
{
    // 获取到navVC
    UITabBarController *tabbBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navVC = tabbBarVC.viewControllers.firstObject;
    
    // 你要推出的VC
    UIViewController *VC = [[UIViewController alloc]init];
    VC.view.backgroundColor = [UIColor redColor];
    [navVC pushViewController:VC animated:YES];
}

-(void)share{
    
     [ShareSDK registerApp:@"iosv1101"];
    
     [ShareSDK connectSMS];

    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQQWithQZoneAppKey:@"801312852"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"
                             weiboSDKCls:[WeiboSDK class]];
    
    [ShareSDK connectWeChatWithAppId:@"wxf26c57b288e04580"
                           appSecret:@"829410720e84fd5b102099094dc6cd74"
                           wechatCls:[WXApi class]];
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
