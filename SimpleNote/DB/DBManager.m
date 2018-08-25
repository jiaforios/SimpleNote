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
        [self openDB];
        [self createTableName:nil];
        
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
    NSString *sqlStr = @"create table if not exists 'notes'('noteId' integer primary key autoincrement not null,'imgCount' integer default 0,'level' interger default 0,'soundTime' double default 0,'remind' boolean default 0,'lock' boolean default 0,'expire' boolead default 0,'content' text default '','dateStr' text default '','remindDateStr' text default '','lockTitle' text default '','lockPwd' text default '','lockType' text default '0','noteType' text default '0','noteClass' text default '0','imgUrl' text default '','imgSmallUrl' text default '',soundUrl text default '')";
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}

#pragma mark -- DataProtocol
-(void)exeWithSqlStr:(NSString *)sqlStr{
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"操作成功");
    }else{
        NSLog(@"操作失败");
    }
}

-(void)saveModel{
    NSString *sqlStr = @"insert into 'notes'('content','dateStr')values('hello world','2018-08-22 17:16:44')";
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
}

- (NSArray*) fetchAllModel{
    NSString *sqlStr = @"select *from 'notes'";
    sqlite3_stmt *smt = nil;
    sqlite3_prepare(db, sqlStr.UTF8String, -1, &smt, nil);
    NSMutableArray *models = [NSMutableArray new];
    while (sqlite3_step(smt) == SQLITE_ROW) {
        NoteModel *model = [NoteModel new];
        
        int noteId = sqlite3_column_int(smt, 0);
        int imgCount = sqlite3_column_int(smt, 1);
        int level = sqlite3_column_int(smt, 2);
        double soundTime = sqlite3_column_double(smt,3);
        BOOL remind = sqlite3_column_int(smt, 4);
        BOOL lock = sqlite3_column_int(smt, 5);
        BOOL expire = sqlite3_column_int(smt, 6);
        NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 7)] ;
        NSString *dateStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 8)] ;
        NSString *remindDateStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 9)] ;
        NSString *lockTitle = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 10)] ;
        NSString *lockPwd = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 11)] ;
        NSString *lockType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 12)] ;
        NSString *noteType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 13)] ;
        NSString *noteClass = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 14)] ;
        NSString *imgUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 15)] ;
        NSString *imgSmallUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 16)] ;
        NSString *soundUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(smt, 17)] ;

        model.noteId = noteId;
        model.imgCount = imgCount;
        model.level = level;
        model.soundTime = soundTime;
        model.remind = remind;
        
        model.lock = lock;
        model.expire = expire;
        model.content = content;
        model.dateStr = dateStr;
        model.remindDateStr = remindDateStr;
        model.lockTitle = lockTitle;
        
        model.lockPwd = lockPwd;
        model.lockType = lockType;
        model.noteType = noteType;
        model.noteClass = noteClass;
        model.imgUrl = imgUrl;
        model.imgSmallUrl = imgSmallUrl;
        model.soundUrl = soundUrl;
        
        [models addObject:model];
    }
    
    return [models copy];
    
}

- (void)clearAllNotes{
    NSString *sqlStr = @"delete from 'notes'";
    char *error = nil;
    sqlite3_exec(db, sqlStr.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"操作成功");
    }else{
        NSLog(@"操作失败");
    }
}

@end


