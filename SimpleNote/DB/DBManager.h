//
//  DBManager.h
//  SimpleNote
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteModel.h"

@interface DBManager : NSObject<DataProtocol>
+ (instancetype)shareManager;

- (void)saveModel;
- (void)deleteModel;
- (void)updateModel;
- (void)fetchModel;
- (NSArray <NoteModel*>*)fetchAllModel;

@end
