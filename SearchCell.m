//
//  SearchCell.m
//  Mofish
//
//  Created by zhouli on 16/7/15.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "SearchCell.h"
#import "Utils.h"
@implementation SearchCell

- (void)awakeFromNib {
    // Initialization code
}



-(instancetype)initcell:(NSString *)flag :(NSDictionary *)citymodel{
    
    static NSString *Identifier=@"SearchDefault";
    
    UITableViewCell *cell=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if ([flag isEqualToString:@"Default"]) {
    
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIImageView *defaultimg=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-124)/2, 50, 124, 104)];
        
        defaultimg.image=[UIImage imageNamed:@"city_search_start_bg.png"];
        
        [cell addSubview:defaultimg];
        
    }else{
        
        NSString *cellstring= [[[[[citymodel objectForKey:@"city"] stringByAppendingString:@", "] stringByAppendingString:[citymodel objectForKey:@"prov"] ]stringByAppendingString:@", "] stringByAppendingString:[citymodel objectForKey:@"cnty"]];
        
        cell.textLabel.text=cellstring ;
        
        cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
        
        cell.textLabel.textColor=[UIColor blacktext];
    }
    



    return cell;


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
