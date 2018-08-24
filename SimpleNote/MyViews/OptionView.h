//
//  OptionView.h
//  SimpleNote
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OptionViewTypeFingure,
    OptionViewTypePwd,
    OptionViewTypeSound,
} OptionViewType;

@interface OptionView : UIView
@property(nonatomic, assign, getter=isSelected)BOOL select;
@property(nonatomic, copy,readonly)NSString *pwdContent;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title type:(OptionViewType)type;


@end
