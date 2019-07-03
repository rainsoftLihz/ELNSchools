//
//  PSInPutCodeView.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#import "PSInPutCodeView.h"
#import "PSTextField.h"
@interface PSInPutCodeView()<UITextFieldDelegate,PSTextFieldDelegate>
//密码个数
@property (nonatomic,assign)NSInteger count;
//密码间距
@property (nonatomic,assign)CGFloat space;

@property (nonatomic,strong)NSArray* textFArr;

/// 用于保持键盘不退下的textField
@property (strong, nonatomic) PSTextField *holdOffF;

@property(nonatomic,copy) PSCodeViewBlock codeBlock;
@end

@implementation PSInPutCodeView

-(instancetype)initWithFrame:(CGRect)frame andCount:(NSInteger)count andSpace:(CGFloat)space codeBlock:(PSCodeViewBlock)codeBlock{
    if (self = [super initWithFrame:frame]) {
        self.space =  space;
        self.count = count;
        [self becomeKeyBoardFirstResponder:0];
        self.codeBlock = codeBlock;
        [self addSubview:self.holdOffF];
    }
    return self;
}

-(PSTextField *)holdOffF{
    if (_holdOffF == nil) {
        _holdOffF = [[PSTextField alloc] initWithFrame:CGRectZero];
        _holdOffF.keyboardType = UIKeyboardTypeASCIICapable;
        _holdOffF.xmDelegate = self;
    }
    return _holdOffF;
}

#pragma mark ---- UI处理
-(void)setCount:(NSInteger)count{
    _count = count;
    CGFloat textW = 44.0;
    CGFloat textH = 44.0;
    CGFloat allW = count*textW + (count-1)*self.space;
    
    //计算起始位置及宽度
    CGFloat startX = 0;
    CGFloat width = self.frame.size.width;
    if (width > allW) {
        startX = width/2.0-allW/2.0;
    }else {
        startX = 0;
        textW = (width-(count-1)*self.space)/count;
    }
    //高度限制
    CGFloat height = self.frame.size.height;
    if (textH > height) {
        textH = height;
    }
    
    //设置数组
    NSMutableArray* textArr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        PSTextField* textF = [[PSTextField alloc] initWithFrame:CGRectMake(startX+i*textW+i*self.space, height/2.0-textH/2.0, textW, textH)];
        textF.delegate = self;
        textF.keyboardType = UIKeyboardTypeASCIICapable;
        [textF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textF.borderStyle = UITextBorderStyleRoundedRect;
        textF.textAlignment = NSTextAlignmentCenter;
        textF.xmDelegate = self;
        [self addSubview:textF];
        [textArr addObject:textF];
    }
    self.textFArr = [textArr copy];
}


#pragma mark --- 第一键盘响应者
- (void)becomeKeyBoardFirstResponder:(NSInteger)index
{
    if (self.textFArr.count>index) {
        [self.textFArr[index] becomeFirstResponder];
    }else{
        [self.holdOffF becomeFirstResponder];
    }
}

#pragma mark --- textDegelate
- (BOOL)textFieldShouldBeginEditing:(PSTextField *)textField{
    
    NSInteger index = [self indexFor:textField];
    NSString* text = [self formatText];
    
    if (index == text.length) {
        return YES;
    }
    
    if ([self formatText].length < self.count) {
        //让下一个变成响应者
        [self becomeKeyBoardFirstResponder:text.length];
    }else {
        [self.holdOffF becomeFirstResponder];
    }
    return NO;
    
}

- (void)textFieldDidChange:(PSTextField *)textField{
    NSString* text = [self formatText];
    if (text.length < self.count) {
        //让下一个变成响应者
        [self becomeKeyBoardFirstResponder:text.length];
    }else {
        [self.holdOffF becomeFirstResponder];
    }
    
    //返回值
    if (self.codeBlock) {
        self.codeBlock(text);
    }
}

//只允许字母数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

#pragma mark --- 删除
- (void)textFeildDeleteBackward:(PSTextField *)textField{
    
    //返回值
    if (self.codeBlock) {
        self.codeBlock([self formatText]);
    }
    
    if (textField == self.holdOffF) {
        PSTextField* textF = [self.textFArr objectAtIndex:self.count-1];
        textF.text = nil;
        [textF becomeFirstResponder];
        return;
    }
    
    NSInteger index = [self indexFor:textField];
    
    if (index > 0 && textField.text.length == 0) {
        PSTextField* textF = [self.textFArr objectAtIndex:index-1];
        textF.text = nil;
    }
    
    [self becomeKeyBoardFirstResponder:index-1];
}

#pragma mark --- 数据汇总
-(NSString*)formatText{
    NSString* textStr = @"";
    for (int i = 0; i < self.textFArr.count; i++) {
        PSTextField* textF = self.textFArr[i];
        if (textF.text.length == 0) {
            break;
        }
        textStr = [textStr stringByAppendingString:textF.text];
    }
    return textStr;
}

-(NSInteger)indexFor:(PSTextField*)textField{
    NSInteger index = 0;
    for (int i = 0; i < self.textFArr.count; i++) {
        if (textField == self.textFArr[i]) {
            index = i;
            break;
        }
    }
    return index;
}

@end
