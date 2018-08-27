//
//  MZBaseViewController.h
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZBaseViewController : UIViewController
// 事件处理弹框
- (void)showAlertViewTitle:(NSString *)title message:(NSString *)message sureBlock:(void(^)(void))sBlock;
@end
