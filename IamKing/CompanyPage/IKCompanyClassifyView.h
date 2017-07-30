//
//  IKCompanyClassifyView.h
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"



@protocol IKCompanyClassifyViewDelegate <NSObject>

- (void)selectViewDidSelectIndexPath:(NSIndexPath *)indexPath selectContent:(NSString *)select;

@end


@interface IKCompanyClassifyView : IKView

@property (nonatomic, weak) id<IKCompanyClassifyViewDelegate> delegate;
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;

@end
