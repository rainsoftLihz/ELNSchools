//
//  JZTPhotoPreviewViewController.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/6/6.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

/*  示例
 - (void)testOpenAlbumVC:(UIView *)view index:(NSInteger)index{
 JZTPhotoPreviewViewController *nextVC = [[JZTPhotoPreviewViewController alloc]init];
 nextVC.fromView = view;
 NSMutableArray *images = @[].mutableCopy;
 for (int i = 0 ; i < 4; i++) {
 UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"test%d",i]];
 [images addObject:image];
 }
 [nextVC addLocalImage:images];
 NSMutableArray *imageURLS = @[].mutableCopy;
 for (JZTSearchMerchandiseModel *model in self.goodsDataSource) {
 NSString* code = [model.prodNo substringToIndex:10];
 NSString* imgUrl = [NSString stringWithFormat:@"%@/MedicinedePository_new/%@/%@_S.JPG",@"http://static.yyjzt.com",code,code];
 [imageURLS addObject:imgUrl];
 }
 [nextVC addNetworkingImageToAlbum:imageURLS];
 nextVC.currentModelIndex = index;
 [self presentViewController:nextVC animated:YES completion:nil];
 }
 */
#import "HXDatePhotoPreviewViewController.h"

@interface JZTPhotoPreviewViewController : HXDatePhotoPreviewViewController
@property (nonatomic, strong) UIView *fromView;//做动画用 传点击image的那个view
//self.currentModelIndex = [_manager.afterSelectedArray indexOfObject:model];
- (void)addLocalImage:(NSArray<UIImage *> *)images;
- (void)addNetworkingImageToAlbum:(NSArray<NSString *> *)imageUrls;
@end


@interface JZTPhotoPreviewTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak  ) UIView *fromView;
- (instancetype)initWithFromView:(UIView *)view;
@end
