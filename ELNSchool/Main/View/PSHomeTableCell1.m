//
//  PSHomeTableCell1.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/8.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSHomeTableCell1.h"
#import "CollectionViewCell.h"
@interface PSHomeTableCell1()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView* collectionView;

@end

static NSString* collctionID = @"collctionID";

@implementation PSHomeTableCell1

+(NSString*)cellID{
    return @"PSHomeTableCell1";
}

+(CGFloat)cellHight{
    return 450*kHProportion;
}


+(PSHomeTableCell1*)cellWithTableview:(UITableView*)tableview{
    PSHomeTableCell1* cell = [tableview dequeueReusableCellWithIdentifier:[self cellID]];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4.0, 450*kHProportion/2.0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:collctionID];
    }
    return _collectionView;
}

#pragma mark  --- datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:collctionID forIndexPath:indexPath];
    cell.titleLab.text = @"title";
    cell.iconImg.image = [UIImage imageNamed:@"wd_dd_gh"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
