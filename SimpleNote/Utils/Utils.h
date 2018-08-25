//
//  Utils.h
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *)currentDateStr;
+ (NSString *)currentDateStrForSoundPathName;
+ (NSMutableParagraphStyle *)paraStyle;
+ (CGFloat)widthOfContent:(NSString *)content;
+ (NSDate *)dateFromStr:(NSString *)str;
+ (NSString *)strFromDate:(NSDate*)date;
// 通知添加
+ (void)localNotification:(NSString *)notifContent notiDate:(NSString *)dateStr;

// 取消指定通知
+ (void)cancelLocalNotificationWithId:(NSString *)notifiId;

// 取消全部通知
+ (void)cancelAllLocalnotifications;
@end
