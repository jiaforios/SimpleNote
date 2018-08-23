//
//  NoteModel.m
//  SimpleNote
//
//  Created by admin on 2018/8/21.
//  Copyright © 2018年 com. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel

+ (NSArray<NoteModel *> *)fetchAllModel{
    return [[DBManager shareManager] fetchAllModel];
}
@end
