//
//  WallPaper.m
//  Mofish
//
//  Created by zhouli on 16/7/23.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "WallPaper.h"
#import "TitleBar.h"
#import "Utils.h"
#import "GMGridView.h"
#import "WallPaperCell.h"
#import "Weather.h"

@interface WallPaper ()<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate>

@property(nonatomic,strong)TitleBar *titlebar;
@property(nonatomic,strong) GMGridView *gmGridView;

@end

@implementation WallPaper

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _titlebar=[[TitleBar alloc] inittitlebar :@"壁纸":NO :NO];
    
    _titlebar.viewcontroller=self;
    
    _titlebar.delegate=self;
    
    [self.view addSubview:_titlebar];
}

-(void)loadView{
    
    
    UINavigationController *nvc;
    UIViewController *rootVC;
    rootVC=[[Weather alloc]init];
    
    nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    [self.leftMenu openContentNavigationController:nvc];
    
    
    
    
    
    

    [super loadView];
    
    self.view.backgroundColor = [UIColor graybackground];
    
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
    
    _gmGridView.dontshark=NO;
    
    _gmGridView.actionDelegate = self;
    
    _gmGridView.sortingDelegate = self;
    
    _gmGridView.transformDelegate = self;
    
    _gmGridView.dataSource = self;


}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/**
 确定有多少个item
 */

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 10;
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
        
        WallPaperCell *wallpapercell=[[WallPaperCell alloc] initwallpapercell:index];
        
        cell.contentView = wallpapercell;
        
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index{
    
    return NO;
}

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position{
   
    
    GMGridViewCell *cell=[gridView cellForItemAtIndex:position];
    
    NSLog(@"_gmGridView.isEditing   %d ",position);
    
}



@end
