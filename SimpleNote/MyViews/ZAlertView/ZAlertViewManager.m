//
//  ZAlertViewManager.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ZAlertViewManager.h"

@implementation ZAlertViewManager

+ (ZAlertViewManager *)shareManager
{
    static ZAlertViewManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[ZAlertViewManager alloc]init];
        shareManager.alertView = [[ZAlertView alloc] init];
    });
    return shareManager;
}

- (void)showWithType:(AlertViewType)type
{
    [self.alertView topAlertViewTypewWithType:type];
    [self.alertView show];
}

- (void)dismissWithTime:(NSInteger)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.alertView dismiss];
    });
}

- (void)showContent:(NSString *)content type:(AlertViewType)type{
    [[self class ] cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissView) object:nil];
    [self.alertView topAlertViewContent:content Type:type];
    [self.alertView show];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2];
}
- (void)test_showConnectType:(NSString *)content{
    if (DEBUG) {
        [[self class ] cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissView) object:nil];
        [self.alertView test_topAlertViewContent:content Type:AlertViewTypeSuccess];
        [self.alertView show];
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2];
    }
}

- (void)dismissView{
    [self.alertView dismiss];
}

@end
