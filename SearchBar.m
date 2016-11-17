
//
//  SearchBar.m
//  Mofish
//
//  Created by zhouli on 16/7/11.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "SearchBar.h"
#import "SelectCity.h"
#import "Utils.h"
#import "ZYPinYinSearch.h"
@interface SearchBar()<UISearchBarDelegate,UISearchDisplayDelegate,UITextFieldDelegate>

@property(nonatomic,strong) UIImageView *backgroundImage;
@property(nonatomic,strong) UITextField *searchfield;
@property(nonatomic,strong) SelectCity *parentcontroller;
@property(nonatomic,strong) UIButton *cancelbutton;
@property(nonatomic,strong) UILabel *tipslabel;



@end

@implementation SearchBar


-(instancetype)init{
   
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    self=[super  initWithFrame:CGRectMake(0,0, size.width, size.height/4)];
    
    self.backgroundColor=[UIColor clearColor];
    
    _backgroundImage=[[UIImageView alloc] initWithFrame:CGRectMake(0,-size.height*3/4, size.width, size.height)];
    
    _backgroundImage.image=[UIImage imageNamed:@"citybackground4.jpg"];
    
   [self addSubview:_backgroundImage];
    
    CGSize tipssize=[@"连接世界，连接TA和你" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]} context:nil].size;
    
    _tipslabel=[[UILabel alloc] initWithFrame:CGRectMake(size.width-tipssize.width-30, -35, tipssize.width, tipssize.width)];
    
    _tipslabel.text=@"连接世界，连接TA和你";
    
    _tipslabel.textColor=[UIColor whiteColor];
    
    _tipslabel.font=[UIFont fontWithName:@"HelveticaNeue" size:22];
    
    _searchfield=[[UITextField alloc] initWithFrame:CGRectMake(20, 110, size.width-40, 35)];
    
    _searchfield.backgroundColor=[UIColor whiteColor];
    
    _searchfield.layer.cornerRadius=18;
    
    _searchfield.placeholder = @"搜索目的城市";
    
    _searchfield.returnKeyType = UIReturnKeySearch;
    
    _searchfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
    
    _searchfield.leftView.userInteractionEnabled = NO;
    
    _searchfield.leftViewMode = UITextFieldViewModeAlways;
    
    _searchfield.delegate=self;
    
    [_searchfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _cancelbutton=[[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 36, 50, 30)];
    
    [_cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
    
    _cancelbutton.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18];
    
    [_cancelbutton addTarget:self action:@selector(cancelsearch) forControlEvents:UIControlEventTouchUpInside];
    
    [_cancelbutton setTitleColor:[UIColor systembluercolor] forState:UIControlStateNormal];
    
    [self addSubview:_tipslabel];
    
    [self addSubview:_searchfield];
    
    return self;

}


-(void)cancelsearch{
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    [_cancelbutton removeFromSuperview];
    
    [_searchfield resignFirstResponder];
    
    [_parentcontroller.searchview removeFromSuperview];

    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         _parentcontroller.closebutton.alpha=1;
                         _searchfield.frame=CGRectMake(20,110, size.width-40, 35);
                         _backgroundImage.frame=CGRectMake(0,-size.height*3/4, size.width, size.height);
                         _tipslabel.alpha=1;
                         _parentcontroller.searchview.alpha=0;
                     }
                     completion:nil
     ];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    [self addSubview:_cancelbutton];
    
    [_parentcontroller.view addSubview:_parentcontroller.searchview];
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         _parentcontroller.closebutton.alpha=0;
                         _searchfield.frame=CGRectMake(20, 35, [UIScreen mainScreen].bounds.size.width-100, 35);
                         _backgroundImage.frame=CGRectMake(0,-[UIScreen mainScreen].bounds.size.height+120,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                         _tipslabel.alpha=0;
                         _parentcontroller.searchview.alpha=1;
                     }
                     completion:nil
     ];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [_searchfield resignFirstResponder];
    return YES;
}

- (void) textFieldDidChange:(UITextField *) TextField{

    [self searchcity];

}


-(void)transfroviewcontroller:(UIViewController *)selfcontroller{
    
      _parentcontroller=selfcontroller;

}

-(void)searchcity{
    
    
    _parentcontroller.searchresultarry= [ZYPinYinSearch searchWithOriginalArray:_parentcontroller.searchsourcearry andSearchText:self.searchfield.text andSearchByPropertyName:@"city"];
    
    [_parentcontroller.searchview reloadData];
    
}


-(void)changebackgroundimg:(CGFloat)transfromvalue{
    
    NSLog(@"  %f", 1+transfromvalue/100);
//    
//    _backgroundImage.layer.transform=CGAffineTransformMakeTranslation(1, 1);
//   // _backgroundImage.layer.transform=CGAffineTransformConcat(1, ;)
//    ;
    
    _backgroundImage.transform=CGAffineTransformMakeScale(1+transfromvalue/5,1);

}
///////////copy









//////

@end
