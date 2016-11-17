//
//  TitleBar.h
//  Mofish
//
//  Created by zhouli on 16/6/29.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AMSlideMenuMainViewController;

@protocol TitleBarDelegate

-(void) changeedittingstate:(BOOL) edit;

-(void) back;

@end

@interface TitleBar : UIView

-(instancetype) inittitlebar:(NSString *)title:(BOOL)edit:(BOOL)simple;

@property(nonatomic,weak) id<TitleBarDelegate> delegate;
@property(nonatomic,strong)UIImageView *settingimg;
@property(nonatomic,assign) BOOL editing;
@property(nonatomic,strong) AMSlideMenuMainViewController *viewcontroller;


@end
