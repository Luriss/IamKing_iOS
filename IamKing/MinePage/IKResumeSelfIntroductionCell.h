//
//  IKResumeSelfIntroductionCell.h
//  IamKing
//
//  Created by Luris on 2017/8/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKResumeSelfIntroductionCellDelegate <NSObject>

- (void)textViewBeginEditingNeedAjustkeyBorad:(BOOL)isNeed;
- (void)textViewDidEndEditingWithText:(NSString *)text;
- (void)textViewShouldReturnButtonClick;

@end



@interface IKResumeSelfIntroductionCell : UITableViewCell

@property (nonatomic, weak)id<IKResumeSelfIntroductionCellDelegate> delegate;
@property (nonatomic, copy)NSString *textViewText;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)UIColor *textViewTextColor;

@end
