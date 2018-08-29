//
//  Utils.m
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import "Utils.h"

static NSMutableSet *weakViews;



@implementation Utils

+(void)initialize{
    weakViews = [NSMutableSet new];
}

+ (NSString *)currentDateStr{
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"yyyy-MM-dd hh:mm";
    return [format stringFromDate:[NSDate date]];
}

+ (NSString *)currentDateStrForSoundPathName{
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"yyyyMMddHHmmss";
    return [format stringFromDate:[NSDate date]];
}

+(NSMutableParagraphStyle *)paraStyle{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 8.;// 行间距
    paragraphStyle.lineHeightMultiple = 1.3;// 行高倍数（1.5倍行高）
    paragraphStyle.firstLineHeadIndent = 10.0f;//首行缩进
    paragraphStyle.minimumLineHeight = 10;//最低行高
    paragraphStyle.alignment = NSTextAlignmentLeft;// 对齐方式
    paragraphStyle.defaultTabInterval = 144;// 默认Tab 宽度
    paragraphStyle.headIndent = 10;// 起始 x位置
    return paragraphStyle;
}

+ (NSDate *)dateFromStr:(NSString *)str{
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"yyyy-MM-dd HH:mm";
    return [format dateFromString:str];
}

+ (NSString *)strFromDate:(NSDate*)date{
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"yyyy-MM-dd HH:mm";
    return [format stringFromDate:date];
}


+ (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}
//日期对比
+ (int)compareTodaywithRemindTime:(NSDate *)remindTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDayStr = [dateFormatter stringFromDate:[self getCurrentTime]];
    NSString *BaseDayStr = [dateFormatter stringFromDate:remindTime];
    NSDate *dateA = [dateFormatter dateFromString:currentDayStr];
    NSDate *dateB = [dateFormatter dateFromString:BaseDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

+ (CGFloat)widthOfContent:(NSString *)content{
    CGSize size = [content boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size.width;
}

+ (void)localNotification:(NSString *)notifContent notiDate:(NSString *)dateStr{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = notifContent;
    localNotification.fireDate = [self dateFromStr:dateStr];
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 以触发日期为通知标识
    NSDictionary *info = @{@"notifId":dateStr};
    localNotification.userInfo = info;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

+ (void)cancelLocalNotificationWithDate:(NSString *)notifiDate{
    for (UILocalNotification *nofi in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if ([[nofi.userInfo objectForKey:@"notifId"] isEqualToString:notifiDate]) {
            [[UIApplication sharedApplication] cancelLocalNotification:nofi];
            break;
        }
    }
}


+ (void)cancelAllLocalnotifications{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+(void)cancelExpireNotification{
    
    for (UILocalNotification *nofi in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if ([self compareTodaywithRemindTime:[self dateFromStr:[nofi.userInfo objectForKey:@"notifId"]]] == 1) {
            NSLog(@"过期通知，移除");
            [[UIApplication sharedApplication] cancelLocalNotification:nofi];
        }
    }
}


//判断颜色是不是亮色
+ (BOOL) isLightColor:(UIColor*)clr {
    CGFloat components[3];
    [self getRGBComponents:components forColor:clr];
    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    CGFloat num = components[0] + components[1] + components[2];
    if(num < 382)
        return NO;
    else
        return YES;
}



//获取RGB值
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}



+(id)userDefaultGet:(NSString *)key{
    return [[self user] objectForKey:key];
}

+ (void)userDefaultSet:(id)obj key:(NSString *)key{
    [[self user] setObject:obj forKey:key];
    [[self user] synchronize];
}

+ (NSUserDefaults *)user{
    return [NSUserDefaults standardUserDefaults];
}


@end
