//
//  PSCGIConst.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#ifndef PSCGIConst_h
#define PSCGIConst_h

/*!
 *
 *  @brief 正式环境: 1
 *
 *  @brief 测试环境: 0
 */
#define kAppIsProduction 0

#if kAppIsProduction
    // 正式环境
    #define kApi_Base_Url @"http://tapi.pomesoft.com/"


#else
    // 测试环境
    #define kApi_Base_Url @"http://tapi.pomesoft.com/"

#endif



/*!
 *  网络请求回调
 */
typedef void(^PSCGISuccessBlock)(NSURLSessionDataTask *task, id response);

typedef void(^PSCGIFaileBlock)(NSURLSessionDataTask *task, NSError* error);

//文件下载回调
typedef void (^PScompletionHandler)(NSURLResponse *response, NSURL *filePath, NSError *error);

/*!
 *  请求网络途径Mask
 *  注：以后如果增加了其他host，需要在这里增加类型
 */
typedef NS_ENUM(NSInteger,PSCGIRequestMask) {
    /*!
     *  默认为自己的API服务器地址
     */
    PSCGIRequestMaskDefult,
    
    /*!
     *  其它三方或者文件服务器等地址
     */
    PSCGIRequestMaskOther,

};

#endif /* PSCGIConst_h */
