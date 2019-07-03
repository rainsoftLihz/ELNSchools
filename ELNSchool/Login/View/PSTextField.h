//
//  PSTextField.h
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PSTextFieldDelegate<UITextFieldDelegate>
@optional
- (void)textFeildDeleteBackward:(UITextField *)textField;
@end

@interface PSTextField : UITextField
@property (nonatomic, weak) id <PSTextFieldDelegate> xmDelegate;
@end

NS_ASSUME_NONNULL_END
