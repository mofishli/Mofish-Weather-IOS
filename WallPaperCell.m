//
//  WallPaperCell.m
//  Mofish
//
//  Created by zhouli on 16/7/23.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "WallPaperCell.h"
#import "Utils.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD.h"


@interface WallPaperCell()

@property(nonatomic,strong) UIView* progress;
@property(nonatomic,strong) UIImageView *downloadicon;
@property(nonatomic,strong) UIView *downloadbtn;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,copy) NSURL *url;

@end


@implementation WallPaperCell

-(UIView *)initwallpapercell:(NSInteger)index{

    CGSize  size=[UIScreen mainScreen].bounds.size;
    
    CGFloat width=(size.width-10*4)/3;
    
    _width=width;
    
    [super initWithFrame:CGRectMake(0, 0,width, width*1.3)];
        
    self.layer.cornerRadius=5;
    
    self.clipsToBounds=YES;
    
    _image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,width, width*1.3)];
    
    _image.image=[UIImage imageNamed:@"haha3.jpg"];

    [self addSubview:_image];
    
    _downloadbtn=[[UIView alloc] initWithFrame:CGRectMake(0,width*1.1, width, width*0.2)];
    
    _downloadbtn.userInteractionEnabled=NO;
    
    _downloadbtn.backgroundColor=[UIColor downloadcolor];
    
    _downloadicon=[[UIImageView alloc] initWithFrame:CGRectMake((width-20)/2,width*0.1-10, 20,20)];
    
    _progress=[[UIView alloc] init];
    
    _progress.backgroundColor=[UIColor greendownload];
    
   
    
    [self addTarget:self action:@selector(loaddata) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *urlstring=[[ @"http://mofish.oss-cn-shanghai.aliyuncs.com/main_bg_" stringByAppendingString:[NSString stringWithFormat:@"%d",index] ] stringByAppendingString:@".jpg"];
    
    _url = [NSURL URLWithString:urlstring];
  
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager diskImageExistsForURL:_url];
    if ([manager diskImageExistsForURL:_url]) {
       
        NSLog(@"图片已缓存");
        
        _havedownload=YES;
        
          _downloadicon.image=[UIImage imageNamed:@"city_edit_end.png"];
        
         [_downloadbtn addSubview:_progress];
        
         [self loadingwallpaper:1];
        
    }else{
    
        NSLog(@"图片未缓存");
        
        _havedownload=NO;
        
        [self addSubview:_downloadbtn];
        
        _downloadicon.image=[UIImage imageNamed:@"non_download.png"];
    }
    
    [_downloadbtn addSubview:_downloadicon];
    
    return self;
}


-(void)loaddata{
    
    if(_havedownload){
       
        [self showtoast:@"已添加到壁纸"];
    
    }else{
        
        [_downloadicon removeFromSuperview];
        
        [_downloadbtn addSubview:_progress];
        
        [_image sd_setImageWithURL:_url placeholderImage:[UIImage  imageNamed:@"haha1.jpg"] options:nil progress:^(NSInteger receivedSize, NSInteger expectedSize){
            NSLog(@"下载了   %d   共计  %d",receivedSize,expectedSize);
            
            CGFloat percent=receivedSize/expectedSize;
            
            [self loadingwallpaper:percent];
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            NSLog(@"下载完成");
            
            if(error.copy==-1){
            [self showtoast:@"下载失败"];
            }else{
                
                [self showtoast:@"下载完成"];
            }
            
            
            
            _downloadicon.image=[UIImage imageNamed:@"city_edit_end.png"];
            
            [_downloadbtn addSubview:_downloadicon];
            
            [self loadingwallpaper:1];
            
        }];
    }
    
  
    
    
    
    
        

}



-(void)loadingwallpaper:(CGFloat)percent{
    
    _progress.frame=CGRectMake(0, 0, _width*percent, _width*0.2);

}

/**
 弹出toast
 */

-(void)showtoast:(NSString *) text{
    
    MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    
    UIImage *image = [[UIImage imageNamed:@"city_edit_end.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    hud.customView = imageView;
    
    hud.opacity=0.6;
    
    hud.customView.tintColor=[UIColor whiteColor];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText= NSLocalizedString(text, @"HUD completed title");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
    
    return;
    
}


@end
