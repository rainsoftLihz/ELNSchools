//
//  JZTPayCenter.m
//

#import "JZTPayCenter.h"
#import "PSPayApi.h"
#import "WXApi.h"
@interface JZTPayCenter()

@property(nonatomic, copy) NSString *orderID;

@property(nonatomic, copy) PayResultBack payBlock;
@end

@implementation JZTPayCenter

-(void)payWithOrderID:(NSString*)orderID {
    self.orderID = orderID;
    [self wxPayWithOrderID:orderID];
    [self registerNSNotification];
}

+ (void)payWithOrderID:(NSString *)orderId andResult:(PayResultBack)bloc{
    JZTPayCenter* pay =  [JZTPayCenter new];
    pay.payBlock = bloc;
    [pay payWithOrderID:orderId];
}

-(void)registerNSNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
              selector:@selector(handleWXPayNotification:)
                  name:WX_PAY_NOTIFICATION
                object:nil];
}

- (BOOL)WXisInstall
{
    if (![WXApi isWXAppInstalled]) {
        [LHZLoadingManager showTips:@"请安装微信客户端"];
        return NO;
    }
    return YES;
}




/**
 支付结果回调
 */
- (void)handleWXPayNotification:(NSNotification *)notification {
    PayResp *resp = notification.object;
    switch (resp.errCode) {
        case WXSuccess:{
            //支付成功和在处理中
            //从后台获取真正的支付结果并回调
            if (self.payBlock) {
                self.payBlock(YES);
            }
            break;
        }
        default:{
            [LHZLoadingManager showTipsError:@"支付失败"];
            break;
        }
    }
}





/**
 微信支付
 
 @param orderId 订单号
 */
- (void)wxPayWithOrderID:(NSString *)orderId  {
    
    if ([self WXisInstall]) {
        NSDictionary *param = @{@"orderId":orderId
                                };
        
        [self preparePayWithParam:param];
    }
}


/**预支付
 
 @param param 预支付参数
 */
- (void)preparePayWithParam:(NSDictionary *)param {
    
    //从后台获取订单信息
    [PSPayApi payOrder:param andSuccess:^(NSURLSessionDataTask *task, PSRsponse* response) {
        JZTPayResp* resp = response.data;
        //调用微信API支付
        [self wxPayWithPayResp:resp];
        
    } andFaile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}



/**
  微信支付
 
 @param resp 微信支付实体
 */
- (void)wxPayWithPayResp:(JZTPayResp *)resp{
    //封装微信请求
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = resp.appid;
    req.partnerId           = resp.partnerid;
    req.prepayId            = resp.prepayid;
    req.nonceStr            = resp.noncestr;
    req.timeStamp           = resp.timestamp.intValue;
    req.package             = resp.package;;
    req.sign                = resp.sign;
    [WXApi sendReq:req];
}


@end

