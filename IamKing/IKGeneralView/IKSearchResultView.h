//
//  IKSearchResultView.h
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKJobInfoModel.h"
#import "IKCompanyInfoModel.h"

#import "IKSelectView.h"

typedef NS_ENUM(NSInteger, IKSelectedType) {
    IKSelectedTypeJob = 0,                  /** 职位 */
    IKSelectedTypeCompany,                  /** 公司 */
};


@protocol IKSearchResultViewDelegate <NSObject>

- (void)searchResultViewSelectType:(IKSelectedType )type;
- (void)searchResultViewClickHideKeyBorad;
- (void)searchResultViewdidSelectJobWithModel:(IKJobInfoModel *)model;
- (void)searchResultViewdidSelectCompanyWithModel:(IKCompanyInfoModel *)model;
- (void)searchResultViewdidSelectJobType:(IKSelectedSubType )type selectIndex:(NSInteger )index;

@end


@interface IKSearchResultView : UIView
@property (nonatomic,copy)NSArray *jobDataArray;
@property (nonatomic,copy)NSArray *compDataArray;

@property (nonatomic, weak) id<IKSearchResultViewDelegate> delegate;

- (void)reloadData;
- (void)resetOldSelectedView:(UIView *)newView;

@end
