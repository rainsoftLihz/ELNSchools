//
//  PSInPutCodeView.h
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PSInPutCodeViewDelegate <NSObject>
@optional
-(void)codeStr:(NSString*)codeStr;
@end

typedef void(^PSCodeViewBlock)(NSString*);

@interface PSInPutCodeView : UIView
-(instancetype)initWithFrame:(CGRect)frame andCount:(NSInteger)count andSpace:(CGFloat)space codeBlock:(PSCodeViewBlock)codeBlock;
@end

NS_ASSUME_NONNULL_END
