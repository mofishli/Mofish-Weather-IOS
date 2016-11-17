//
//  SelectCity.m
//  Mofish
//
//  Created by zhouli on 16/7/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "SelectCity.h"
#import "SearchBar.h"
#import "HotCity.h"
#import "HotScenic.h"
#import "Utils.h"
#import "SearchCell.h"
#import "WeatherSaveModel.h"
#import "MBProgressHUD.h"
@interface SelectCity ()<UITableViewDelegate,UITableViewDataSource,HotCityDelegate,HotScenicDelegate>

@property(nonatomic,strong) SearchBar *searchbar;
@property(nonatomic,strong) HotCity *hotcity;
@property(nonatomic,strong) HotScenic *hotscenic;
@property(nonatomic,copy) NSArray *selectcityarry;


@end

@implementation SelectCity

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getdata];
    
    [self initview];
    
   
}

-(void)getdata{
    
     NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    _searchsourcearry=[[defaults arrayForKey:CityKey] mutableCopy];
    
}


-(void)getselectcityarry:(NSArray *)selectcityarry{
   
    _selectcityarry=selectcityarry;

}

-(void)initview{
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    UITableView *citytableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0, size.width,size.height)];
    
    _searchview=[[UITableView alloc] initWithFrame:CGRectMake(0,80, size.width,size.height-80)];
    
    _searchview.alpha=0;
    
    citytableView.backgroundColor=[UIColor whiteColor];
    
    citytableView.delegate=self;
    
    citytableView.dataSource=self;
    
    _searchview.delegate=self;
    
    _searchview.dataSource=self;
    
    citytableView.showsVerticalScrollIndicator=NO;
    
    citytableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    _searchbar=[[SearchBar alloc] init];
    
    [_searchbar transfroviewcontroller:self];
    
    _closebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [_closebutton setImage:[UIImage imageNamed:@"city_close_normal.png"]  forState:UIControlStateNormal];
    
    [_closebutton setImage:[UIImage imageNamed:@"city_close_pressed.png"] forState:UIControlStateHighlighted];
    
    [_closebutton addTarget:self action:@selector(closecity) forControlEvents:UIControlEventTouchUpInside];
    
    _closebutton.frame=CGRectMake(20,30,25,25);
    
    [self.view addSubview:citytableView];

    [self.view addSubview:_closebutton];
    
    _searchresultarry=[NSMutableArray array];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    citytableView.tableHeaderView=_searchbar;

}


-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsety=scrollView.contentOffset.y;
    
    if(offsety>[UIScreen mainScreen].bounds.size.height/4-50){
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _closebutton.alpha=0;
                         }
                         completion:nil
         ];
       
    }else{
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _closebutton.alpha=1;
                         }
                         completion:nil
         ];
    }

    
    if (offsety<-70) {
        
       [_searchbar changebackgroundimg:-(offsety+70)/400];

    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([tableView isEqual:_searchview]) {
        
        NSString *flag=@"Normal";
        NSDictionary *citymodel;
        
        if (_searchresultarry.count==0) {
            
            flag=@"Default";
            citymodel=nil;
            
        }else{

            citymodel=[_searchresultarry objectAtIndex:indexPath.row];
        }
       SearchCell *cell=[[SearchCell alloc] initcell:flag :citymodel];
        
        return cell;
    }else{
        if(indexPath.row==0){
            
          HotCity  *cell=[tableView dequeueReusableCellWithIdentifier:@"HotCityCell"];
            
            if (cell==nil) {
                cell=[[HotCity alloc] init];
                
                [cell initwitharry:_selectcityarry];
                
                cell.delegate=self;
            }
            
             return cell;
            
        }else{
           HotScenic *cell=[tableView dequeueReusableCellWithIdentifier:@"HotScenicCell"];
            
            if (cell==nil) {
                
                cell=[[HotScenic alloc] init];
                
                [cell initwitharry:_selectcityarry];
                
                cell.delegate=self;
            }
             return cell;
        }
    }
}


-(void) cellbacksource:(WeatherSaveModel *)weathersavemodel{

    [self closecityandadd:weathersavemodel];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_searchview]) {
        
        return MAX(1, _searchresultarry.count);
        
     }else{
         
        return 2;
   
     }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGSize size=[UIScreen mainScreen].bounds.size;
    
    
    if ([tableView isEqual:_searchview]) {
    
        if (_searchresultarry.count==0) {
            
            return size.height-80;
            
        }else{
            return 50;
            
        }
    }else{
    
        if (indexPath.row==0) {
            
            return  115+size.width*5/12;
            
        }else{
            
            return 115+size.width*4/12;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if ([tableView isEqual:_searchview]) {
        
        if (_searchresultarry.count!=0) {
            
            NSDictionary *selectdic=_searchresultarry[indexPath.row];
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];

            WeatherSaveModel *weathersavemodel=[[WeatherSaveModel alloc] initWeatherModel:[selectdic objectForKey:@"city"] :[selectdic objectForKey:@"id"] :dic :YES :YES];
            
            NSLog(@"打印  %@",_searchresultarry[indexPath.row]);
            
             [self  cellbacksource:weathersavemodel];
           
        }
   }
}


-(void)closecityandadd:(WeatherSaveModel *)weathersavemodel{
    
    NSLog(@"close");
    
    for (NSDictionary *dic in _selectcityarry) {
        
        if ([[dic objectForKey:@"citycode"] isEqualToString: [weathersavemodel  objectForKey:@"citycode"]]) {
            
            
             [self showtoast];
            
             return;
        }
    }
    
    [self.delegate addcity:weathersavemodel];
        
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)closecity{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)showtoast{
 
   MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIImage *image = [[UIImage imageNamed:@"select_city_toast.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    hud.customView = imageView;
        
    hud.opacity=0.6;
    
    hud.customView.tintColor=[UIColor whiteColor];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText= NSLocalizedString(@"您已经关注过TA了哦", @"HUD completed title");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });

    return;
               
}


@end
