//
//  Utils.m
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)currentDateStr{
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"dd/MM yyyy HH:mm:ss";
    return [format stringFromDate:[NSDate date]];
}

+ (NSString *)currentDateStrForSoundPathName{
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"yyyyMMddHHmmss";
    return [format stringFromDate:[NSDate date]];
}

+(NSMutableParagraphStyle *)paraStyle{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 8.;// 行间距
    paragraphStyle.lineHeightMultiple = 1.3;// 行高倍数（1.5倍行高）
    paragraphStyle.firstLineHeadIndent = 30.0f;//首行缩进
    paragraphStyle.minimumLineHeight = 10;//最低行高
    paragraphStyle.alignment = NSTextAlignmentLeft;// 对齐方式
    paragraphStyle.defaultTabInterval = 144;// 默认Tab 宽度
    paragraphStyle.headIndent = 10;// 起始 x位置
    return paragraphStyle;
}

+ (CGFloat)widthOfContent:(NSString *)content{
    CGSize size = [content boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size.width;
}

@end
