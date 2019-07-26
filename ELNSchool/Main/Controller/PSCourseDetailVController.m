//
//  PSCourseDetailVController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSCourseDetailVController.h"
#import "PSBaseVideoVController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "PSBuyToolView.h"
#import "PSKCBTableCell.h"
#import "PSShowBuyVController.h"
#import "PSCommentTableCell.h"
@interface PSCourseDetailVController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) HMSegmentedControl* segmentController;
@property(nonatomic,strong) UIScrollView* scrollView;

@property(nonatomic,strong) NSArray<UITableView*>* tableArr;
@end

@implementation PSCourseDetailVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程详情";
    [self addVideoController];
    [self addSegmentController];
    [self.view addSubview:self.scrollView];
    [self addTableviewToScroll];
    [self addToolBar];
}

#pragma mark  --- 视频播放
-(void)addVideoController{
    PSBaseVideoVController* bvc = [[PSBaseVideoVController alloc] initWith:NO and:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];
    bvc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBarAndStatusBarHeight);
    [self.view addSubview:bvc.view];
    [self addChildViewController:bvc];
}

#pragma mark --- 分段控制器
-(void)addSegmentController{
    HMSegmentedControl* controller = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"课程介绍",@"课程表",@"交流区"]];
    controller.frame = CGRectMake(0, KScreenWidth*9/16, KScreenWidth, 44.0);
    controller.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    controller.selectionIndicatorHeight = 2.5;
    controller.selectionIndicatorColor = UIColor.redColor;
    controller.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    controller.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0]};
    [self.view addSubview:self.segmentController = controller];
    __weak typeof(self)wkSelf = self;
    controller.indexChangeBlock = ^(NSInteger index) {
        NSLog(@"index====>>>%ld",index);
        [wkSelf.scrollView setContentOffset:CGPointMake(KScreenWidth*index, 0) animated:YES];
        
        for (UITableView* talbe in self.tableArr) {
            [talbe reloadData];
        }
    };
}

#pragma mark  ---- scroll
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        CGFloat y = CGRectGetMaxY(self.segmentController.frame);
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,y, KScreenWidth, KScreenHeight - y - 44.0 - kNavBarAndStatusBarHeight)];
        _scrollView.contentSize = CGSizeMake(3*KScreenWidth, KScreenHeight - y);
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset/KScreenWidth;
    [self.segmentController setSelectedSegmentIndex:index animated:YES];;
}

#pragma mark --- 购买
-(void)addToolBar{
    kWeakSelf;
    PSBuyToolView* buyView = [[PSBuyToolView alloc] initWithFrame:CGRectMake(0, KScreenHeight-44.0-kNavBarAndStatusBarHeight, KScreenWidth, 44.0) andShowBuyAction:^{
        [wkSelf showBuy];
    }];
    [self.view addSubview:buyView];
}

-(void)showBuy{
    PSShowBuyVController* show = [[PSShowBuyVController alloc] init];
    show.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    show.definesPresentationContext = YES;
    show.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:show animated:YES completion:nil];
}

#pragma mark  --- talbe
-(void)addTableviewToScroll{

    NSMutableArray* tabArr = [NSMutableArray arrayWithCapacity:2];
    for (int i = 0; i < 2; i++) {
        UITableView* table = [[UITableView alloc] initWithFrame:CGRectMake(KScreenWidth*(i+1), 0, KScreenWidth, KScreenHeight-kNavBarAndStatusBarHeight-44.0-CGRectGetMaxY(self.segmentController.frame)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        
        [self.scrollView addSubview:table];
        
        if (i == 0) {
            [table registerClass:[PSKCBTableCell class] forCellReuseIdentifier:[PSKCBTableCell cellID]];
        }else {
            
            [table registerNib:[UINib nibWithNibName:@"PSCommentTableCell" bundle:nil] forCellReuseIdentifier:[PSCommentTableCell cellID]];
            table.estimatedRowHeight = 75;
        }
        [tabArr addObject:table];
    }
    
    self.tableArr = tabArr.copy;
}


#pragma mark --- table delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (tableView == self.tableArr[0]) {
        PSKCBTableCell* cell = [PSKCBTableCell cellWithTable:tableView];
        return cell;
    }
    
    PSCommentTableCell* cell = [PSCommentTableCell cellWithTable:tableView];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableArr[1]) {
        return UITableViewAutomaticDimension;
    }
    return 85;
}

@end
