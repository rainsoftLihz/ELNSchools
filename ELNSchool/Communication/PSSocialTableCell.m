//
//  PSSocialTableCell.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSSocialTableCell.h"
#import "HXPhotoView.h"
#import <CoreText/CoreText.h>
@interface PSSocialTableCell()<HXPhotoViewDelegate>

@property(nonatomic,strong)HXPhotoManager *manager;

@property(nonatomic,strong)HXPhotoView* photoView;

@property(nonatomic,strong) UILabel* contentLab;

@property (strong, nonatomic)  UIButton *openBtn;

@property (nonatomic, assign) CGFloat estimatedHeight;

@end

@implementation PSSocialTableCell

+(NSString*)cellID{
    return @"PSSocialTableCell";
}

+(PSSocialTableCell*)cellWithTable:(UITableView*)tableView{
    PSSocialTableCell* cell = [tableView dequeueReusableCellWithIdentifier:[PSSocialTableCell cellID]];
    if (!cell) {
        cell = [[PSSocialTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PSSocialTableCell cellID]];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.estimatedHeight = 76.5;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    self.contentLab = [[UILabel alloc] qmui_initWithFont:kFontSize(14.0) textColor:UIColor.grayColor];
    self.contentLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.contentLab];
    
    NSInteger falg = arc4random()%2;
    self.contentLab.text = falg == 0 ?@"何发我额范围，为哦就发我额将佛为，美味将佛我就饿哦饭，美味将额范围就饿哦饭加我额，微积分微积分那2222":@"山东后为何发我额范围，为哦就发我额将佛为，美味将佛我就饿哦饭，美味将额范围就饿哦饭加我额，微积分微积分那是你的v你说的你，山东后为何发我额范围，为哦就发我额将佛为，美味将佛我就饿哦饭，美味将额范围就饿哦饭加我额，微积分微积分那是你的v你说的你";
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15.0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
    }];
    
    self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_openBtn setTitle:@"展开" forState:UIControlStateNormal];
    [_openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_openBtn addTarget:self action:@selector(clickOpen:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.openBtn];
    
    NSInteger numLines  = [self numberOfLinesForFont:self.contentLab.font constrainedToSize:CGSizeMake(KScreenWidth-30, MAXFLOAT) lineBreakMode:self.contentLab.lineBreakMode and:self.contentLab.text];
    
    
    [self.contentView addSubview:self.photoView];
    if (numLines > 3) {
        self.contentLab.numberOfLines = 3;
        self.openBtn.hidden = NO;
        [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLab.mas_bottom).offset(12);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(44.0, 20));
        }];
        
        [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
            make.left.mas_equalTo(self.contentView).offset(15.0);
            make.top.mas_equalTo(self.openBtn.mas_bottom).offset(15.0);
            make.height.mas_equalTo(self.estimatedHeight);
        }];
        
    }else {
        self.contentLab.numberOfLines = 0;
        self.openBtn.hidden = YES;
        [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
            make.left.mas_equalTo(self.contentView).offset(15.0);
            make.top.mas_equalTo(self.contentLab.mas_bottom).offset(15.0);
            make.height.mas_equalTo(self.estimatedHeight);
        }];
    }

}


- (void)clickOpen:(id)sender {
    if ([self.openBtn.currentTitle isEqualToString:@"展开"]) {
        //展开
        [self.openBtn setTitle:@"收起" forState:UIControlStateNormal];
        self.contentLab.numberOfLines = 0;
        
    }else {
        self.contentLab.numberOfLines = 3;
        [self.openBtn setTitle:@"展开" forState:UIControlStateNormal];
    }
    
    if (self.photoViewChangeHeightBlock) {
        self.photoViewChangeHeightBlock(self, self.estimatedHeight);
    }
}


#pragma mark ---
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 0;
        _manager.configuration.maxNum = 10;
    }
    return _manager;
}

- (HXPhotoView *)photoView {
    if (!_photoView) {
        _photoView = [[HXPhotoView alloc] initWithManager:self.manager];
        _photoView.lineCount = 4;
        _photoView.spacing = Adapt_scaleL(13);
        _photoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _photoView.delegate = self;
    }
    return _photoView;
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:0];
    for (HXPhotoModel * ml in allList) {
        if (ml.networkPhotoUrl) {
            NSURLComponents *componts =[[NSURLComponents alloc] initWithString:ml.networkPhotoUrl.absoluteString];
            [urls addObject:[componts.path componentsSeparatedByString:@"/"].lastObject];
        }
    }
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    
    if (self.photoView != photoView) {
        return;
    }
    
    if (fabs(self.estimatedHeight - CGRectGetHeight(frame)) < 1) {
        return;
    }
    
    
    self.estimatedHeight = CGRectGetHeight(frame);
    [self __layout];
}

- (void)__layout{
    
    if (self.openBtn.isHidden) {
        [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
            make.top.mas_equalTo(self.contentLab.mas_bottom).offset(15.0);
            make.left.mas_equalTo(self.contentView).offset(15.0);
            make.height.mas_equalTo(self.estimatedHeight);
        }];
    }else {
        [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
            make.top.mas_equalTo(self.openBtn.mas_bottom).offset(15.0);
            make.left.mas_equalTo(self.contentView).offset(15.0);
            make.height.mas_equalTo(self.estimatedHeight);
        }];
    }
    
    if (self.photoViewChangeHeightBlock) {
        self.photoViewChangeHeightBlock(self, self.estimatedHeight);
    }
}

#pragma mark --- 行数
- (NSInteger)numberOfLinesForFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode and:(NSString*)content {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : font}];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [attString length]), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);
    return lines.count;
}


@end
