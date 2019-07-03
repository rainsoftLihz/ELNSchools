//
//  PSTextField.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSTextField.h"

@implementation PSTextField

#pragma mark --- 删除
- (void)deleteBackward
{
    BOOL canResponse = [self.xmDelegate respondsToSelector:@selector(textFeildDeleteBackward:)];
    if (self.xmDelegate && canResponse) {
        [self.xmDelegate textFeildDeleteBackward:self];
    }
    
    [super deleteBackward];
}

@end
