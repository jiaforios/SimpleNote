//
//  UIFont+FontType.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import "UIFont+FontType.h"
#import <objc/runtime.h>
static NSString *const FONT1 = @"Jyinbikai";
static NSString *const FONT3 = @"FZKATJW--GB1-0"; // 默认显示
static NSString *const FONT4 = @"Li-Xuke-Comic-Font";
static NSString *const FONT5 = @"STHeitiK-Light";

@implementation UIFont (FontType)
+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
        Method newMethod = class_getClassMethod([self class], @selector(jl_changeNameFontOfSize:));

        Method oldMethod1 = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
        Method newMethod2 = class_getClassMethod([self class], @selector(jl_changeNameBoldFontOfSize:));

        method_exchangeImplementations(oldMethod, newMethod);
        method_exchangeImplementations(oldMethod1, newMethod2);
    });
}

+ (UIFont *)jl_changeNameFontOfSize:(CGFloat)fontSize{
    
    NSString *fontName = [Utils userDefaultGet:@"fontType"];
    fontName = @"ChalkboardSE-Light";
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font)return [self jl_changeNameFontOfSize:fontSize];
    return font;
}
+ (UIFont *)jl_changeNameBoldFontOfSize:(CGFloat)fontSize{
    NSString *fontName = [Utils userDefaultGet:@"fontType"];
    fontName = @"ChalkboardSE-Light";
//STHeitiSC-Light
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font)return [self jl_changeNameBoldFontOfSize:fontSize];
    return font;
}


//    迷你简硬笔楷书 ：Jyinbikai,少女： DFGirl-W6-WIN-BF，FZKaTong-M19S：FZKATJW--GB1-0，Li Xuke Comic Font：Li-Xuke-Comic-Font
@end
