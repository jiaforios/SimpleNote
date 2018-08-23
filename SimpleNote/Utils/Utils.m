//
//  Utils.m
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)currentDateStr{
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"dd/MM yyyy HH:mm:ss";
    return [format stringFromDate:[NSDate date]];
}

@end
