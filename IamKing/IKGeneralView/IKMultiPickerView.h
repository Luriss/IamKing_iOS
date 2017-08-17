//
//  IKMultiPickerView.h
//  IamKing
//
//  Created by Luris on 2017/8/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MultiResultBlock) (NSString *selectedValue,NSInteger component1,NSInteger component2,NSInteger component3);

@interface IKMultiPickerView : UIView


// warning * set numberOfComponents before set dataSource
@property (nonatomic, assign)NSInteger   numberOfComponents;

// warning * set numberOfComponents before set dataSource
@property (nonatomic, strong)NSArray    *dataSource;

@property (nonatomic, strong)NSArray    *dataSource2;

@property (nonatomic, strong)NSArray    *dataSource3;

- (void)showWithSelectedResultBlock:(MultiResultBlock)resultBlock;




@end
