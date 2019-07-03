//
//  PSNavViewController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSNavViewController.h"

@interface PSNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation PSNavViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.enabled = YES;

    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakself;
    }
    
    //2.设置BarButtonItem的主题  这是左右的不是标题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        // 屏蔽调用rootViewController的滑动返回手势
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}

/**
 *  重写这个方法,能拦截所有的push操作
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //返回按钮
        viewController.navigationItem.leftBarButtonItem = [self setBackButtonItem];
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark --- 统一返回按钮
- (UIBarButtonItem *)setBackButtonItem {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 44/2.0-22/2.0, 66.0/3.0, 66.0/3.0);
    
    [button setBackgroundImage:[UIImage imageNamed:@"byj_fanhui"] forState:0];
    [button addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(0, 0, 44, 44);
    [clearBtn addSubview:button];
    [clearBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearBtn];
    return someBarButtonItem;
}

- (void)backViewController {
    
    [self popViewControllerAnimated:YES];
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
