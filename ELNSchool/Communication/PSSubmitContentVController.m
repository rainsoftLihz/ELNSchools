//
//  PSSubmitContentVController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/12.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSSubmitContentVController.h"
#import "HXPhotoView.h"

@interface PSSubmitContentVController ()<QMUITextViewDelegate,HXPhotoViewDelegate>

@property (nonatomic,strong)QMUITextView* textV;

@property(nonatomic,strong)HXPhotoManager *manager;

@property(nonatomic,strong)HXPhotoView* photoView;

@end


@implementation PSSubmitContentVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNavBar];

    [self configUI];
}


-(void)configUI{
    
    QMUITextView* textV = [[QMUITextView alloc] initWithFrame:CGRectMake(5, 5, KScreenWidth-10, 100)];
    textV.placeholder = @"学习中的疑惑见解";
    textV.layer.borderWidth = 1.0;
    textV.layer.borderColor = UIColor.groupTableViewBackgroundColor.CGColor;
    [self.view addSubview:self.textV = textV];
    
    [self.view addSubview:self.photoView];
}

#pragma mark ---
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 0;
        _manager.configuration.maxNum = 9;
    }
    return _manager;
}

- (HXPhotoView *)photoView {
    if (!_photoView) {
        _photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.textV.frame), KScreenWidth-10, 76.5) manager:self.manager];
        _photoView.lineCount = 5;
        _photoView.spacing = Adapt_scaleL(13);
        _photoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _photoView.delegate = self;
        //不添加删除按钮
        _photoView.cellRemoveDeleteBtn = NO;
    }
    return _photoView;
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame{
    
    CGFloat height = frame.size.height;
    
    self.photoView.height = height;
    
    //[self.view layoutSubviews];
}


#pragma mark --- nav bar
-(void)configNavBar{
    self.title = @"发帖";
    self.navigationItem.leftBarButtonItem = [self setButtonItemWith:@"取消"];
    self.navigationItem.rightBarButtonItem = [self setButtonItemWith:@"发表"];
}

- (UIBarButtonItem *)setButtonItemWith:(NSString*)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44.0, 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.titleLabel.font = kFontSize(14.0);
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return someBarButtonItem;
}

-(void)action:(UIButton*)sender{
    if ([sender.currentTitle  isEqual: @"取消"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (self.textV.text.length > 0) {
            [self.manager fetchOrigImagesCompletion:^(NSArray *images) {
                //上传照片
                
            }];
        }else {
            [LHZLoadingManager showTips:@"内容为空"];
        }
    }
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
