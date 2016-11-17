//
//  DayCell.m
//  Mofish
//
//  Created by zhouli on 16/6/3.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "DayCell.h"
#import "DayFrame.h"
#import "DayModel.h"
#import "Utils.h"

@implementation DayCell



-(UITableViewCell*)initcell:(DayFrame *)dayframe{
    
    static NSString *Identifier=@"DayCell";
    
    UITableViewCell *cell=[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIColor *backcolor=[UIColor blackcolor:0.3];
    
    cell.backgroundColor=backcolor;

    UIImageView *weatherIcon=[[UIImageView alloc] initWithFrame:dayframe.weatherIconframe];
    
    weatherIcon.image=[UIImage imageNamed:dayframe.daymodel.weahericon];
    
    UILabel *text1=[[UILabel alloc]initWithFrame:dayframe.textframe];
    
    text1.textColor=[UIColor whiteColor];
    
    text1.text=dayframe.daymodel.text1;
    
    text1.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    UILabel *text2=[[UILabel alloc] initWithFrame:dayframe.text2frame];
    
    text2.textColor=[UIColor whiteColor];
    
    text2.text=dayframe.daymodel.text2;
    
    text2.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    [cell.contentView addSubview:weatherIcon];
    
    [cell.contentView addSubview:text2];
    
    [cell.contentView addSubview:text1];
    
    return cell;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
