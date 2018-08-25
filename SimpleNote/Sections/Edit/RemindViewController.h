//
//  RemindViewController.h
//  SimpleNote
//
//  Created by admin on 2018/8/25.
//  Copyright © 2018年 com. All rights reserved.
//

#import "MZBaseViewController.h"

@interface RemindViewController : MZBaseViewController

@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)void(^eventClourse)(NSString *tipContent,NSDate *remindDate);
@end
