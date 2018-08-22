//
//  UIFont+FontType.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import "UIFont+FontType.h"
#import <objc/runtime.h>

@implementation UIFont (FontType)
//+ (void)load{
//    [super load];
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method oldMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
//        Method newMethod = class_getClassMethod([self class], @selector(jl_changeNameFontOfSize:));
//
//        Method oldMethod1 = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
//        Method newMethod2 = class_getClassMethod([self class], @selector(jl_changeNameBoldFontOfSize:));
//
//        method_exchangeImplementations(oldMethod, newMethod);
//        method_exchangeImplementations(oldMethod1, newMethod2);
//    });
//}
//+ (UIFont *)jl_changeNameFontOfSize:(CGFloat)fontSize{
//    UIFont *font = [UIFont fontWithName:@"STHeitiK-Light" size:fontSize];
//    if (!font)return [self jl_changeNameFontOfSize:fontSize];
//    return font;
//}
//+ (UIFont *)jl_changeNameBoldFontOfSize:(CGFloat)fontSize{
//    UIFont *font = [UIFont fontWithName:@"STHeitiK-Light" size:fontSize];
//    if (!font)return [self jl_changeNameBoldFontOfSize:fontSize];
//    return font;
//}

@end
