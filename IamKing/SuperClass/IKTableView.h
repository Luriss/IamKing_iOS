//
//  IKTableView.h
//  IamKing
//
//  Created by Luris on 2017/7/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IKTableViewScrollState) {
    IKTableViewScrollStateNormal = 0,          /**  正常状态 */
    IKTableViewScrollStateUpglide,             /** 上滑 */
    IKTableViewScrollStateTop                  /** 顶端 */
};


@interface IKTableView : UITableView

@property(nonatomic,assign)IKTableViewScrollState scrollState;

@end
