//
//  Utils.h
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *)currentDateStr;
+ (NSString *)currentDateStrForSoundPathName;
+ (NSMutableParagraphStyle *)paraStyle;
+ (CGFloat)widthOfContent:(NSString *)content;
@end
