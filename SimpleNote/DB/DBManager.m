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
static sqlite3 *db;

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

- (void)openDB{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
   NSString *sqlPath =  [path stringByAppendingPathComponent:@"note.sqlite"];
    int result  = sqlite3_open(sqlPath.UTF8String, &db);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
    }
}

- (void)createTableName:(NSString *)tableName{
    NSString *sqlStr = @"create table is not exists 'notes'('noteId' integer primary key autoincrement not null,'imgCount' integer,'level' interger,'soundTime' double,'remind' boolean,'lock' boolean,'expire' boolead,'content' text,'dateStr' text,'remindDateStr' text,'lockTitle' text,'lockPwd' text,'lockType' text,'noteType' text,'noteClass' text,'imgUrl' text,'imgSmallUrl' text)";
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
}

@end


