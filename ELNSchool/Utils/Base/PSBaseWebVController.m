//
//  PSBaseWebVController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/12.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseWebVController.h"
#import <WebKit/WebKit.h>
@interface PSBaseWebVController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) NSURL *webURL;
@end

@implementation PSBaseWebVController

-(instancetype)initWith:(NSString*)url{
    if (self = [super init]) {
        NSString* urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.webURL = [NSURL URLWithString:urlStr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.webURL];
    [self.wkWebView loadRequest:request];
}


-(WKWebView *)wkWebView {
    if (!_wkWebView) {
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        configuration.allowsInlineMediaPlayback = YES;
        configuration.mediaTypesRequiringUserActionForPlayback = false;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    }
    return _wkWebView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
