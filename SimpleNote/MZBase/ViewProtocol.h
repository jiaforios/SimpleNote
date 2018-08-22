//
//  ViewProtocol.h
//  SimpleNote
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewProtocol <NSObject>

@optional
- (id)viewData; // 数据协议
- (void)viewAction; // 事件协议

@end

