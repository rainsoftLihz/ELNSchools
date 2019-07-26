//
//  LHZUIbutton.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BTNType) {
    BTNTypeTitleTop,
    BTNTypeTitleDown,
    BTNTypeTitleLeft,
    BTNTypeTitleRight,
};


@interface LHZUIbutton : UIControl

@property(nonatomic,strong) NSString* title;

@property(nonatomic,strong) UIImage* image;

@property(nonatomic,assign) CGFloat space;

-(instancetype)initWith:(UIImage*)image and:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
