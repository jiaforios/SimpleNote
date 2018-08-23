//
//  DataProtocol.h
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataProtocol <NSObject>
@optional
- (void)saveWithSqlStr:(NSString *)sqlStr;

@end
