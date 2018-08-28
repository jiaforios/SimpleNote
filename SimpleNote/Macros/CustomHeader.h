//
//  CustomHeader.h
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef CustomHeader_h
#define CustomHeader_h

// app 版本 build 号 APP名称
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

// 设备相关
#define MZBounds [[UIScreen mainScreen] bounds]
#define MZWIDTH [[UIScreen mainScreen] bounds].size.width
#define MZHEIGHT [[UIScreen mainScreen]bounds].size.height
#define WAuto(x) ((HYWIDTH * x)/375.)
#define HAuto(x) ((HYHEIGHT * x)/667.)

#define kNavBarHeight 64

// 颜色控制
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define TextColor RGB(110,110,110)
#define DetailTextColor RGB(150,150,150)
#define AppColor RGB(222,93,0)
// 多语言
#define LocalizedString(key) ([[[NSLocale preferredLanguages] objectAtIndex:0] rangeOfString:@"zh-Hans"].length)? ([[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil]):([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil])

#define BmobKey  @"314d88f0bfea4a5c7cf446fa797c41f7"

#endif
