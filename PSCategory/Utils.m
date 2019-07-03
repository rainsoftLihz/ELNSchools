//
//  Utils.m
//  FMDBSIMPLE
//
//  Created by Kpeng on 15/11/10.
//  Copyright © 2015年 Kpeng. All rights reserved.
//

#import "Utils.h"
#import "NSDate+MJ.h" //判断时间问题
#import <CommonCrypto/CommonDigest.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Reachability.h"

@implementation Utils  {

     UIActivityIndicatorView     *iv;

}
+ (NSString *)newsTime:(double )newsTimes
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:newsTimes];
    NSDate *now = [NSDate date];
    
    
    
    // 比较出生日期和当前时间
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    
    NSString *format;
    if (interval <= 60) {
        format = @"出生一分钟前";
    } else if(interval <= 60*60){
        format = [NSString stringWithFormat:@"%.f分钟", interval/60];
    } else if(interval <= 60 * 60*24){
        format = [NSString stringWithFormat:@"%.f小时", interval/3600];
    } else if (interval < 60*60*24*30){
        format = [NSString stringWithFormat:@"%d天", (int)interval/(60*60*24)];
    }else if(interval < 60*60*24*30*12 ){
        int moon = (int)interval/(60*60*24*30);
        int sky = ((int)interval%(60*60*24*30))/(60*60*24);
        if(sky == 0)
        {
            format = [NSString stringWithFormat:@"%d个月", moon];
        }
        else
        {
            format = [NSString stringWithFormat:@"%d个月 %d天", moon,sky];
        }
        
    }else if(interval > 60*60*24*30*12 ){
        int year = (int)interval/(60*60*24*30*12);
        int moon = (int)interval%(60*60*24*30*12)/(60*60*24*30);
        int sky = (int)interval%(60*60*24*30*12)%(60*60*24*30)/(60*60*24);
        if (moon == 0)
        {
            format = [NSString stringWithFormat:@"%d周岁%d日", year,sky];
        }else if (sky == 0)
        {
            format = [NSString stringWithFormat:@"%d周岁%d个月", year,moon];
        }else
        {
            format = [NSString stringWithFormat:@"%d周岁%d个月%d天", year,moon,sky];
        }
    }
    
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

+ (NSString *)created_at:(double)newsTimes
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:newsTimes]]];
    
    // 2..判断发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", (long)createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", (long)createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

/**
 *  时间转换(返回字符串格式为中文年月日)
 *
 *  @param totalstr 字符串
 *
 *  @return 时间戳
 */
+(NSString *)setDateWithTime:(NSString *)totalstr
{

    NSString *dateString = [self getDateWithTime:totalstr withType:0];

    return dateString;
}

/**
 *  时间转换(标准型)
 *
 *  @param totalstr 字符串
 *
 *  @return 时间戳
 */
+(NSString *)getDateWithTime:(NSString *)totalstr withType:(NSInteger)type
{
    if ([totalstr integerValue]==0) {
        return @"";
    }
    //时间戳的处理
//    NSString *str =totalstr;
//    double lastactivityInterval = [str doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
   
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[totalstr integerValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 *  时间戳(标准型)
 *
 *  @param totalstr 字符串
 *
 *  @return 时间戳
 */
+(double)setDateWithTimeSting:(NSString *)totalstr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:totalstr];
    
    return (double)[date timeIntervalSince1970];
}

+(NSString *)setDateWithTimeYear:(NSString *)totalstr
{
    //时间戳的处理
    NSString *str =totalstr;
    double lastactivityInterval = [str doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)setDateWithTimeSun:(NSString *)totalstr
{
    //时间戳的处理
    NSString *str =totalstr;
    double lastactivityInterval = [str doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)setDateWithTimeMoon:(NSString *)totalstr
{
    
    //时间戳的处理
    NSString *str =totalstr;
    double lastactivityInterval = [str doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 *  时间根据年月日写三级数组数组
 */
+(NSArray *)setDataWithTimeArray:(NSArray *)array
{
    NSMutableArray *setYear = [NSMutableArray array];
    NSMutableArray *setMoon = [NSMutableArray array];
    NSMutableArray *setSun = [NSMutableArray array];
    NSInteger indexYear = 0;
    NSInteger indexMoon = 0;
    NSInteger indexSun = 0;
    NSInteger index = 0;
    for (NSMutableDictionary *dic in array)
    {
        NSString *year = [self setDateWithTimeYear:[dic[@"recordDate"] stringValue]];
        
        NSString *moon = [self setDateWithTimeMoon:[dic[@"recordDate"] stringValue]];
        
        NSString *sun = [self setDateWithTimeSun:[dic[@"recordDate"] stringValue]];
        
        if (([year integerValue] == indexYear || index == 0) || index != array.count - 1) {
            //存 月数
            if ([moon integerValue] != indexMoon) {
                NSMutableDictionary *dicmoon = [NSMutableDictionary dictionary];
                dicmoon[@"moon"] = moon;
                dicmoon[@"num"] = setSun;
                [setMoon addObject:dicmoon];
            }
            
            if ([moon integerValue] == indexMoon || index == 0) {
                
                //存 天数
                if ([sun integerValue] != indexSun) {
                    [setSun addObject:sun];
                }
            }
        }else {
            //存 年数
            NSMutableDictionary *dicYear = [NSMutableDictionary dictionary];
            dicYear[@"year"] = moon;
            dicYear[@"num"] = setSun;
            [setYear addObject:dicYear];
        }
        
        indexYear = [year integerValue];
        indexMoon = [moon integerValue];
        indexSun  = [sun  integerValue];
        index++;
        
    }
    return setYear;
}

/**
 *  存文件
 *
 */
+ (BOOL)writeDictionary:(NSDictionary *)dictionary asPlistName:(NSString *)plistName
{
    NSString *filePath = [self filePathWithResource:plistName];
    BOOL success = [dictionary writeToFile:filePath atomically:YES];
    return success;
}

/**
 *  取文件
 *
 */
+ (NSDictionary *)dictionaryByPlistName:(NSString *)plistName
{
    NSString *filePath = [self filePathWithResource:plistName];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dictionary;
}

/**
 *  计算文件大小(M)
 */
+ (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}

/**
 *  遍历文件夹获得文件夹大小，返回多少M
 *
 */
+ (float )folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

/**
 *  获取某文件名的路径
 *
 */
+ (NSString *)filePathWithResource:(NSString *)fileName
{
    NSString *path = [self filePathWithResourceForDirectoriesInDomains];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return filePath;
}

/**
 *  缓存路径 -> DocumentDirectory,
 */
+(NSString *)filePathWithResourceForDirectoriesInDomains
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

/**
 *  删除用户信息
 */
+ (void)removeUserInformation {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 
    [userDefaults synchronize];
}





+ (NSString *)webViewXMLTitle:(NSString *)dessting
{
    NSString* replacestring = [dessting stringByReplacingOccurrencesOfString:@"@R#R@" withString:@""];
    replacestring = [replacestring stringByReplacingOccurrencesOfString:@"@N#N@" withString:@""];
    replacestring = [replacestring stringByReplacingOccurrencesOfString:@"@@#@@" withString:@""];
    replacestring = [replacestring stringByReplacingOccurrencesOfString:@"@T#T@" withString:@""];
    return replacestring;
}

//需要导入secret库
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    
    return [[NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

/**
 *  text 宽度
 */
+ (CGFloat)stringWithWidthText:(NSString *)text andFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.width;
}

/**
 *  text 高度
 */
+ (CGFloat)stringWithHeightText:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.height;
}

/**
 *  webView加载XML及图片进行处理
 */
+ (NSString *)deleteAll:(NSString *)dessting
{
    NSString* replacestring = [dessting stringByReplacingOccurrencesOfString:@"@R#R@" withString:@""];
    replacestring = [replacestring stringByReplacingOccurrencesOfString:@"@N#N@" withString:@""];
    replacestring = [replacestring stringByReplacingOccurrencesOfString:@"@@#@@" withString:@""];
    replacestring = [replacestring stringByReplacingOccurrencesOfString:@"@T#T@" withString:@""];
    return replacestring;
}

/**
 *  字符串过滤
 *
 *  @param string     要过滤的字符
 *  @param characters 需过滤的字符
 *  @param strin      替换成
 *
 *  @return 已过滤的字符
 */
+ (NSString *)stringWorryUnnecessarily:(NSString *)string CharactersInString:(NSString *)characters ComponentsJoinedByStrin:(NSString *)strin
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString: characters];
    string = [[string componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: strin];
    string = [string substringToIndex:string.length - 1];
    return string;
}

/**
 *  +1
 *
 */
+ (void)animateWithDurationAddOne:(UIButton *)buttont View:(UIView *)views {
    
    CGRect supportF = buttont.frame;
    CGFloat addSuppotrX = supportF.origin.x + supportF.size.width / 2;
    __block CGFloat addSuppotrY = supportF.origin.y - 10;
    UILabel *addSuppotr = [[UILabel alloc] initWithFrame:CGRectMake(addSuppotrX, addSuppotrY, 20, 20)];
    addSuppotr.text = @"+1";
    addSuppotr.textColor = [UIColor redColor];
    [views addSubview:addSuppotr];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        addSuppotrY = addSuppotrY - 20;
        CGRect addSuppotrF = addSuppotr.frame;
        addSuppotrF.origin.y = addSuppotrY;
        addSuppotr.frame = addSuppotrF;
        
    } completion:^(BOOL finished) {
        
        [addSuppotr removeFromSuperview];
    }];
    
}

/*
 *  tableview 去除多余的横线
 *
 */
+ (void)setTableFooterView:(UITableView *)tb {
    
    if (!tb) {
        
        return;
        
    }
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [tb setTableFooterView:view];
    
}

/*判断字符串是否为空
 */
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if (string.length == 0) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}


/**
 *  健康号是否为空
 *
 *  @param string 健康号
 *
 *  @return YES: 为空  NO:不为空
 */
+ (BOOL)heathAcountIsBlank:(NSString *)string
{

    if (string == nil)
    {
        
        return YES;
        
    }
    
    if (string == NULL)
    {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {

        return YES;

    }
    
    return NO;
}


/*
 * 距离感应器
 *
 */
+ (void)distanceShow {
    //开启红外线距离感知
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
}

/*
 * texiview 自适应高度
 *
 */
+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText {
    
    float fPadding = 16.0; // 8.0px x 2
    
    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    
    CGSize size = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    float fHeight = size.height + 16.0;
    return fHeight;
}

/*
 * 汉字转pinyin
 *
 */
+ (NSString*)translateHanToPin:(NSString *)str {
    NSString *strUrl;
    if ([str length]) {
        
        NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            
            NSLog(@"pinyin: %@", ms);
            
            strUrl = [ms stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSLog(@"pinyin: %@", strUrl);
            
            return strUrl;
        }
        
    }
    
    return strUrl;
    
}

/*
 * 图片裁剪修复
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/*
 *检查前后摄像头
 *
 */
- (void)cameraBtnAction:(id)sender
{
    BOOL cameraAvailable = [UIImagePickerController isCameraDeviceAvailable:
                            UIImagePickerControllerCameraDeviceRear];//前
    BOOL frontCameraAvailable = [UIImagePickerController isCameraDeviceAvailable:
                                 UIImagePickerControllerCameraDeviceFront];//后
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile
{
//    //        //手机号以13， 15，18开头，八个 \d 数字字符
//    //       NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[^7,\\D])|(18[0,0-9]))\\d{8}$";
//    //       NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    //       return [phoneTest evaluateWithObject:mobile];
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,153,157,158,159,181,182,187,188,147
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189，177
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[02345-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,153,157,158,159,182,181，187,188,183
//     12         */
//    NSString * CM = @"^1(34[0-8]|4[57][0-8]|(3[5-9]|5[0137-9]|8[1278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|7[7]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|7[0678]|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:mobile] == YES)
//        || ([regextestcm evaluateWithObject:mobile] == YES)
//        || ([regextestct evaluateWithObject:mobile] == YES)
//        || ([regextestcu evaluateWithObject:mobile] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    
    
    
    if (mobile.length !=11) {
        return NO;
    }
    return YES;
  
}
//}
/**
 * 邮箱验证
 *
 */
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 *  缩小图片尺寸
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    return [self imageWithImage:image scaledToSize:newSize];
}

/**
 *  限定图片尺寸
 *
 *  @param image     压缩的图片
 *  @param limitsize 压缩的大小
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)imageTake:(UIImage *)image imageHeightMax:(CGFloat)limitsize
{
    
    UIImage *editimage = image;
    CGSize  newSize;
    
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    if(imageWidth > limitsize || imageHeight > limitsize) {
        
        if (imageWidth > imageHeight) {
            
            imageHeight = (imageHeight / imageWidth) * limitsize;
            imageWidth = limitsize;
            newSize.width = imageWidth;
            newSize.height = imageHeight;
            editimage = [self imageWithImage:image scaledToSize:newSize];
        } else {
            
            imageWidth = imageWidth / imageHeight *limitsize;
            imageHeight = limitsize;
            newSize.width = imageWidth;
            newSize.height = imageHeight;
            editimage = [self imageWithImage:image scaledToSize:newSize];
        }
    }
    return  editimage;
}

/**
 *  缩小图片尺寸
 */
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0, 0,newSize.width,newSize.height - 10)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return [self images:newImage rotation:0];
}

/**
 *  图片方向处理
 *
 *  @param image       图片
 *  @param orientation 横竖屏状态
 *
 *  @return 调整好的图片
 */
- (UIImage *)images:(UIImage *)image rotation:(UIImageOrientation) orientation {
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}

/**
 *  图片方向处理
 *
 *  @param image       图片
 *  @param orientation 横竖屏状态
 *
 *  @return 调整好的图片
 */
+ (UIImage *)images:(UIImage *)image rotation:(UIImageOrientation) orientation
{
    return [self images:image rotation:orientation];
}


/**
 *  用户名 密码  车牌
 */

//车型
+ (BOOL)validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL)validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,14}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


//邮政编码
+ (BOOL)validateUserPostNumber:(NSString *)postNumber{
    
    NSString    *postNumberRegex = @"^[0-9]{6,6}";
    NSPredicate *userPostPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postNumberRegex];
    BOOL B = [userPostPredicate evaluateWithObject:postNumber];
    return B;
}

//存储账号
+ (void)savaAccount:(NSString *)account{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:account forKey:@"account"];
    [defaults synchronize];
}


//存储性别
+ (void)savaSex:(NSString *)sex{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sex forKey:@"sex"];
    [defaults synchronize];
}

//获取性别
+ (NSString *)getSex{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"sex"];
}

//获取账号
+ (NSString *)getAccount{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"account"];
}

//保存密码
+ (void)savaPassWord:(NSString *)pw {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"password"];
    [defaults setObject:pw forKey:@"password"];
    [defaults synchronize];
}

//清空密码
+ (void)removePassWord {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"password"];
    [defaults synchronize];
}

//获取密码
+ (NSString *)getPassWord{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    return [defaults objectForKey:@"password"];
}


//开始刷新
- (void)startRefresh:(UIView *)superView{
    if (iv) {
        [iv removeFromSuperview];
        iv = nil;
    }
    iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat x = superView.center.x; CGFloat y = superView.center.y - 64;
    CGRect  rect = CGRectMake(x- 30, y-30, 60, 60);
    iv.frame = rect;
    [iv startAnimating];
    [superView addSubview:iv];
    
    [iv bringSubviewToFront:superView];
    
    for (UIView *viw in superView.subviews){
        
        [viw setUserInteractionEnabled:NO];
    }
}

//用户头像
+ (void)saveUserImage:(NSString *)url{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:url forKey:@"headImage"];
    [defaults synchronize];
}

//获取头像
+ (NSString *)getUserHeadImage{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    return [defaults objectForKey:@"headImage"];
}

//停止刷新
- (void)stopRefresh:(UIView *)superView{
    
    [iv stopAnimating];
    
    for (UIView *viw in superView.subviews){
        
        [viw setUserInteractionEnabled:YES];
    }
}

//将NSNULL类型的数据转成普通字符串
+ (NSString *)changedNSNullToString:(NSString *)nullString{
    
    //NSLog(@"nullString = %@",nullString);
    
    if ([nullString isKindOfClass:[NSNull class]] ) {
        
        return @"";
    }else
        return nullString;
}

//判断邮编前两位是否符合规范
+ (BOOL)judgePostCode:(NSInteger)number{
    
    if (number >= 11 && number <= 82) {
        
        if ((number >= 16 && number <= 20) ||
            (number >= 24 && number <= 30) ||
            number == 39 || number == 40) {
            
            return NO;
        }
        
        else if ((number >= 47 && number <= 49) ||
                 (number >= 55 && number <= 60) ||
                 (number >= 66 && number <= 70) ||
                 (number >= 72 && number <= 80)) {
            
            return NO;
        }
        else
            return YES;
    }
    
    return NO;
}

//判断身份证前两位数字是否合规范
+ (BOOL)judgeIdNumber:(NSInteger)number{
    
    //1 -- 85
    // 08 09 14 17 18 19 28 29 37 38 39 48 49 50 58 59 60 68 69 70 76 77 78 79 80 82
    
    if (number >= 1 && number <= 85) {
        
        if ((number == 8 || number == 9 || number == 14 || number == 82) ||
            (number >= 17 && number >= 19) ||
            (number == 28 || number == 29) ||
            (number >= 37 && number <= 39) ||
            (number >= 48 && number <= 50) ||
            (number >= 58 && number <= 60) ||
            (number >= 68 && number <= 70) ||
            (number >= 76 && number <= 80)) {
            
            return NO;
        }
        else
            return YES;
    }
    
    return NO;
}

//获取当前网络设置环境    YES:流量也可上传图片   NO:仅wifi连接网络
+ (BOOL)getCurrentNetworkStatus{
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults boolForKey:@"networkStatus"];
}

//获取当前网络设置环境    YES:流量也可上传图片   NO:仅wifi连接网络
- (BOOL)getCurrentNetworkStatus{
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults boolForKey:@"networkStatus"];
}



//自定义警告框
+ (void)customAlertInfo:(NSString *)alertMessage andDelayTime:(NSTimeInterval)timeInterval{
    
    UIWindow    *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.windowLevel = UIWindowLevelNormal;
    window.backgroundColor = [UIColor colorWithWhite:0.600 alpha:0.4000];
    window.hidden = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.15, KScreenHeight *0.45, KScreenWidth * 0.7, KScreenHeight * 0.1)];
    label.text = alertMessage;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.numberOfLines = 0;
    label.layer.cornerRadius = 6;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.900];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [window addSubview:label];
    
    double delayInSeconds = timeInterval;
    //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //推迟两纳秒执行
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            window.hidden = YES;
            [window resignKeyWindow];
        });
    });
}

//限制汉字的输入个数
+ (UITextField *)limiteChinese:(UITextField *)textField limitLength:(NSInteger)lLH
{
    bool isChinese;//判断当前输入法是否是中文
    if ([textField.textInputMode.primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    // 8位
    NSString *str = [[textField text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            NSLog(@"汉字");
            if ( str.length >= lLH) {
                NSString *strNew = [NSString stringWithString:str];
                [textField setText:[strNew substringToIndex:lLH - 1]];
            }
        }
        else
        {
            NSLog(@"输入的英文还没有转化为汉字的状态");
            
        }
    }else{
        
        NSLog(@"str=%@; 本次长度=%lu",str,(unsigned long)[str length]);
        
        if ([str length] >= lLH) {
            NSString *strNew = [NSString stringWithString:str];
            [textField setText:[strNew substringToIndex:lLH - 1]];
        }
    }
    return textField;
}




//寻找字符串中的某一个字符/串
+ (NSInteger)researchWithString:(NSString *)aString andSubString:(NSString *)bString{
    
    for (int i = 0; i < aString.length; i ++){
        
        NSRange range = NSMakeRange(i, bString.length);
        //NSString *str = [aString substringFromIndex:i];
        
        NSString *charStr = [aString substringWithRange:range];
        //NSLog(@"charStr = %@",charStr);
        
        if ([charStr isEqualToString:bString]){
            
            return range.location - 1;
        }
    }
    return NSNotFound;
}

//  获取字符串的大小  ios7
+ (CGSize)width:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(KScreenWidth, CGFLOAT_MAX)
                                    options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:attribute
                                    context:nil].size;
    
    return size;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/*!
 *  @brief 把格式化的字典的JSON格式字符串
 *  @param dic 字典
 *  @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (!dic)
        return nil;
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//视图转换成图片
+(UIImage *)getImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




//将date时间戳转变成时间字符串
//@paaram   date            用于转换的时间
//@param    formatString    时间格式(yyyy-MM-dd HH:mm:ss)
//@return   NSString        返回字字符如（2012－8－8 11:11:11）
+ (NSString *)getDateStringWithDate:(NSDate *)date dateFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    // NSLog(@"date: %@", dateString);
    return dateString;
}


+ (void) reachabilityNetworkStatus:(void (^) (NSString *status))netStatus{
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //NSLog(@"%ld",(long)status);
        
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        
        netStatus([NSString stringWithFormat:@"%ld",(long)status]);
        
        switch (status) {
            case -1:
                NSLog(@"%@",@"AFNetworkReachabilityStatusUnknown");
                break;
                
            case 0:
                NSLog(@"%@",@"AFNetworkReachabilityStatusNotReachable");
                break;
                
            case 1:
                NSLog(@"%@",@"AFNetworkReachabilityStatusReachableViaWWAN");
                break;
                
            case 2:
                NSLog(@"%@",@"AFNetworkReachabilityStatusReachableViaWiFi");
                break;
                
            default:
                break;
        }
        
    }];
}


//获取当前登录状态
+ (BOOL)getCurrentOfLoginStatus{
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"loginStatus"];
}

//获取当前时间
+ (NSString *)getCurrentTime{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate:date];
    return currentDateStr;
}

//写入登录状态
+ (void)keepLoginStatus{
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"loginStatus"];
}

//进行自动登录
+ (void)writeLoginAutomaticMarkOfState:(BOOL)state{
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:state forKey:@"automaticLogin"];
}
//是否自动登录
+ (BOOL)automaticLoginToServers{
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"automaticLogin"];
}

//label上添加图片和文字
+ (NSMutableAttributedString *)attributeText:(NSString *)text addImage:(NSString *)imageName direction:(BOOL)dir{
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:imageName];
    attch.bounds = CGRectMake(0, -5, 20, 20);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    if (dir) [attributed appendAttributedString:string];
    else{
        
        NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithAttributedString:string];
        [atr appendAttributedString:attributed];
        return atr;
    }
    
    return attributed;
}


#pragma mark -文件存储
/**
 * 文件创建 并返回创建的地址
 */
+ (NSString *)fileCreate:(NSString *)fileName {
    // 1.创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 2.获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    // 3.定义记录文件全名以及路径的字符串filePath
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    NSLog(@"filePath=%@", filePath);
    
    // 4.查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
    
}
/**
 * 文件获取 并返回文件的地址
 */
+ (NSString *)getFilePathFromDocument:(NSString *)fileName{
    //添加音频文件的路径
    NSArray *paths               = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath       = [NSString stringWithFormat:@"%@/userVoiceFiles/",[paths objectAtIndex:0]];
    NSString *fliePath           = [documentPath stringByAppendingString:fileName];
    return fliePath;
}
//添加用户的语音到document
+ (NSString *)saveUserVoiceToDocument:(NSString *)fileName{
    NSString *path = [NSString stringWithFormat:@"%@%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"/userVoiceFiles"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}
//添加医生的语音到document
+ (NSString *)saveDoctorVoiceToDocument:(NSString *)fileName{
    NSString *path = [NSString stringWithFormat:@"%@%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"/doctorVoiceFiles"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}

//播放Image序列动画
+ (void)goAnimationWithCount:(NSInteger)count imageView:(UIImageView *)imageview
{
    if ([imageview isAnimating]) {
        return;
    }
    NSMutableArray *arrayImage = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        NSString *name = [NSString stringWithFormat:@"wys_audio_tip%d",i];
        UIImage *image = [UIImage imageNamed:name];
        [arrayImage addObject:image];
    }
    imageview.animationImages = arrayImage;
    imageview.animationDuration = 1;
    imageview.animationRepeatCount = count;
    [imageview startAnimating];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC:(Class)aClass
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:aClass])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
+ (void)showAlertViewWithMessage:(NSString *)message showTimeInterval:(NSTimeInterval)timeInterval alertImage:(UIImage *)alertImage{
    NSInteger   length = message.length;
    
    UIWindow    *window = [[[UIApplication sharedApplication] delegate] window];
    
    UIView      *view = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth/4, (KScreenHeight - 80)/2, KScreenWidth/2, length>=12?100:80)];
    view.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7];
    view.layer.cornerRadius = 6;
    view.clipsToBounds = YES;
    window.userInteractionEnabled = NO;
    [window addSubview:view];
    
    UIImageView    *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth/2 - 40)/2, 10, 40, 40)];
    imageView.image = alertImage;
    
    UILabel         *label=[UILabel new];
    label.text =message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    //    if (IS_IPHONE5) {
    view.frame =CGRectMake(KScreenWidth/4-25, (KScreenHeight - 80)/2-60, KScreenWidth/2+50, length>=12?100:80);
    
    imageView.frame =CGRectMake((view.frame.size.width-40)/2, 10, 40, 40);
    label.font = [UIFont systemFontOfSize:14];
    label.frame =CGRectMake(10, 40, view.frame.size.width-20, 60);
    label.numberOfLines = 2;
    label.adjustsFontSizeToFitWidth = YES;
    
    //    }
    [view addSubview:imageView];
    [view addSubview:label];
    
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC);
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [view removeFromSuperview];
            window.userInteractionEnabled = YES;
        });
    });

}

// 点击是否有网
+(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }

    return isExistenceNetwork;
}


+ (NSString *)connectTelephone{
    NSString *telePhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"connectTelephone"];
    return  telePhone.length>0?telePhone:@"4006364998";
}

@end
