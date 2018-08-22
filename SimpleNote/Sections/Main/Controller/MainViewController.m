//
//  MainViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
// 列表式 界面 ，悬空 按钮

#import "MainViewController.h"
#import "NoteViewController.h"
#import "SetViewController.h"

#import "TextCell.h"
#import "ImgCell.h"
#import "SoundCell.h"

#import "MainView.h"

static NSString *textCellIdentifier = @"textCell";
static NSString *imgCellIdentifier = @"imgCell";
static NSString *soundCellIdentifier = @"soundCell";

@interface MainViewController ()<MainViewDelegate,MainViewDataSource>
@property(nonatomic, strong)UIButton *setButton;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithCustomView:self.setButton];
    self.navigationItem.rightBarButtonItem = set;
    
    MainView *mv = [[MainView alloc] initWithFrame:self.view.bounds];
    mv.delegate = self;
    mv.dataSource = self;
    [mv setUpData];
    
    self.view = mv;
    
}
- (UIButton *)setButton{
    if (!_setButton) {
        _setButton = [[UIButton alloc] init];
        _setButton.frame = CGRectMake(0, 0, 44,44);
        [_setButton setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
        [_setButton addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setButton;
}
/*
 设置
 */
- (void)setAction{
    
    [self.navigationController pushViewController:[SetViewController new] animated:YES];
}

#pragma mark -- ViewProtocol --

- (void)mainViewEdit{
    [self.navigationController pushViewController:[NoteViewController new] animated:YES];
}

- (id)mainViewSectionData{
    
    NSMutableArray *marr = [NSMutableArray new];
    [marr addObject:@"2018-08"];
    [marr addObject:@"2018-07"];
    [marr addObject:@"2018-06"];
    [marr addObject:@"2018-05"];
    [marr addObject:@"2018-04"];
    [marr addObject:@"2018-03"];
    return marr;
}

-(id)mainViewCellData{
    NSMutableArray *dataArr = [NSMutableArray new];
    for (int i = 0; i<6; i++) {
        NSMutableArray *marr = [NSMutableArray new];
        for (int i = 0; i< 5; i++) {
            if (i == 0) {
                [marr addObject:@"明天上午九点去深南花园约同学吃饭，带上手机钥匙，钱包。"];
            }else
                if (i == 2) {
                    [marr addObject:@"今天是个好日子，明天上午九点去深南花园约同学吃饭，带上手机钥匙，钱包。明天上午九点去深南花园约同学吃饭，带上手机钥匙，钱包。"];
                }else
                    if (i == 3) {
                        [marr addObject:@"马上要房价了，今天是个好日子"];
                    }else{
                        [marr addObject:@"马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子"];
                    }
        }
        [dataArr addObject:marr];
    }
    
    return dataArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
