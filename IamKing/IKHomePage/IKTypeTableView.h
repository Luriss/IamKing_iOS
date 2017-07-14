//
//  IKTypeTableView.h
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"


@protocol IKTypeTableViewDelegate <NSObject>

- (void)typeTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface IKTypeTableView : IKView

@property (nonatomic, weak) id<IKTypeTableViewDelegate> delegate;

@end
