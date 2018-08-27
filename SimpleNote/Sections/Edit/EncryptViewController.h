//
//  EncryptViewController.h
//  SimpleNote
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 com. All rights reserved.
//

#import "MZBaseViewController.h"


@interface EncryptViewController : MZBaseViewController

@property(nonatomic, copy) void(^eventClourse)(NSString *,NSString *,NSString *);
@property(nonatomic, copy)NSString *pwd;
@property(nonatomic, copy)NSString *locktype;
@property(nonatomic, copy)NSString *lockTips;


@end
