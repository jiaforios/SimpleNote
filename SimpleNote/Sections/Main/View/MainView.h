//
//  MainView.h
//  SimpleNote
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 com. All rights reserved.
//

#import "MZView.h"

@protocol MainViewDelegate<NSObject>
@required

- (void)mainViewEdit;

@optional
- (void)mainViewCellSelect:(NSIndexPath *)indexPath dataSource:(NSDictionary *)cellData;

@end


@protocol MainViewDataSource<NSObject>

@optional
-(id)mainViewCellData;
-(id)mainViewSectionData;

@end

@interface MainView : MZView

@property(nonatomic, weak)id<MainViewDelegate>delegate;
@property(nonatomic, weak)id<MainViewDataSource>dataSource;

- (void)setUpData;
- (void)changeLockedCellState:(NSIndexPath *)indexPath;
@end
