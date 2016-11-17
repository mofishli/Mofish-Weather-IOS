//
//  SunriseAndSunset.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/21.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "SunriseAndSunset.h"

@interface SunriseAndSunset ()

@property (nonatomic, assign) NSDateFormatter *formatter;

@end

@implementation SunriseAndSunset

- (instancetype)init {
    self = [super init];
    if (self) {
        self.formatter            = [NSDateFormatter new];
    }
    return self;
}

- (void)accessUtcSec {

}

@end
