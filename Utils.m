//
//  Utils.m
//  Mofish
//
//  Created by zhouli on 16/7/2.
//  Copyright © 2016年 Coca. All rights reserved.
//

#import "Utils.h"
#import "MBProgressHUD.h"


@implementation UIColor(HEX)

+(UIColor *)navycolor:(CGFloat)alpha{

    return ColorFromHex(0x272740, alpha);
}

+(UIColor *)blackcolor:(CGFloat)alpha{
    
    return ColorFromHex(0x000000, alpha);
}

+(UIColor *)graybackground{

    return ColorFromHex(0xf0f0f0, 1);

}

+(UIColor *)graytext{
    
    return ColorFromHex(0x999999, 1);
    
}


+(UIColor *)bordercolor{
    
    return ColorFromHex(0x555564, 0.8);
    
}

+(UIColor *)blacktext{

    return ColorFromHex(0x333, 0.8);

}

+(UIColor *)downloadcolor{
    
    return ColorFromHex(0xffffff, 0.4);
    
}


+(UIColor *)systembluercolor{
    
    return ColorFromHex(0x208CD0, 1);
    
}

+(UIColor *)toastcolor{
    
    return ColorFromHex(0x000000, 0.3);
    
}

+(UIColor *)greendownload{
    
    return ColorFromHex(0x468C0C, 0.8);
    
}

+(UIColor *)textcolor{
    
    return ColorFromHex(0x222, 1);
  
}

+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end

@implementation Utils

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+(NSString *)getcodepic:(NSString *)code{
    
    NSString *pic=[WeatherCodePic getcodepic:code];

    return pic;
}

+(void)requestCity{
    
  [FetchNet requestCity];
    
}

+(void)requestWeather :(NSInteger)index:(void (^)())block{
    
 
    [FetchNet requestWeather:index:block];

}



+(void)showToast:(UIView *)view :(NSString *)text
{
    
    MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.opacity=0.6;
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText= NSLocalizedString(text, @"HUD completed title");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
    
}


@end
