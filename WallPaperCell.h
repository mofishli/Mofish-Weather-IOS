//
//  WallPaperCell.h
//  Mofish
//
//  Created by zhouli on 16/7/23.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WallPaperCell : UIButton

-(UIView *) initwallpapercell:(NSInteger)index;

-(void) loaddata;

@property(nonatomic,assign)BOOL havedownload;

@end
