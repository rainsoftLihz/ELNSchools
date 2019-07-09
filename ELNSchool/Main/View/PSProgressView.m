//
//  PSProgressView.m
//  弧形进度条
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 zhou. All rights reserved.
//

#import "PSProgressView.h"

@implementation PSProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 仪表盘底部
    drawFront();
    // 仪表盘进度
    [self drawBackgroud];
}
-(void)drawBackgroud
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapRound);
    //1.3  虚实切换 ，实线5虚线10
    //    CGFloat length[] = {4,8};
    //    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor colorWithRed:248.f/250 green:212.f/250.f blue:74.f/250.f alpha:1] set];

    
    /*
    CGContextRef  _Nullable c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
    x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针
    */
    CGFloat end = -3.5*M_PI_4+(3*M_PI_4*_num/_countNum);
    CGContextAddArc(ctx, KScreenWidth/2 , 250/2, 100, -3.5*M_PI_4, end , 0);
    //3.绘制
    CGContextStrokePath(ctx);
    
}

void drawFront()
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapRound);
    //1.3  虚实切换 ，实线5虚线10
    //    CGFloat length[] = {4,8};
    //    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor colorWithRed:118.f/250.f green:224.f/250.f blue:248.f/250.f alpha:1] set];

    //2.设置路径
    CGContextAddArc(ctx, KScreenWidth/2 , 250/2, 100, -3.5*M_PI_4, -0.5*M_PI_4, 0);
    //3.绘制
    CGContextStrokePath(ctx);
    
}

@end
