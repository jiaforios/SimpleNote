//
//  DBManager.h
//  SimpleNote
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
+ (instancetype)shareManager;

- (void)saveModel;
- (void)deleteModel;
- (void)updateModel;
- (void)fetchModel;
- (void)fetchAllModel;

@end
