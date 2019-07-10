//
//  JZTPayCenter.h
//  支付中心

#import <Foundation/Foundation.h>
#import "JZTPayResp.h"

typedef void(^PayResultBack)(BOOL sucess);

@interface JZTPayCenter : NSObject

+(void)payWithOrderID:(NSString *)orderId andResult:(PayResultBack)bloc;

@end




