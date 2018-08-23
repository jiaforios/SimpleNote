//
//  NoteManager.m
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import "NoteManager.h"
static NSMutableSet * _lockedOnceNoteIdSet;

@implementation NoteManager

+(void)initialize{
    _lockedOnceNoteIdSet = [NSMutableSet new];
}

+ (void)markUnLockedOnceNoteId:(id)noteId{
    [_lockedOnceNoteIdSet addObject:noteId];

}

+ (NSSet *)unLockedNoteIds{
    return [_lockedOnceNoteIdSet copy];
}

+(void)clearAllIds{
    [_lockedOnceNoteIdSet removeAllObjects];
}

@end
