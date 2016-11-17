//
//  Setting.m
//  Mofish
//
//  Created by zhouli on 16/6/23.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "Setting.h"
#import "TitleBar.h"
#import "Utils.h"
#import "AbountUs.h"
#import "Advice.h"
@interface Setting ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)TitleBar *titlebar;
@property(nonatomic,assign) CGSize size;


@end

@implementation Setting

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _size=self.view.frame.size;
    
    self.view.backgroundColor=[UIColor graybackground];
    
    _titlebar=[[TitleBar alloc] inittitlebar:@"设置" :NO :NO];
    
    _titlebar.viewcontroller=self;
    
    _titlebar.delegate=self;
    
    UITableView *tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 64,_size.width , _size.height)];
    
    tableview.delegate=self;
    
    tableview.dataSource=self;
    
    tableview.backgroundColor=[UIColor graybackground];
    
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;

    [self.view addSubview:tableview];

    [self.view addSubview:_titlebar];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell= [self initcell:indexPath.row];
    
    return cell;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}


-(void)loadView{
    
    [super loadView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 64;

}


-(UITableViewCell*) initcell:(NSInteger) index{

    static NSString *Identifier=@"SettingCell";
    
    UITableViewCell *cell=[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    cell.backgroundColor=[UIColor clearColor];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIButton *backgroundview=[UIButton buttonWithType:UIButtonTypeCustom];
    
    backgroundview.frame=CGRectMake(0, 0, _size.width, 50) ;
    
    backgroundview.backgroundColor=[UIColor whiteColor];
    
    UILabel *titlelabel=[[UILabel alloc] init];
    
    NSString *title;
    
    switch (index) {
        case 0:
            title=@"天气推送";
            break;
        case 1:
            title=@"城市管理";
            
            [backgroundview addTarget:self action:@selector(citymanager) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case 2:
            title=@"缓存清理";
            
            [backgroundview addTarget:self action:@selector(clearcache) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case 3:
            title=@"意见反馈";
            
            [backgroundview addTarget:self action:@selector(advice) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case 4:
            title=@"赏个好评";
            
            [backgroundview addTarget:self action:@selector(goodjob) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case 5:
            title=@"关于木鱼";
            
            [backgroundview addTarget:self action:@selector(aboutus) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        default:
            break;
    }
    
  
    
    CGSize titlesize=[title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    
    titlelabel.frame=CGRectMake(20,10, titlesize.width, titlesize.height);
    
    titlelabel.text=title;
    
    titlelabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    titlelabel.textColor=[UIColor textcolor];
    
    //箭头
    
    UIImageView *arrow=[[UIImageView alloc] initWithFrame:CGRectMake(_size.width-50, 15, 20, 20)];
    
    arrow.image=[UIImage imageNamed:@"arrow_right_gray.png"];
    
    //开关
    
    UISwitch *switchbutton=[[UISwitch alloc] init];
    
    switchbutton.center=CGPointMake(_size.width-50, 25);
    
    //缓存大小
    
    NSString *cachestring=@"1.8M";
    
    UILabel *cachelabel=[[UILabel alloc] init];
    
    CGSize cachesize=[cachestring boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    
    cachelabel.frame=CGRectMake(_size.width-60-cachesize.width,(50-cachesize.height)/2, cachesize.width+10, cachesize.height);
    
    cachelabel.text=cachestring;
    
    cachelabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    cachelabel.textColor=[UIColor blacktext];
    
    
    if (index==0) {
         [backgroundview addSubview:switchbutton];
    }else{
         [backgroundview addSubview:arrow];
    }
    if (index==2) {
         [backgroundview addSubview:cachelabel];
    }
    
    [backgroundview addSubview:titlelabel];
    
    [cell.contentView addSubview:backgroundview];
    
    return cell;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//城市管理
-(void) citymanager{

    NSLog(@"1111");

}

//缓存清理
-(void) clearcache{
    
      NSLog(@"222");
    
}

//意见反馈
-(void) advice{
    
    Advice *advice=[[Advice alloc] init];
    
    [self.navigationController pushViewController:advice animated:YES];
}

//赏个好评
-(void) goodjob{
    
      NSLog(@"4444");
    
}

//关于木鱼
-(void) aboutus{
    
    AbountUs *aboutus = [[AbountUs alloc] init];
    
//    [aboutus setModalTransitionStyle:UIModalTransitionStylePartialCurl];
//    
//    [self presentViewController:aboutus animated:YES completion:nil];
    
    [self.navigationController pushViewController:aboutus animated:YES];
}


@end
