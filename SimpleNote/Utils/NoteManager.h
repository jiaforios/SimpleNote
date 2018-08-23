//
//  NoteManager.h
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteManager : NSObject

// 记录本次程序活动期间 已解锁查看的note
+ (void)markUnLockedOnceNoteId:(id)noteId;
+ (NSSet *)unLockedNoteIds;


@end
