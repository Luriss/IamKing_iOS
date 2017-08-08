//
//  IKCompanyTypeView.h
//  IamKing
//
//  Created by Luris on 2017/8/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKCompanyTypeViewDelegate <NSObject>

- (void)selectCompanyTypeViewDidSelectIndexPath:(NSIndexPath *)indexPath selectContent:(NSString *)select;

@end


@interface IKCompanyTypeView : UIView

@property (nonatomic, weak) id<IKCompanyTypeViewDelegate> delegate;
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;

@end
