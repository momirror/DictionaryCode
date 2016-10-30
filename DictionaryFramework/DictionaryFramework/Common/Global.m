//
//  Global.m
//  FamilyPhone
//
//  Created by msp on 14-10-21.
//  Copyright (c) 2014年 msp. All rights reserved.
//

#import "Global.h"

#import <AddressBook/AddressBook.h>
@implementation Global

/**
 *  实现一些使用频率较高的通用函数
 */

NSMutableArray * allPeoples = nil;


/**
 *  把unicode编码的字符串转换为utf8
 *
 *  @param unicodeStr unicode字符串
 *
 *  @return utf8格式字符串
 */
+ (NSString *)convertUnicodeToUTF8:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

/**
 *  十进制转换为二进制
 *
 *  @param iValue 10进制值
 *
 *  @return 二进制字符串
 */
+ (NSString*)intValueToBinaryString:(int)iValue
{
    NSAssert(iValue >= 0, @"二进制转换不支持负数");
    
    if(iValue == 0)
    {
        return @"0";
    }
    
    
    
    NSString * strResult = [[NSString alloc] init];
    int iResult = iValue;
    
    while (iResult != 0)
    {
        int iNum = iValue % 2;
        iResult = iValue / 2;
        
        
        strResult = [strResult stringByAppendingString:[NSString stringWithFormat:@"%d",iNum]];
        
        
        iValue = iResult;
    }
    
    return [self reverseString:strResult];
}

/**
 *  字符串反转
 *
 *  @param strValue 要反转的字符串
 *
 *  @return 已经反转的字符串
 */
+ (NSString*)reverseString:(NSString*)strValue
{
    int iLength = [strValue length];
    
    NSMutableString *reversedString;
    
    reversedString = [[NSMutableString alloc] initWithCapacity: iLength];
    
    while (iLength > 0) {
        
        [reversedString appendString:[NSString stringWithFormat:@"%C", [strValue characterAtIndex:--iLength]]];
        
    }
    
    return reversedString;
    
}



// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    //    return YES;//先不判断
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //    NSString * PHS =  @"(^[0-9]{7,8}$)";//判断7～8位数字
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum])
        || ([regextestcm evaluateWithObject:mobileNum])
        || ([regextestct evaluateWithObject:mobileNum])
        || ([regextestcu evaluateWithObject:mobileNum])
        //        ||([regextestphs evaluateWithObject:mobileNum])
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  从字符串中筛选出数字
 */
+ (NSString*)findNumFromStr:(NSString*)strPhone
{
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:strPhone];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    
    return numberString;
}


/**
 *  设置边框样式
 *
 *  @param fWidth  边框宽度
 *  @param color   颜色
 *  @param fRadius 圆角半径
 *  @param view    要设置的view
 */
+ (void)setBorderWidth:(float)fWidth Color:(UIColor *)color CornerRadius:(float)fRadius ForView:(UIView*)view
{
    
    
    [view.layer setMasksToBounds:YES];
    view.layer.borderWidth = fWidth;
    view.layer.borderColor = color.CGColor;
    view.layer.cornerRadius = fRadius;
}

/**
 *  简单的信息提示，无回调
 *
 *  @param strMessage 提示信息
 */
+ (void)showAlertMessage:(NSString*)strMessage
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:strMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:LocalString(@"alertview_OK"), nil];
    [alertView show];
}


/**
 *  获取Document路径
 *
 */
+ (NSString*)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = nil;
    if(paths)
    {
        documentsDirectory = [paths objectAtIndex:0];
    }
    
    return documentsDirectory;
}

/**
 *  string转化为date
 *
 *  @param dateString 要转换的string,格式为“年-月-日 时：分：秒”
 *
 *  @return 转换后的date
 */
+ (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}


/**
 *  把date格式化为年-月-日 时：分：秒的字符串
 *
 *  @param date 日期
 *
 *  @return 转换结果
 */
+ (NSString *)stringFromDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

/**
 *  获取当前时间，包括时区偏移
 *
 *  @return 获取到的日期
 */
+ (NSDate*)getCurrentDate
{
    NSDate * date = [NSDate date];
    //    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    //    date = [date dateByAddingTimeInterval:timeZoneOffset];
    
    return date;
}

/**
 *  为指定的视图添加背景图片
 *
 *  @param strImageName 图片名称
 *  @param view         添加背景的视图
 *
 *  @return 背景
 */
+ (UIImageView*)addBackgroundImage:(NSString*)strImageName toView:(UIView*)view
{
    UIImageView *pBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    if(pBackgroundImage == nil)
    {
        return nil;
    }
    
    [pBackgroundImage setImage:[UIImage imageNamed:strImageName]];
    [view addSubview:pBackgroundImage];
    
    return pBackgroundImage;
}

/**
 *  添加一个label到指定的视图中
 *
 *  @param view    视图
 *  @param frame   frame
 *  @param strText text
 *  @param iTag    tag
 *
 *  @return label
 */
+ (UILabel*)addLableToView:(UIView*)view frame:(CGRect)frame text:(NSString*)strText tag:(int)iTag
{
    UILabel *pLable = [[UILabel alloc] initWithFrame:frame];
    [pLable setBackgroundColor:[UIColor clearColor]];
    if(pLable == nil)
    {
        NSLog(@"alloc UILabel failed");
        return nil;
    }
    [pLable setFont:[UIFont systemFontOfSize:14]];
    [pLable setText:strText];
    
    //自动换行
    pLable.lineBreakMode = UILineBreakModeWordWrap;
    pLable.numberOfLines = 0;
    
    [pLable setTag:iTag];
    [view  addSubview:pLable];
    
    return pLable;
}

/**
 *  添加一个指定的textField到指定的视图中
 *
 *  @param view        视图
 *  @param frame       frame
 *  @param strText     text
 *  @param strHoldText 占位文字
 *  @param iTag        tag
 *
 *  @return textField
 */
+ (UITextField*)addTextFieldToView:(UIView*)view frame:(CGRect)frame text:(NSString*)strText holdText:(NSString*)strHoldText tag:(int)iTag
{
    UITextField *pField  = [[UITextField alloc] initWithFrame:frame];
    if(pField == nil)
    {
        NSLog(@"alloc UITextField failed");
        return nil;
    }
    [pField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [pField setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [pField setText:strText];
    [pField setPlaceholder:strHoldText];
    [pField setTag:iTag];
    
    [view addSubview:pField];
    
    return pField;
    
}


/**
 *  添加一个指定的textView到指定的视图中
 *
 *  @param view        视图
 *  @param frame       frame
 *  @param strText     text
 *  @param strHoldText 占位文字
 *  @param iTag        tag
 *
 *  @return textField
 */
+ (UITextView*)addTextViewToView:(UIView*)view frame:(CGRect)frame text:(NSString*)strText tag:(int)iTag
{
    UITextView *pView  = [[UITextView alloc] initWithFrame:frame];
    if(pView == nil)
    {
        NSLog(@"alloc UITextField failed");
        return nil;
    }
    [pView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [pView setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [pView setText:strText];
    [pView setTag:iTag];
    
    [view addSubview:pView];
    
    return pView;
    
}

/**
 *  添加一个button到指定的视图中
 *
 *  @param view     视图
 *  @param frame    frame
 *  @param strTitle 标题
 *  @param norName  普通状态下的图片名称
 *  @param highName 高亮状态下的图片名称
 *  @param target target
 *  @param action 响应方法
 *  @param iTag     tag
 *
 *  @return button
 */
+ (UIButton *)addButtonToView:(UIView*)view frame:(CGRect)frame title:(NSString*)strTitle normalImageName:(NSString*)norName   highLightImageName:(NSString*)highName target:(id)target action:(SEL)sel tag:(int)iTag
{
    UIButton *pButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(pButton == nil)
    {
        NSLog(@"init button failed");
        return nil;
    }
    
    pButton.frame = frame;
    [pButton setTitle:strTitle forState:UIControlStateNormal];
    if(norName)
    {
        [pButton setBackgroundImage:[UIImage imageNamed:norName] forState:UIControlStateNormal];
    }
    
    if(highName)
    {
        [pButton setBackgroundImage:[UIImage imageNamed:highName] forState:UIControlStateSelected];
    }
    pButton.tag = iTag;
    [pButton addTarget:target action:sel  forControlEvents:UIControlEventTouchUpInside];
    [pButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [view addSubview:pButton];
    
    return pButton;
    
}

/**
 *  添加一个scrollview到指定的视图中
 *
 *  @param view  视图
 *  @param frame frame
 *  @param iTag  tag
 *
 *  @return scrollview
 */
+(UIScrollView*)addScrollViewToView:(UIView*)view frame:(CGRect)frame Tag:(NSInteger)iTag
{
    UIScrollView *pScrollView = [[UIScrollView alloc] initWithFrame:frame];
    if(pScrollView == nil)
    {
        NSLog(@"alloc scroll view failed");
        return nil;
    }
    
    [pScrollView setTag:iTag];
    [pScrollView setBackgroundColor:[UIColor clearColor]];
    [view addSubview:pScrollView];
    
    return pScrollView;
}

/**
 *  添加一张图片到指定的视图中
 *
 *  @param view         视图
 *  @param frame        frame
 *  @param strImageName 图片名称
 *  @param iTag         tag
 *
 *  @return imageView
 */
+ (UIImageView*)addImageViewToView:(UIView*)view frame:(CGRect)frame imageName:(NSString*)strImageName Tag:(int)iTag
{
    UIImageView *pImageView = [[UIImageView alloc] initWithFrame:frame];
    if(pImageView == nil)
    {
        NSLog(@"alloc imageview failed");
        return nil;
    }
    
    [pImageView setTag:iTag];
    [pImageView setImage:[UIImage imageNamed:strImageName]];
    
    [view addSubview:pImageView];
    
    return pImageView;
}

/**
 *  添加一条灰色的分隔线到指定的视图中
 *
 *  @param view  视图
 *  @param frame frame
 *
 *  @return 分隔线
 */
+ (UIView*)addGraySeperatorLineToView:(UIView*)view frame:(CGRect)frame
{
    UIView * lineView = [[UIView alloc] initWithFrame:frame];
    [lineView setBackgroundColor:[UIColor grayColor]];
    [view addSubview:lineView];
    
    return lineView;
}



/**
 *  添加一个view到指定的视图中
 *
 *  @param view  视图
 *  @param frame frame
 *  @param iTag  tag
 *
 *  @return 添加的view
 */
+ (UIView *)addViewToView:(UIView*)view frame:(CGRect)frame tag:(int)iTag
{
    UIView * tmpView = [[UIView alloc] initWithFrame:frame];
    [tmpView setBackgroundColor:[UIColor clearColor]];
    tmpView.tag = iTag;
    [view addSubview:tmpView];
    return tmpView;
}


/**
 *  添加一个table到指定的视图中
 *
 *  @param view       视图
 *  @param frame      frame
 *  @param delegate   代理
 *  @param dataSource 数据源
 *
 *  @return table
 */
+ (UITableView*)addTableViewToView:(UIView*)view frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource
{
    UITableView * table = [[UITableView alloc] initWithFrame:frame];
    table.delegate = delegate;
    table.dataSource = dataSource;
    [table setBackgroundColor:[UIColor clearColor]];
    
    [view addSubview:table];
    
    return table;
}


/**
 *  展示大小渐变动画
 *
 *  @param startFrame 起始frame
 *  @param endFrame   结束frame
 *  @param fTime      时间
 *  @param view       动画视图
 */
+ (void)showAnimation:(CGRect)startFrame ShowRect:(CGRect)endFrame Time:(float)fTime View:(UIView*)view
{
    [view setFrame:startFrame];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:fTime];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [view setFrame:endFrame];
    [UIView commitAnimations];
}


/**
 *  取消预定的本地消息通知
 *
 *  @param strKey 消息的key
 */
+ (void)cancelLocalNotification:(NSString*)strKey
{
    UIApplication *app = [UIApplication sharedApplication];
    
    //获取本地推送数组
    NSArray *localArr = [app scheduledLocalNotifications];
    
    //声明本地通知对象
    UILocalNotification *localNoti;
    
    if (localArr)
    {
        for (UILocalNotification *noti in localArr)
        {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"nfkey"];
                
                if ([inKey isEqualToString:inKey]) {
                    localNoti = noti;
                    break;
                }
                
            }
            
        }
        
        //判断是否找到已经存在的相同key的推送
        
        if (localNoti)
        {
            //不推送 取消推送
            [app cancelLocalNotification:localNoti];
        }
        
    }
}




/**
 *
 *
 *  @param lotification <#lotification description#>
 */
+ (void)cancelSpecialLotification:(UILocalNotification*)lotification
{
    UIApplication *app = [UIApplication sharedApplication];
    [app cancelLocalNotification:lotification];
}

///**
// *  使控件暂时不能点击
// *
// *  @param iSecond 时间(秒)
// */
//+ (void)disableViewAWhile:(float)fSecond view:(UIView*)view
//{
//    [view setUserInteractionEnabled:NO];
//    [NSTimer scheduledTimerWithTimeInterval:fSecond target:self selector:@selector(enableView:) userInfo:view repeats:NO];
//}
//
//
//- (void)enableView:(NSTimer*)timer
//{
//    UIView * view = timer.userInfo;
//    [view setUserInteractionEnabled:YES];
//}



// 正则URL格式
+ (BOOL)isURL:(NSString *)strValue
{
    NSString * strFormat =  @"http+:[^\\s]*";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strFormat];
    
    if ([regextestmobile evaluateWithObject:strValue])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*去掉小数后面的0*/
+ (NSString*)getEffeciveNum:(float)fValue
{
    NSString * strValue = [NSString stringWithFormat:@"%f",fValue];
    
    int iEffictivePosition = [strValue length];
    
    for(int i = [strValue length] - 1; i >= 0; i--)
    {
        char c = [strValue characterAtIndex:i];
        
        if(c == '0')
        {
            iEffictivePosition--;
        }
        else
        {
            break;
        }
    }
    
    strValue = [strValue substringToIndex:iEffictivePosition];
    
    return strValue;
}


+ (void)setValue:(id)value forKey:(NSString*)strKey
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getValueForKey:(NSString*)strKey
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:strKey];
}

/**
 *  判断当前语言环境
 *
 *  @return 当前语言
 */
+ (int)currentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];

//    if([currentLanguage isEqualToString:@"en"])
//    {
//        return LANGUAGE_ENGLISH;
//    }
//    else if([currentLanguage isEqualToString:@"zh-Hans"])
//    {
//        return LANGUAGE_CHINESE;
//    }
//    
//    return LANGUAGE_UNKNOW;
    return 0;
}

/**
 *  获取当前时间戳，用作MSGID
 *
 *  @return 时间戳
 */
+ (NSString*)getTimestamp
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    
    [dateformat setDateFormat:@"yyMMddHHmmss"];
    
    return  [dateformat stringFromDate:[NSDate date]];
}

/**
 *  字符串去首尾空格
 *
 *  @param string 要去空格的字符串
 *
 *  @return 结果
 */
+ (NSString*)stringByTrimmingwhitespaceCharacter:(NSString*)string
{
    NSString * result = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return result;
}


@end
