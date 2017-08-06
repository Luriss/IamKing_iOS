//
//  IKMessageViewController.m
//  IamKing
//
//  Created by Luris on 2017/7/29.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKMessageViewController.h"

@interface IKMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)IKTableView      *bgTableView;


@end

@implementation IKMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IKTableView *)bgTableView
{
    if (_bgTableView == nil) {
        _bgTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 1, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 49-64) style:UITableViewStylePlain];
        _bgTableView.backgroundColor = IKGeneralLightGray;
        _bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgTableView.showsVerticalScrollIndicator = YES;
        _bgTableView.showsHorizontalScrollIndicator = NO;
        _bgTableView.delegate = self;
        _bgTableView.dataSource = self;
        _bgTableView.bounces = NO;
    }
    
    return _bgTableView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
