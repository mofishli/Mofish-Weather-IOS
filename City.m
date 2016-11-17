//
//  City.m
//  Mofish
//
//  Created by zhouli on 16/6/20.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "City.h"
#import "TitleBar.h"
#import "CityCell.h"
#import "GMGridView.h"
#import "Utils.h"
#import "MBProgressHUD.h"
#import "WeatherSaveModel.h"
#import "SelectCity.h"
#import <UIViewController+AMSlideMenu.h>
#import "MBProgressHUD.h"
#define  weatherkey  "WeatherKey"

@interface City ()<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate,SelectCityDelegate,UIGestureRecognizerDelegate,AMSlideMenuDelegate,TitleBarDelegate,UIScrollViewDelegate,CityCellDelegate>
@property(nonatomic,strong) NSMutableArray *weatherarry;

@property(nonatomic,copy) NSUserDefaults *defaults;
@property(nonatomic,strong) GMGridView *gmGridView;
@property(nonatomic,strong)UIButton *addbutton;
@property(nonatomic,strong)TitleBar *titlebar;
 @end

@implementation City

-(void)loadView{
    
    [self getdata];
    
    [super loadView];
    
    NSInteger spacing =10 ;
    
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, (self.view.frame.size.width-10*4)*4*2/3+30)];
    
    gmGridView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    gmGridView.backgroundColor = [UIColor graybackground];
    
    [self.view addSubview:gmGridView];
    
    _gmGridView = gmGridView;
    
    _gmGridView.style = GMGridViewStyleSwap;
    
    _gmGridView.itemSpacing = spacing;
    
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    
    _gmGridView.centerGrid = NO;
    
 //   _gmGridView.bounces=NO;
    
   // _gmGridView.editing=YES;
    
    _gmGridView.actionDelegate = self;
    
    _gmGridView.sortingDelegate = self;
    
    _gmGridView.transformDelegate = self;
    
    _gmGridView.dataSource = self;
    
    CGFloat width=(self.view.frame.size.width-14*3)/3;
    
    CGFloat height=width*1.3;
    
   _addbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [_addbutton setImage:[UIImage imageNamed:@"add_city_normal.png"] forState:UIControlStateNormal];
    
    [_addbutton setImage:[UIImage imageNamed:@"add_city_press.png"] forState:UIControlStateHighlighted];
    
    [_addbutton addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    
    _addbutton.frame=CGRectMake(_weatherarry.count%3*(width+spacing)+spacing, _weatherarry.count/3*(height+spacing)+spacing, width, height+10);
    
    [_gmGridView addSubview:_addbutton];

}


/**
 添加item
 */

-(void) additem:(WeatherSaveModel *)weathersavemodel{
    
    CGFloat width=(self.view.frame.size.width-14*3)/3;
    
    NSInteger spacing =10 ;
    
    CGFloat height=width*1.3;

    [_weatherarry addObject:weathersavemodel];
    
    [_gmGridView insertObjectAtIndex:[_weatherarry count] - 1 withAnimation:GMGridViewItemAnimationNone];

    _addbutton.frame=CGRectMake(_weatherarry.count%3*(width+spacing)+spacing, _weatherarry.count/3*(height+spacing)+spacing, width, height+10);
    
    [self showtoast];
}



/**
 移除item
 */

-(void) removeitem:(NSInteger) index{
  
    CGFloat width=(self.view.frame.size.width-14*3)/3;
    
    NSInteger spacing =10 ;
    
    CGFloat height=width*1.3;

    [_weatherarry removeObjectAtIndex:index];
    
    [_gmGridView removeObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade];
    
     _addbutton.frame=CGRectMake(_weatherarry.count%3*(width+spacing)+spacing, _weatherarry.count/3*(height+spacing)+spacing, width, height+10);

}

/**
 进入选择城市页面 */
-(void)selectCity{

    NSLog(@"selectCity");
    
    SelectCity *selectcity = [[SelectCity alloc] init];
    
    [selectcity getselectcityarry:_weatherarry];
    
     selectcity.delegate=self;
    
    [selectcity setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:selectcity animated:YES completion:nil];
}

/**
 回传代理 */

-(void)addcity:(WeatherSaveModel *)weathersavemodel{
    
    NSLog(@"代理陈工");
    
    [self additem:weathersavemodel];

}

/**
弹出toast
 */

-(void)showtoast{
    
    MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIImage *image = [[UIImage imageNamed:@"select_city_toast.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    hud.customView = imageView;
    
    hud.opacity=0.6;
    
    hud.customView.tintColor=[UIColor whiteColor];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText= NSLocalizedString(@"添加成功 ！", @"HUD completed title");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
    
    return;
    
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _titlebar=[[TitleBar alloc] inittitlebar :@"城市":YES :NO];
    
    _titlebar.viewcontroller=self;
    
    _titlebar.delegate=self;
    
    [self.view addSubview:_titlebar];
       
}
/**
 改变editing状态的代理
 */


-(void)changeedittingstate:(BOOL)edit{
    
    if (edit) {
        _gmGridView.editing=YES;
        
    }else{
       _gmGridView.editing=NO;
    }
}


/**
 获取初始数据
 */

-(void)getdata{
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    _weatherarry=[[_defaults arrayForKey:@weatherkey] mutableCopy];

}

/**
 确定有多少个item
 */

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _weatherarry.count;
}

/**
 确定每个item的尺寸大小函数
 */

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    CGSize  size=self.view.frame.size;
    
    CGFloat width=(size.width-14*3)/3;
   
    return CGSizeMake(width, width*1.3);
}

/**
 每个item的view构建函数
 */
- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
    
        UIImage *deleteButtonview = [UIImage imageNamed:@"close_x.png"];
        
        [cell setDeleteButtonIcon:deleteButtonview];
        
        cell.deleteButtonOffset = CGPointMake(-7, -7);
        
        WeatherSaveModel *weathermodeldic= _weatherarry[index];
         
        CityCell *citycell=[[CityCell alloc] initcitycell:weathermodeldic :index];
        
        citycell.delegate=self;
            
        cell.contentView = citycell;
        
    }
    
    return cell;
}


/**
 移除item代理
 */
- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index{

    [self removeitem:index];
}


/**
  当两个item交换位置时会触发的函数
 */

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
        [_weatherarry exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
        
        [_defaults setObject:_weatherarry forKey:@weatherkey];
    
}

/**
 常按item至开始晃动会触发的函数
 */

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
      NSLog(@"_gmGridView.isEditing   %@ ",_gmGridView.isEditing?@"YES":@"NO");
    
    
    [self disableSlidePanGestureForLeftMenu];
    
    _titlebar.editing=YES;
    
    _titlebar.settingimg.image=[UIImage imageNamed:@"city_edit_end.png"];

    [_gmGridView setEditing:YES animated:YES];
    
    [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             cell.contentView.layer.shadowOpacity = 0.15;
                             
                             cell.contentView.transform=CGAffineTransformMakeScale(1.1, 1.1);
                         }
                         completion:nil
         ];
    
    

}



/**
 从晃动到停止会触发的函数
 */

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
   
    [self enableSlidePanGestureForLeftMenu];
    
    cell.contentView.layer.shadowOpacity = 0;
    
    cell.contentView.transform=CGAffineTransformMakeScale(1, 1);
   
}

/**
 从cell访问网络回调
 */

-(void)reloacitydata:(WeatherSaveModel *)weatherdata :(NSInteger)index{
    
    
  
    [_weatherarry replaceObjectAtIndex:index withObject:weatherdata];
    
    [_gmGridView  reloadObjectAtIndex:index animated:NO];
}

- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index{
  
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position{
    
     NSLog(@"_gmGridView.isEditing   %@ ",_gmGridView.isEditing?@"YES":@"NO");

}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell{
  
    NSLog(@"didStartTransformingCell");
  
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell{
 NSLog(@"didEndTransformingCell");
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex{

    NSLog(@"moveItemAtIndex");

}




@end
