//
//  LeftMenuView.m
//  Mofish
//
//  Created by zhouli on 16/6/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "LeftMenuView.h"
#import "Utils.h"

#define  ColorFromHex(s) [[UIColor alloc] initWithRed:((s & 0xFF0000) >> 16)/255.0 green:((s & 0xFF00) >> 8)/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]
@interface LeftMenuView ()
@property(nonatomic,strong) NSMutableArray *leftcombo;
@property(nonatomic,strong) UIView *backgroundView;
@property(nonatomic,strong) UIImageView *backgroundImage;
@property(nonatomic,strong) UIImageView *blurImage;
@end

@implementation LeftMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *namecombo=[@[@"天气",@"城市",@"壁纸",@"设置"] mutableCopy];
    
    NSMutableArray *iconcombo=[@[@"left_weather.png",@"left_city.png",@"left_background.png",@"left_setting.png"] mutableCopy];
    
    _leftcombo=[NSMutableArray array];
    
    for (int i=0;i<4;i++) {
        
        LeftMenuCellModel *leftmodel=[[LeftMenuCellModel alloc] init];
        
        leftmodel.name=namecombo[i];
        
        leftmodel.icon=iconcombo[i];
        
        [_leftcombo addObject:leftmodel];
    }
    
    [self setbackgroud];
    
    [self settableview];
    [super viewDidLoad];

}

-(void) settableview{
    
    self.tableView.delegate=self;
    
    self.tableView.dataSource=self;
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.tableView.backgroundView=_backgroundView;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
     [self sethead];
    
}

-(void) sethead{
    UIView *back=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/16)];
    
    self.tableView.tableHeaderView=back;
}

-(void)setbackgroud{
    _backgroundView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _backgroundView.backgroundColor=[UIColor whiteColor];
    
    _backgroundImage=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
  //  _backgroundImage.image=[UIImage imageNamed:@"leftmenupic.jpg"];
    
    _blurImage=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _blurImage.alpha=0;
    
  //  [_blurImage setImageToBlur:[UIImage imageNamed:@"leftmenupic.jpg"] blurRadius:10 completionBlock:nil];
    
  //  [_backgroundView addSubview:_backgroundImage];
    
  //  [_backgroundView addSubview:_blurImage];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leftcombo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Identifier=@"Identifier";
    
    LeftMenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell)
    {
        LeftMenuCellModel *cellmodel=_leftcombo[indexPath.row];
        
        cell =[[LeftMenuCell alloc] initcell:cellmodel];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *nvc;
    UIViewController *rootVC;
    switch (indexPath.row) {
        case 0:
        {
             rootVC=[[Weather alloc]init];
        }
            break;
        case 1:
        {
             rootVC=[[City alloc]init];
        }
            break;
        case 2:
        {
              rootVC=[[WallPaper alloc]init];
        }
            break;
        case 3:
        {
             rootVC =[[Setting alloc]init];
        }
            break;
        default:
            break;
    }
    nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    [self openContentNavigationController:nvc];
   
}


@end
