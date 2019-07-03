//
//  PSLoginBaseView.h
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextBack)(NSString*);

@interface PSLoginBaseView : UIView

-(instancetype)initWithFrame:(CGRect)frame andIcon:(NSString*)iconName andPlacehold:(NSString*)placeholdStr andBlock:(TextBack)block;

@end

NS_ASSUME_NONNULL_END
