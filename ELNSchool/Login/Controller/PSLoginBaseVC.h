//
//  PSLoginBaseVC.h
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSLoginAPI.h"
#import "PSLoginManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSLoginBaseVC : UIViewController

-(CGFloat)contentSpace;

//返回按钮
-(void)configBackItem;

//下一步
@property(nonatomic,strong)UIButton* nextBtn;
-(void)configBottomActionBtnWithTitle:(NSString*)title;
-(void)nextBtnClick;

//标题
-(void)configHeaderWith:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
