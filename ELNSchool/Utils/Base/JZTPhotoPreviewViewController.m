//
//  JZTPhotoPreviewViewController.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/6/6.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTPhotoPreviewViewController.h"
#import "HXDatePhotoPreviewBottomView.h"
#import "HXPhotoCustomNavigationBar.h"

@interface JZTPhotoPreviewViewController ()<UIViewControllerContextTransitioning>
@property (nonatomic, strong) HXPhotoCustomNavigationBar *nav;//

@property (nonatomic, strong) UILabel *jzt_titleLabel;//

@end

@implementation JZTPhotoPreviewViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.outside = YES;
        self.modalPresentationCapturesStatusBarAppearance = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    if (!self.manager) {
        self.manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    }
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.bottomView.hidden = YES;
}

- (void)addLocalImage:(NSArray<UIImage *> *)images{
    if (!self.manager) {
        self.manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    }
    [self.manager addLocalImage:images selected:YES];
    self.modelArray = self.manager.afterSelectedArray.mutableCopy;
}

- (void)addNetworkingImageToAlbum:(NSArray<NSString *> *)imageUrls{
    if (!self.manager) {
        self.manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    }
    [self.manager addNetworkingImageToAlbum:imageUrls selected:YES];
    self.modelArray = self.manager.afterSelectedArray.mutableCopy;
}

- (void)refershTitle{
    self.title = [NSString stringWithFormat:@"%d/%d", self.currentModelIndex+1, self.manager.afterSelectedArray.count];
}

- (void)dismiss{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -
#pragma mark - ovrried
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    
    [self refershTitle];
}

- (HXPhotoCustomNavigationBar *)navBar {
    return nil;
}


- (void)setSubviewAlphaAnimate:(BOOL)animete {
    [self dismiss];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.photoView) {
        return [super animationControllerForDismissedController:dismissed];
    }
    return [[JZTPhotoPreviewTransition alloc]initWithFromView:self.fromView];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.photoView) {
        return [super animationControllerForPresentedController:presented presentingController:presenting sourceController:source];
    }
    return [[JZTPhotoPreviewTransition alloc]initWithFromView:self.fromView];
}

@end

@implementation JZTPhotoPreviewTransition
- (instancetype)initWithFromView:(UIView *)view{
    if (self = [super init]) {
        _fromView = view;
    }
    return self;
}
#pragma mark -
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return  0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (toViewController.isBeingPresented) {
        [[transitionContext containerView] addSubview:toViewController.view];
        
        JZTPhotoPreviewViewController *tovc = (JZTPhotoPreviewViewController *)toViewController;
        NSArray *arr = [tovc.collectionView visibleCells];
        HXDatePhotoPreviewViewCell *cell = arr.firstObject;
        CGRect oriFrame = cell.imageView.frame;
        CGRect transFrame = [self.fromView convertRect:self.fromView.frame toView:cell.contentView];
        cell.imageView.frame = transFrame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            cell.imageView.frame = oriFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    } else {
        JZTPhotoPreviewViewController *fromvc = (JZTPhotoPreviewViewController *)fromViewController;
        NSArray *arr = [fromvc.collectionView visibleCells];
        HXDatePhotoPreviewViewCell *cell = arr.firstObject;
        CGRect transFrame = [self.fromView convertRect:self.fromView.frame toView:cell.contentView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            cell.imageView.frame = transFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }
}
@end





