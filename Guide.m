//
//  Guide.m
//  Mofish
//
//  Created by zhouli on 16/6/25.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "Guide.h"
#import "SwipeView.h"
#import "ViewController.h"
#import "WSPagerView.h"
#import "Utils.h"

@interface Guide ()<SwipeViewDataSource,SwipeViewDelegate,WSPagerViewDelegate>
@property(nonatomic,strong) SwipeView *swiperview;
@property (nonatomic, strong) WSPagerView *pageView;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlitedImage;
@property(nonatomic,assign) CGFloat lastoffset;
@property(nonatomic,strong)  UIButton *enterButton;

@end

@implementation Guide

- (void)viewDidLoad {
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewDidLoad];
    
    _lastoffset=0;
    
    UIView *background=[[UIView alloc] initWithFrame:self.view.frame];
    
    background.backgroundColor=[UIColor whiteColor];
    
    CGSize size=self.view.frame.size;

    _swiperview=[[SwipeView alloc] initWithFrame:self.view.frame];
    
     self.pageView = [[WSPagerView alloc]initWithFrame:CGRectMake(size.width/4, size.height-40, size.width/2, 40)];
    
    _swiperview.pagingEnabled = YES;
    
    _swiperview.dataSource=self;
    
    _swiperview.delegate=self;
    
    _swiperview.bounces=NO;
    
    [self.pageView setImage:_normalImage ? _normalImage : [UIImage imageNamed:@"index"]
           highlightedImage:_highlitedImage ? _highlitedImage : [UIImage imageNamed:@"index_sel"]
                     forKey:@"1"];
    NSMutableString * pattern = @"".mutableCopy;
    for (NSInteger i = 0; i < 4; i++) {
        [pattern appendString:@"1"];
    }
    
    [self.pageView setPattern:pattern];
    
    self.pageView.delegate = self;
    
    [self.view addSubview:background];
    
    [self.view addSubview:_swiperview];
    
    [self.view addSubview:self.pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    
    return 4;
    
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView{
    
      CGFloat offset=(swipeView.scrollOffset-floorf(swipeView.scrollOffset))*1.5;
    
      UIView *item= [_swiperview itemViewAtIndex:floorf(swipeView.scrollOffset)];
      
      item.alpha=1-offset;
    
}


- (void)pageView:(WSPagerView *)pageView didUpdateToPage:(NSInteger)newPage
{
    NSLog(@"hehhehheheheh");
    
    [_swiperview scrollToPage:newPage duration:0.2];
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView{

    _pageView.page= swipeView.currentItemIndex;
    
 }

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return _swiperview.bounds.size;
}

-(UIView*)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    view=[[UIView alloc]initWithFrame:self.view.frame];
    
    view.backgroundColor=[UIColor clearColor];
    
    CGSize size=self.view.frame.size;
    
    UIImageView *imageintro=[[UIImageView alloc] initWithFrame:CGRectMake(80, size.height/6+size.width-100,size.width-160, (size.width-160)/4)];
    
    UIImageView *imagedetail=[[UIImageView alloc] initWithFrame:CGRectMake(80, size.height/6, size.width-160, size.width-160)];
    
    NSString *indexstring=[NSString stringWithFormat:@"%d",index];
    
    NSString *indexintroimage=[@"intro_tip_" stringByAppendingString:indexstring];
    
    NSString *indexdetailimage=[@"intro_icon_" stringByAppendingString:indexstring];
    
    imageintro.image=[UIImage imageNamed:indexintroimage];
    
    imagedetail.image=[UIImage imageNamed:indexdetailimage];
    
    [view addSubview:imageintro];
    
    [view addSubview:imagedetail];
    
    _enterButton = [[UIButton alloc] initWithFrame:CGRectMake((size.width-190)/2, size.height/6+size.width*5/4-50, 190.f, 50.f)];
    
    [_enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [_enterButton setTitleColor:[UIColor navycolor:0.8] forState:UIControlStateNormal];
    
    [_enterButton setTitleColor:[UIColor navycolor:0.5]  forState:UIControlStateHighlighted];
    
    _enterButton.layer.borderWidth=0.8;
    
    _enterButton.layer.borderColor=[UIColor navycolor:0.8].CGColor;
    
    _enterButton.layer.cornerRadius=5;
    
    [_enterButton addTarget:self action:@selector(onclickHighlight) forControlEvents:UIControlEventTouchDown];
    [_enterButton addTarget:self action:@selector(onclickNormal) forControlEvents:UIControlEventTouchUpInside];
    
    if (index==3) {
        
        [view addSubview:_enterButton];
    }else{
        [_enterButton removeFromSuperview];
    }
    
    return view;
}

-(void)onclickHighlight{
  _enterButton.backgroundColor=[UIColor blackcolor:0.2];

}

-(void)onclickNormal{
    _enterButton.backgroundColor=[UIColor clearColor];
    
    ViewController *mainVC = [[ViewController alloc] init];
    
    [mainVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:mainVC animated:YES completion:nil];
    
}

@end
