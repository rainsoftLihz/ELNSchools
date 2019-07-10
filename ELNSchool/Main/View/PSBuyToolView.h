//
//  PSBuyToolView.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShowBuyBlock)(void);

@interface PSBuyToolView : UIView

-(instancetype)initWithFrame:(CGRect)frame andShowBuyAction:(ShowBuyBlock)block;

@end

NS_ASSUME_NONNULL_END
