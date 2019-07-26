//
//  JZTWritePingLunView.m
//  qmyios
//
//  Created by rainsoft on 2017/5/31.
//  Copyright © 2017年 九州通. All rights reserved.
//

#import "JZTWritePingLunView.h"

@interface JZTWritePingLunView()<UITextViewDelegate>

@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UIButton *submitBtn;

@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,strong) UILabel *placeHolderLab;

@property(nonatomic,assign) float keyboardH;

@property(nonatomic,assign) BOOL resetMansory;
@end

#define kDeafaul_H 47.0

#define kDeafaul_Space 7.0

@implementation JZTWritePingLunView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    [self setupUI];
    return self;
}

-(void)setupUI{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-kDeafaul_H, KScreenWidth, kDeafaul_H)];
    _bottomView.backgroundColor = UIColorFromRGB(0xffffff);
    [self addSubview:_bottomView];
    _bottomView.hidden =YES;
    
    [_bottomView addSubview:self.textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_bottomView.mas_left).offset(10.0);
        make.right.mas_equalTo(self->_bottomView.mas_right).offset(-66-13-5);
        make.top.mas_equalTo(self->_bottomView.mas_top).offset(7.0);
        make.bottom.mas_equalTo(self->_bottomView.mas_bottom).offset(-7);
    }];
    
    
    _submitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_submitBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    _submitBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [_bottomView addSubview:_submitBtn];
    [_submitBtn addTarget:self action:@selector(submitInfomation) forControlEvents:UIControlEventTouchUpInside];
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_bottomView.mas_right).offset(-12.0);
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(66, 33));
    }];
    
    _submitBtn.layer.cornerRadius = 2.0;
    _submitBtn.layer.masksToBounds = YES;
    [_submitBtn setBackgroundColor:kMainColor];
    
    [_textView becomeFirstResponder];
    self.textView.inputAccessoryView = nil;
    
    
    _placeHolderLab = [UILabel new];
    _placeHolderLab.text = @" 请输入";
    _placeHolderLab.font = [UIFont systemFontOfSize:14.0];
    _placeHolderLab.textColor = UIColorFromRGB(0xbebebe);
    [_textView addSubview:_placeHolderLab];
    [_placeHolderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_textView.mas_left).offset(4.0);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(self->_textView.mas_top).offset(6.0);
    }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self->_bottomView);
        make.height.mas_equalTo(1.0);
    }];
}



#pragma mark --- textView
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.delegate = self;
        _textView.layer.borderColor = [UIColor whiteColor].CGColor;
        _textView.layer.cornerRadius = 2;
        _textView.layer.masksToBounds = YES;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.textColor = UIColorFromRGB(0x222222);
        _textView.font = [UIFont systemFontOfSize:15.0];
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.backgroundColor = UIColorFromRGB(0xf6f6f6);
        _textView.tintColor = kMainColor;// 改变光标的颜色
    }
    return _textView;
}

#pragma mark --- 键盘弹出
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    _bottomView.hidden =NO;
    
    NSDictionary* info = [aNotification userInfo];
 
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    _keyboardH = kbSize.height;
    
    float height = [self heightForTextView:_textView WithText:_textView.text];
    
    /* 解决隐藏视图再次点击的时候，视图高度不对光标没有滑动的问题 */
    _textView.scrollEnabled = YES;
    
    [UIView animateWithDuration:0.15 animations:^{
        if (self->_textView.text.length<=0) {
            self->_bottomView.frame = CGRectMake(0, KScreenHeight-kDeafaul_H-_keyboardH, KScreenWidth, kDeafaul_H);
        
        } else {
            self->_bottomView.frame = CGRectMake(0, (KScreenHeight-height-self->_keyboardH), KScreenWidth, height );
        }
    }];
    
    [self setNeedsLayout];
}


#pragma mark --- 预计算文字输入文字的总高度
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width - 10 , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    return size.size.height + kDeafaul_Space + 10.0;
}


#pragma mark --- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect frame = textView.frame;
    
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    
    CGSize size = [textView sizeThatFits:constraintSize];
    
    NSLog(@"height========%@",NSStringFromCGSize(size));
    
    
    /* 视图高度有变化的时候才执行 */
    if (self.resetMansory) {
       
        [UIView animateWithDuration:0.15 animations:^{
            
            self->_bottomView.frame =CGRectMake(0, KScreenHeight- size.height - kDeafaul_Space -self->_keyboardH, KScreenWidth, size.height+kDeafaul_Space);
            
        } completion:^(BOOL finished) {
            self->_textView.scrollEnabled = YES;
        }];
        
    }
    else {
        textView.layoutManager.allowsNonContiguousLayout = false;
        [textView scrollRangeToVisible:NSMakeRange(0, textView.text.length)];
    }
    
    
 

    if (textView.text.length<=0) {
        _placeHolderLab.hidden = NO;
    } else {
        if (![self limitLength:textView]) {
            NSLog(@"最多500字");
            return ;
        }
        _placeHolderLab.hidden = YES;
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    [_textView resignFirstResponder];
    
    _bottomView.frame = CGRectMake(0, KScreenHeight-kDeafaul_H, KScreenWidth, kDeafaul_H);
    
    [self removeFromSuperview];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    /* 解决输入过程中视图自动上下移动的BUG */
    _textView.scrollEnabled = NO;

    NSInteger maxLineNum = 3;
    
    NSString *textString = @"Text";
    CGSize fontSize = [textString sizeWithAttributes:@{NSFontAttributeName:textView.font}];
    
    NSString* newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    CGSize tallerSize = CGSizeMake(textView.frame.size.width,MAXFLOAT);
    
    CGSize newSize = [newText boundingRectWithSize:tallerSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName: textView.font}
                                           context:nil].size;
    NSInteger newLineNum = newSize.height / fontSize.height;
    if ([text isEqualToString:@"\n"]) {
        newLineNum += 1;
    }
    
    if (newLineNum <= maxLineNum)
    {
        self.resetMansory = YES;
        
    }else{
        self.resetMansory = NO;
        textView.scrollEnabled = YES;
    }
    
    return YES;
}


#pragma mark --- 提交按钮
-(void)submitInfomation {
    
    self.hidden = YES;
    
    if (self.submitPingLunText) {

        self.submitPingLunText(_textView.text);

    }
    
}


#pragma mark --- 控制字符串长度 不再联想
-(BOOL)limitLength:(UITextView *)tf
{
    bool isChinese;//判断当前输入法是否是中文
    if ([tf.textInputMode.primaryLanguage isEqualToString: @"en-US"])
        isChinese = false;
    else
        isChinese = true;
    
    NSString *str = [[tf text] stringByReplacingOccurrencesOfString:@"?" withString:@" "];
    
    if (isChinese) {
        UITextRange *selectedRange = [tf markedTextRange];
        UITextPosition *position = [tf positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if ( str.length >= 500) {
                NSString *strNew = [NSString stringWithString:str];
                [tf setText:[strNew substringToIndex:500]];
                return NO;
            }
        }
    }
    else{
        if ([str length]>=500) {
            NSString *strNew = [NSString stringWithString:str];
            [tf setText:[strNew substringToIndex:500]];
            return NO;
        }
    }
    return YES;
}


#pragma mark --- 点击隐藏视图
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取所有的触摸位置
    UITouch *touch = [touches anyObject];
    //触摸在self上
    CGPoint point = [touch locationInView:self];
    
    if (point.y < self.bottomView.frame.origin.y - 10) {
        
        self.hidden = YES;
        self.textView.text = nil;
        [self.textView resignFirstResponder];
    }
}


#pragma mark --- 提交成功清楚数据
-(void)clearView
{
    [self.textView resignFirstResponder];
    self.textView.text = nil;
    self.placeHolderLab.hidden = NO;
}


-(void)beFirstResponder
{
    [self.textView becomeFirstResponder];
}


-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
@end
