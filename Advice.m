//
//  Advice.m
//  Mofish
//
//  Created by zhouli on 16/8/19.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "Advice.h"
#import "TitleBar.h"
#import "Utils.h"
#import "MBProgressHUD.h"

#define TIPS  @"您的宝贵意见与建议将是我们前进的巨大动力"
#define PLACE @"200字以内哦"

@interface Advice ()<TitleBarDelegate,UITextViewDelegate>
@property(nonatomic,strong) UITextView *field;
@property(nonatomic,strong) UILabel *placeholder;
@property(nonatomic,copy) NSString *textinput;
@property(nonatomic,strong) UILabel *numlabel;
@property(nonatomic,copy) NSString *numstring;
@end

@implementation Advice

- (void)viewDidLoad {
    [super viewDidLoad];

    _numstring=@"0/200";
    
    self.view.backgroundColor=[UIColor graybackground];
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    TitleBar *titlebar=[[TitleBar alloc] inittitlebar:@"意见反馈" :NO :YES];
    
    titlebar.delegate=self;
    
    _field=[[UITextView alloc] initWithFrame:CGRectMake(12, 80, size.width-24, 155)];
    
    _field.backgroundColor=[UIColor whiteColor];
    
    _field.layer.cornerRadius=size.width/60;
    
    _field.font = [UIFont systemFontOfSize:17];
    
    _field.delegate=self;

    _field.returnKeyType = UIReturnKeyDefault;

    CGSize placeholdersize=[PLACE boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    
    _placeholder=[[UILabel alloc] initWithFrame:CGRectMake(16, 87, placeholdersize.width, placeholdersize.height)];
    
    _placeholder.text=PLACE;
    
    _placeholder.font=[UIFont systemFontOfSize:17];
    
    _placeholder.textColor=[UIColor graytext];
    
    CGSize numlabelsize=[@"200/200" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    
    _numlabel=[[UILabel alloc] initWithFrame:CGRectMake(size.width-20-numlabelsize.width, 235-numlabelsize.height, numlabelsize.width, numlabelsize.height)];
    
    _numlabel.text=_numstring;
    
    _numlabel.font=[UIFont systemFontOfSize:14];
    
    _numlabel.textColor=[UIColor graytext];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(size.width-100,250,88,40);
    
    button.backgroundColor=[UIColor navycolor:0.9];
    
    [button addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"提交" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.layer.cornerRadius=4;
    
    
    CGSize tipssize=[TIPS boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    UILabel *tips=[[UILabel alloc] init];
    
    tips.frame=CGRectMake((size.width-tipssize.width)/2,size.height-80, tipssize.width, tipssize.height);
    
    tips.text=TIPS;
    
    tips.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    
    tips.textColor=[UIColor graytext];
   
    [self.view addSubview:titlebar];
    
    [self.view addSubview:_field];
    
    [self.view addSubview:button];
    
    [self.view addSubview:_placeholder];
    
    [self.view addSubview:_numlabel];
    
    [self.view addSubview:tips];

}

-(void)commit{
    
    if ( _textinput.length==0) {
        
        [self showtoast:NO];
    }else {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showtoast:YES];
        });
    
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    _textinput =  textView.text;
    
    NSInteger length=textView.text.length;
    
    NSString *stringlength = [NSString stringWithFormat:@"%d",length];
    
    _numstring= [stringlength stringByAppendingString:@"/200"];
    
    _numlabel.text=_numstring;
    
    if(textView.text.length == 0) {
        _placeholder.text = PLACE;
    }else{
        _placeholder.text = @"";
    }
}

-(void)back{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length>199) {
        return NO;
    }else{
        return YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)showtoast:(BOOL)commit{
    
    MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIImage *image = [[UIImage imageNamed:@"select_city_toast.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    hud.opacity=0.6;
    
    hud.customView.tintColor=[UIColor whiteColor];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    NSString *text=commit?@"提交成功！":@"请输入您的宝贵意见再提交哦";
    
    hud.labelText= NSLocalizedString(text, @"HUD completed title");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
    
    return;
    
}


@end
