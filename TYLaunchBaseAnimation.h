
#import <Foundation/Foundation.h>
#import "TYLaunchAnimationProtocol.h"

@interface TYLaunchBaseAnimation : NSObject<TYLaunchAnimationProtocol>

@property (nonatomic, assign) CGFloat duration;// duration time
@property (nonatomic, assign) CGFloat delay;   // delay hide
@property (nonatomic, assign) UIViewAnimationOptions options;

@end
