//
//  APPentryptViewController.h
//  SimpleNote
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 com. All rights reserved.
//

#import "MZBaseViewController.h"

@interface APPentryptViewController : MZBaseViewController
@property(nonatomic, copy) void(^eventClourse)(NSString *,NSString *);
@property(nonatomic, copy)NSString *pwd;
@property(nonatomic, copy)NSString *locktype;
@end
