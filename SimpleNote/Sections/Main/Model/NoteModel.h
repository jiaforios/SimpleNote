//
//  NoteModel.h
//  SimpleNote
//
//  Created by admin on 2018/8/21.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataProtocol.h"


@interface NoteModel : NSObject

@property(nonatomic, assign) NSInteger noteId;
@property(nonatomic, assign) NSInteger imgCount; // 图片个数
@property(nonatomic, assign) NSInteger level;
@property(nonatomic, assign) double soundTime; // 时长
@property(nonatomic, assign, getter = isRemind) BOOL remind;
@property(nonatomic, assign, getter = isLock) BOOL lock;
@property(nonatomic, assign, getter = isExpired) BOOL expire; // 过期

@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *dateStr;
@property(nonatomic, copy) NSString *remindDateStr;
@property(nonatomic, copy) NSString *lockTitle;
@property(nonatomic, copy) NSString *lockPwd;
@property(nonatomic, copy) NSString *lockType;
@property(nonatomic, copy) NSString *noteType; // 0： 文字 1：图片，2：语音
@property(nonatomic, copy) NSString *noteClass;
@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, copy) NSString *imgSmallUrl;
@property(nonatomic, copy) NSString *soundUrl;

+ (NSArray<NoteModel*>*)fetchAllModel;
- (void)save;


@end
