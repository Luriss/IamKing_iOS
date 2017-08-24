//
//  IKChooseCompanyTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTextField.h"

@protocol IKChooseCompanyCellDelegate <NSObject>

- (void)textFieldBeginEditing;
- (void)textFieldEditingChangedWithText:(NSString *)text;
- (void)companyTextFieldEndEditingWithText:(NSString *)text;

- (void)showCompanyListView:(BOOL )isShow;

@end


@interface IKChooseCompanyTableViewCell : UITableViewCell

@property (nonatomic, strong)IKTextField *textField;
@property (nonatomic, weak)id<IKChooseCompanyCellDelegate> delegate;

@end
