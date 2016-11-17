//
//  LeftMenuCell.m
//  Mofish
//
//  Created by zhouli on 16/6/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "LeftMenuCell.h"
#import "LeftMenuCellModel.h"
#import "Utils.h"
@implementation LeftMenuCell

- (void)awakeFromNib {
    // Initialization code
}

-(UITableViewCell *)initcell:(LeftMenuCellModel *)LeftMenuCellModel{
    
   NSString *Identifier=@"Identifier";
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    UIView *cellbackground=[[UIView alloc] initWithFrame:CGRectMake(0, 10, cell.contentView.frame.size.width, 60)];
    
    cellbackground.backgroundColor=[UIColor whiteColor];
    
     CGSize namesize=  [LeftMenuCellModel.name  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
    
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(90,(60-namesize.height)/2,namesize.width, namesize.height)];
    
    name.textColor=[UIColor grayColor];
    
    name.font=[UIFont systemFontOfSize:19];
    
    name.text=LeftMenuCellModel.name;
    
    [cell.contentView addSubview:cellbackground];
    
    UIImageView *cellimage=[[UIImageView alloc] initWithFrame:CGRectMake(35, 17.5, 25, 25)];
    
    cellimage.image=[UIImage imageNamed:LeftMenuCellModel.icon];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(20, 70, 100+namesize.width, 0.5)];
    
    line.backgroundColor=[UIColor graybackground];
    
    [cellbackground addSubview:name];
    
    [cellbackground addSubview:cellimage];
    
    [cellbackground addSubview:line];
    
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
