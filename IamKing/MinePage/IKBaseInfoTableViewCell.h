//
//  IKBaseInfoTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTextField.h"

@protocol IKBaseInfoTableViewCellDelegate <NSObject>

- (void)textFieldBeginEditingNeedAjustkeyBorad:(BOOL)isNeed;

@end


@interface IKBaseInfoTableViewCell : UITableViewCell

@property (nonatomic, strong)IKTextField *textField;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, weak)id<IKBaseInfoTableViewCellDelegate> delegate;

@end
