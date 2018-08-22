//
//  DBManager.m
//  SimpleNote
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 com. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>

static DBManager *_manager;

@implementation DBManager

+ (void)initialize{
    [DBManager shareManager];
}

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[DBManager alloc] init];
    });
    
    return _manager;
}

- (instancetype)alloc{
    if (!_manager) {
        return [DBManager shareManager];
    }
    return  _manager;
}

- (instancetype)init{
    if (self = [super init]) {
        // 初始化数据库
        
        
    }
    return  self;
}



@end
