//
//  IKPickerView.h
//  IamKing
//
//  Created by Luris on 2017/8/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ResultBlock) (NSString *selectedValue);

@interface IKPickerView : UIView

// warning * set numberOfComponents before set dataSource
@property (nonatomic, strong)NSArray    *dataSource;

// warning * set defaultSelectedRow after set dataSource
@property (nonatomic, assign)NSInteger   defaultSelectedRow;

- (void)showWithSelectedResultBlock:(ResultBlock)resultBlock;

@end
