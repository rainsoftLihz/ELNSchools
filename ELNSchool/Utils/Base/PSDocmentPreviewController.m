//
//  PSDocmentPreviewController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/12.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSDocmentPreviewController.h"
#import <QuickLook/QuickLook.h>
#import "PSBaseAPI.h"
@interface PSDocmentPreviewController()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (strong, nonatomic)QLPreviewController *previewController;

@property (copy, nonatomic)NSURL *fileURL;

@property (copy, nonatomic)NSString *urlStr;
@end
@implementation PSDocmentPreviewController

-(instancetype)initWith:(NSString*)urlSr{
    if (self = [super init]) {
        
        self.urlStr = urlSr;
    }
    
    return self;
}

- (void)viewDidLoad{
    
    self.previewController  =  [[QLPreviewController alloc]  init];
    
    self.previewController.view.frame = self.view.bounds;
    
    [self.previewController didMoveToParentViewController:self];
    
    [self addChildViewController:self.previewController];
    
    [self.view addSubview:self.previewController.view];
    
    self.previewController.dataSource  = self;
    
    [self loadURL:self.urlStr];
}

#pragma mark ---文件加载
-(void)loadURL:(NSString*)urlStr{
    NSString *fileName = [urlStr lastPathComponent]; //获取文件名称
    
    //设置标题
    self.title = [[fileName componentsSeparatedByString:@"."] firstObject];
    
    if ([self isFileExist:fileName]) {
        //文件存在
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        self.fileURL = url;
        //刷新界面
        [self.previewController refreshCurrentPreviewItem];
    }else {
        //下载
        [PSBaseAPI downLoadFile:urlStr complet:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            self.fileURL = filePath;
            //刷新界面
            [self.previewController refreshCurrentPreviewItem];
        }];
    }
}
    
//判断文件是否已经在沙盒中存在
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

#pragma mark - QLPreviewControllerDataSource
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.fileURL;
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController{
    return 1;
}

#pragma mark - QLPreviewControllerDelegate
- (void)previewControllerWillDismiss:(QLPreviewController *)controller{
    //视图消失的时候
    //[self.navigationController popViewControllerAnimated:YES];
}

@end
