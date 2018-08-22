//
//  MZView.h
//  SimpleNote
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewProtocol.h"

@interface MZView : UIView

@property(nonatomic, weak)id<ViewProtocol>baseDelegate;


@end
