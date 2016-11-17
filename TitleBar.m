//
//  TitleBar.m
//  Mofish
//
//  Created by zhouli on 16/6/29.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "TitleBar.h"
#import "Utils.h"
#import "City.h"
#import <AMSlideMenuMainViewController.h>
#import "UIViewController+AMSlideMenu.h"

@interface TitleBar()


@end

@implementation TitleBar




-(instancetype)inittitlebar :(NSString *)title:(BOOL)edit:(BOOL)simple{
        
    _editing=NO;
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    
    [super initWithFrame:CGRectMake(0, 0, width,64)];
    
    self.backgroundColor=[UIColor navycolor:0.95];
    
    UIButton *menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _settingimg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    UIImageView *menuimg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    menuimg.image=[UIImage imageNamed:simple?@"left_back.png":@"menu.png"];
    
    _settingimg.image=[UIImage imageNamed:@"city_edit_start.png"];
    
    menubtn.frame = CGRectMake(15, 35, 60, 60);
    
    settingbtn.frame = CGRectMake(width-35, 35, 60, 60);
    
    [menubtn addSubview:menuimg];
    
    [settingbtn addSubview:_settingimg];
    
    CGSize titlesize=[title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]} context:nil].size;
    
    UILabel *titlelabel=[[UILabel alloc] init];

    titlelabel.frame=CGRectMake((width-titlesize.width)/2,30, titlesize.width, titlesize.height);
    
    titlelabel.text=title;
    
    titlelabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    
    titlelabel.textColor=[UIColor whiteColor];
    
    [self addSubview:menubtn];
    
    if (edit) {
         [self addSubview:settingbtn];
    }
    
    [self addSubview:titlelabel];
    
    if (simple) {
        
        [menubtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        
        [menubtn addTarget:self action:@selector(menuaction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [settingbtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)back{
    
    [self.delegate back];
}


-(void)menuaction{
    
    [_viewcontroller.mainSlideMenu openLeftMenu ];
}

-(void)setting{

    _editing=!_editing;
    
    _settingimg.image=_editing?[UIImage imageNamed:@"city_edit_end.png"]:[UIImage imageNamed:@"city_edit_start.png"];

    [self.delegate changeedittingstate:_editing];
   
}



@end
