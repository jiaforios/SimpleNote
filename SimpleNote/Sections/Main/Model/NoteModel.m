//
//  NoteModel.m
//  SimpleNote
//
//  Created by admin on 2018/8/21.
//  Copyright © 2018年 com. All rights reserved.
//

#import "NoteModel.h"
#import "NoteManager.h"


@implementation NoteModel
{
    id<DataProtocol> _delegate;
}

-(instancetype)init{
    if (self = [super init]) {
        _imgCount = 0;
        _level = 0;
        _soundTime = 0;
        _remind = NO;
        _lock = NO;
        _expire = NO;
        _dateStr =  [Utils currentDateStr];
        _remindDateStr = @"";
        _lockTitle = @"";
        _lockPwd = @"";
        _lockType  = EntryptTypeNone;
        _noteType = TextNoteType;
        _noteClass = @"0";
        _imgUrl = @"";
        _imgSmallUrl = @"";
        _remindTips = @"";
        _soundUrl = @"";
        [self delegate:[DBManager shareManager]];
    }
    return  self;
}

+ (NSArray<NoteModel *> *)fetchAllModel{
    
   // 拿到的数据 加工处理，争取不在cell 层处理数据显示逻辑
        
    NSArray <NoteModel *> *arr = [[DBManager shareManager] fetchAllModel];
// 如果需要在本次 程序活动时，一致保持解锁状态，则打开这段代码,同时关闭 [NoteManager clearAllIds]
    [arr enumerateObjectsUsingBlock:^(NoteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[NoteManager unLockedNoteIds] containsObject:@(obj.noteId)]) {
            obj.lock = NO;
        }
    }];
    
//    [NoteManager clearAllIds];
    
    return arr;
}


-(void)delegate:(id<DataProtocol>)obj{
    _delegate = obj;
}

-(void)save{
    NSString *sqlStr = [NSString stringWithFormat:@"insert into 'notes'('imgCount','level','soundTime','remind','lock','expire','content','dateStr','remindDateStr','lockTitle','lockPwd','lockType','noteType','noteClass','imgUrl','imgSmallUrl','soundUrl','remindTips')values('%ld','%ld','%f','%d','%d','%d','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",(long)self.imgCount,(long)self.level,self.soundTime,self.remind,self.lock,self.expire,self.content,self.dateStr,self.remindDateStr,self.lockTitle,self.lockPwd,self.lockType,self.noteType,self.noteClass,self.imgUrl,self.imgSmallUrl,self.soundUrl,self.remindTips];
    
    if ([_delegate respondsToSelector:@selector(exeWithSqlStr:)] && [_delegate conformsToProtocol:@protocol(DataProtocol)]) {
        [_delegate exeWithSqlStr:sqlStr];
    }else{
        NSLog(@"未实现数据存储");
    }
}


@end
