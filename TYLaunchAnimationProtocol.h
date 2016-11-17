

#import <UIKit/UIKit.h>

@protocol TYLaunchAnimationProtocol <NSObject>

- (void)configureAnimationWithView:(UIView *)view completion:(void (^)(BOOL finished))completion;

@end
