

#import <UIKit/UIKit.h>
#import "TYLaunchAnimationProtocol.h"

@interface UIView (TYLaunchAnimation)

- (void)showInWindowWithAnimation:(id<TYLaunchAnimationProtocol>)animation completion:(void (^)(BOOL finished))completion;

- (void)showInView:(UIView *)superView animation:(id<TYLaunchAnimationProtocol>)animation completion:(void (^)(BOOL finished))completion;

@end
