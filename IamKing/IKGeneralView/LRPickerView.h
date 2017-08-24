//
//  LRPickerView.h
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

// 只有两列或一列


typedef void(^ResultBlock) (NSString *value1,NSString *value2);

@interface LRPickerView : UIView

@property (nonatomic, strong)NSArray    *dataSource; // 两列或一列

- (void)showWithSelectedResultBlock:(ResultBlock)resultBlock;

- (void)defaultSelectRow:(NSInteger)selectedRow inComponent:(NSInteger)component animated:(BOOL)animated;

@end
