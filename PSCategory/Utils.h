//
//  Utils.h
//  FMDBSIMPLE
//
//  Created by Kpeng on 15/11/10.
//  Copyright © 2015年 Kpeng. All rights reserved.
//
//公用类  加载pch 文件可以直接调用
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> //有UI 必须引用

@interface Utils : NSObject

/**
 *  时间戳与当前时间做比较算出 某某年某某月某某日
 *
 *  @param newsTimes 时间戳
 *
 *  @return 某某年某某月某某日
 */
+ (NSString *)newsTime:(double )newsTimes;

/**
 *  时间戳与当前时间做比较算出与当前时间相隔多少时间
 *
 *  @param newsTimes 时间戳
 *
 *  @return 刚刚   30分钟前  两小时前
 */
+ (NSString *)created_at:(double)newsTimes;

/**
 *  时间转换
 *
 *  @param totalstr 字符串
 *
 *  @return 返回字符串格式为中文年月日
 */
+(NSString *)setDateWithTime:(NSString *)totalstr;

/**
 *  时间转换(标准型)
 *
 *  @param totalstr 时间戳
 *
 *  @param type 需要转换字符串格式的类型
 *
 *  @return 字符串
 */
+(NSString *)getDateWithTime:(NSString *)totalstr withType:(NSInteger)type;

/**
 *  时间转换(标准型)
 *
 *  @param totalstr 字符串
 *
 *  @return 时间戳
 */
+(double)setDateWithTimeSting:(NSString *)totalstr;

/**
 *  将plist中的文件读出来
 */
+ (NSDictionary *)dictionaryByPlistName:(NSString *)plistName;

/**
 *  将字典写入plist文件中
 */
+ (BOOL)writeDictionary:(NSDictionary *)dictionary asPlistName:(NSString *)plistName;

/**
 *  md5 32位 加密 （小写）
 */
+ (NSString *)md5:(NSString *)str;


/**
 *  UIWebView 加载 xml 字符串时需调用这个方法重置一次字符串
 */
+ (NSString *)webViewXMLTitle:(NSString *)dessting;

/**
 *  text 宽度
 */
+ (CGFloat)stringWithWidthText:(NSString *)text andFont:(UIFont *)font;

/*
 *  text 高度
 *
 */
+ (CGFloat)stringWithHeightText:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font;

/**
 *  转出成年
 *
 */
+(NSString *)setDateWithTimeYear:(NSString *)totalstr;
/**
 *  转换成日
 *
 */
+(NSString *)setDateWithTimeSun:(NSString *)totalstr;
/**
 *  转换成月
 *
 */
+(NSString *)setDateWithTimeMoon:(NSString *)totalstr;

/**
 *  时间根据年月日写三级数组数组
 */
+(NSArray *)setDataWithTimeArray:(NSArray *)array;

/**
 *  webView加载XML及图片进行处理
 */
+ (NSString *)deleteAll:(NSString *)dessting;

/**
 *  计算文件大小(M)
 */
+ (long long)fileSizeAtPath:(NSString *)filePath;

/**
 *  遍历文件夹获得文件夹大小，返回多少M
 *
 */
+ (float ) folderSizeAtPath:(NSString*) folderPath;

/**
 *  缓存路径 -> DocumentDirectory,
 */
+(NSString *)filePathWithResourceForDirectoriesInDomains;

/**
 *  字符串过滤
 *
 *  @param string     要过滤的字符
 *  @param characters 需过滤的字符
 *  @param strin      替换成
 *
 *  @return 已过滤的字符
 */
+ (NSString *)stringWorryUnnecessarily:(NSString *)string CharactersInString:(NSString *)characters ComponentsJoinedByStrin:(NSString *)strin;

/**
 *  +1
 *
 */
+ (void)animateWithDurationAddOne:(UIButton *)buttont View:(UIView *)views;

/*
 *  tableview 去除多余的横线
 *
 */
+ (void)setTableFooterView:(UITableView *)tb;

/*判断字符串是否为空
 */

+ (BOOL)isBlankString:(NSString *)string;


/**
 *  健康号是否为空
 *
 *  @param string 健康号
 *
 *  @return YES: 为空  NO:不为空
 */
+ (BOOL)heathAcountIsBlank:(NSString *)string;

/*
 * 距离感应器
 *
 */
+ (void)distanceShow;

/*
 * texiview 自适应高度
 *
 */
+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

/*
 * 汉字转pinyin
 *
 */
+ (NSString*)translateHanToPin:(NSString *)str;

/*
 * 图片裁剪修复
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;



/*
 *手机号验证
 */
+ (BOOL)validateMobile:(NSString *)mobile;



/**
 *  缩小图片尺寸
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 *  邮箱验证
 *
 */
+(BOOL)isValidateEmail:(NSString *)email;

/**
 *  限定图片尺寸
 *
 *  @param image     压缩的图片
 *  @param limitsize 压缩的大小
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)imageTake:(UIImage *)image imageHeightMax:(CGFloat)limitsize;

/**
 *  图片方向处理
 *
 *  @param image       图片
 *  @param orientation 横竖屏状态
 *
 *  @return 调整好的图片
 */
+ (UIImage *)images:(UIImage *)image rotation:(UIImageOrientation) orientation;

//车型
+ (BOOL)validateCarType:(NSString *)CarType;

//用户名
+ (BOOL)validateUserName:(NSString *)name;

//存储性别
+ (void)savaSex:(NSString *)sex;
//密码
+ (BOOL)validatePassword:(NSString *)passWord;

//昵称
+ (BOOL)validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard;


//邮政编码
+ (BOOL)validateUserPostNumber:(NSString *)postNumber;

//存储账号
+ (void)savaAccount:(NSString *)account;

//获取账号
+ (NSString *)getAccount;
//获取性别
+ (NSString *)getSex;

//保存密码
+ (void)savaPassWord:(NSString *)pw;

//清空密码
+ (void)removePassWord;

//获取密码
+ (NSString *)getPassWord;


//开始刷新
- (void)startRefresh:(UIView *)superView;

//停止刷新
- (void)stopRefresh:(UIView *)superView;

//用户头像
+ (void)saveUserImage:(NSString *)url;

//获取头像
+ (NSString *)getUserHeadImage;

//将NSNULL类型的数据转成普通字符串
+ (NSString *)changedNSNullToString:(NSString *)nullString;

//判断邮编前两位是否符合规范
+ (BOOL)judgePostCode:(NSInteger)number;

//判断身份证前两位数字是否合规范
+ (BOOL)judgeIdNumber:(NSInteger)number;

//获取当前网络设置环境
+ (BOOL)getCurrentNetworkStatus;
//获取当前网络设置环境
- (BOOL)getCurrentNetworkStatus;

//自定义警告框
+ (void)customAlertInfo:(NSString *)alertMessage andDelayTime:(NSTimeInterval)timeInterval;

//限制汉字的输入个数
+ (UITextField *)limiteChinese:(UITextField *)textField limitLength:(NSInteger)lLH;


//寻找字符串中的某一个字符/串
+ (NSInteger)researchWithString:(NSString *)aString andSubString:(NSString *)bString;

//  获取字符串的大小  ios7
+ (CGSize)width:(NSString *)str font:(UIFont *)font;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//将视图转换成img
+(UIImage *)getImageFromView:(UIView *)theView;
//获取健康号
+ (NSString *)getCurrentHealthAccount;


//将date时间戳转变成时间字符串
//@paaram   date            用于转换的时间
//@param    formatString    时间格式(yyyy-MM-dd HH:mm:ss)
//@return   NSString        返回字字符如（2012－8－8 11:11:11）
+ (NSString *)getDateStringWithDate:(NSDate *)date dateFormat:(NSString *)formatString;

+ (void) reachabilityNetworkStatus:(void (^) (NSString *status))netStatus;
//获取当前登录状态
+ (BOOL)getCurrentOfLoginStatus;
//查询member表中的所有个人信息
+ (NSDictionary *)rearchTableWhereMemberWithHealthAccount:(NSString *)healthAccount;

//更新个人中心数据库某条信息
+ (BOOL)updateDatabaseWithTableName:(NSString *)tableName andUpdateField:(NSString *)field andUpdateContent:(NSString *) content;
//获取当前时间
+ (NSString *)getCurrentTime;
//初始化积分选项
//+ (void)writeIntegralChooseStatuWithInfo:(NSString *)statuString;
//更改意见反馈标记
+ (void)savaSuggestOfMarkWithBoolValue:(BOOL)value;
//+ (NSString *)getIntegralStatus;
//查询图片的uuid
+ (NSString *)getHeadImageWithUUidStringWithHealthAccount:(NSString *)healthAccount;
//根据uuid获取图像
+ (UIImage *)getUserImageAccordingToImageContentOfPathWithUUid:(NSString *)uudi andSourceTableName:(NSString *)tableName;
//更新resource中的个人头像
+ (BOOL)updateHeadImageOfDatabaseWithTableName:(NSString *)tableName andUpdateField:(NSString *)field andUpdateContent: (NSString *)content;
//更新个人信息
+ (void)updateUserInfo;
//退出登录后删除document下的png头像图片
+ (BOOL)exitApplicationAndDeleteAllPicture;
//写入登录状态
+ (void)keepLoginStatus;
//写入当前用户信息
//+ (void)writePersonInfoWithHealthAccount:(NSString *)healthAccount;
//进行自动登录
+ (void)writeLoginAutomaticMarkOfState:(BOOL)state;
//获取个人头像并保存在本地
+ (void)getHeadImageSaveToDocuments:(NSURL *)url;
//是否自动登录
+ (BOOL)automaticLoginToServers;



//自定义Style字符串
+ (NSAttributedString *)string1:(NSString *)str1 count:(NSInteger)count string2:(NSString *)str2;
//文件创建 并返回创建的地址
+ (NSString *)fileCreate:(NSString *)path;
//文件获取 并返回文件的地址
+ (NSString *)getFilePathFromDocument:(NSString *)fileName;
//添加用户的语音到document
+ (NSString *)saveUserVoiceToDocument:(NSString *)fileName;
//添加医生的语音到document
+ (NSString *)saveDoctorVoiceToDocument:(NSString *)fileName;
//label上添加图片和文字
+ (NSMutableAttributedString *)attributeText:(NSString *)text addImage:(NSString *)imageName direction:(BOOL)dir;

//播放Image序列动画
+ (void)goAnimationWithCount:(NSInteger)count imageView:(UIImageView *)imageview;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC:(Class)aClass;
+ (void)showAlertViewWithMessage:(NSString *)message showTimeInterval:(NSTimeInterval)timeInterval alertImage:(UIImage *)alertImage;

//根据健康号保存本地搜索记录
+ (BOOL)addSearchHistoryWithStr:(NSString *)searchStr;
+(BOOL) isConnectionAvailable;


/**
 根据疾病ID得到疾病URL

 @param diseaseID 疾病ID
 @return 疾病URL
 */
+ (NSString *)diseaseUrlWithID:(NSString *)diseaseID;



//联系电话
+ (NSString *)connectTelephone;

@end
