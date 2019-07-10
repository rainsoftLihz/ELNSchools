//
//  JZTPayEntity.h
//  JZTCGICall
//
//  Created by 周光 on 2018/6/6.
//  Copyright © 2018年 JZT. All rights reserved.
//

#import <Foundation/Foundation.h>
//订单状态
typedef enum : NSUInteger {
    JZTOrderStautsAudit         = -3,  //待审核
    JZTOrderStautsPay           = -2,  //待支付
    JZTOrderStautsTodo          = -1,  //待处理
    JZTOrderStautsCancel        = 5    //已取消
} JZTOrderStauts;

//支付类型
typedef enum : NSUInteger {
    //微信支付
    JZTPayTypeWX = 1,
    //支付宝支付
    JZTPayTypeAlipay = 2
} JZTPayType;



@interface JZTPayResp : NSObject

//用于微信
/** 商家向财付通申请的商家id */
@property (nonatomic, copy) NSString *appid;

@property (nonatomic, copy) NSString *partnerid;
/** 预支付订单 */
@property (nonatomic, copy) NSString *prepayid;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *noncestr;
/** 时间戳，防重发 */
@property (nonatomic, copy) NSString *timestamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, copy) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, copy) NSString *sign;

//支付宝订单字符串，用于支付宝
@property (nonatomic, copy) NSString *orderString;

@end




