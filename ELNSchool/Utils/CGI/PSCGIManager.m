//
//  PSCGIManager.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSCGIManager.h"

@implementation PSCGIManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/javascript",
                           @"text/json", @"text/html",@"text/plain",@"application/x-www-form-urlencoded",@"text/javascript",nil];
        self.requestSerializer.timeoutInterval = 30;
    }
    return self;
}


@end
