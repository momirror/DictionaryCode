//
//  Global.h
//  FamilyPhone
//
//  Created by msp on 14-10-21.
//  Copyright (c) 2014年 msp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY_SHOW_NETWORK_STATE @"KEY_SHOW_NETWORK_STATE"
#define LocalString(string) NSLocalizedString(string,nil)

enum
{
    LANGUAGE_UNKNOW = -1,
    LANGUAGE_CHINESE,
    LANGUAGE_ENGLISH,
}LanguageType;

/**
 *  实现一些使用频率较高的通用函数
 */


@interface Global : NSObject

+ (NSString *)convertUnicodeToUTF8:(NSString *)unicodeStr;
+ (NSString*)intValueToBinaryString:(int)iValue;
+ (NSString*)reverseString:(NSString*)strValue;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (NSString*)findNumFromStr:(NSString*)strPhone;

+ (void)setBorderWidth:(float)fWidth Color:(UIColor *)color CornerRadius:(float)fRadius ForView:(UIView*)view;

+ (void)showAlertMessage:(NSString*)strMessage;

+ (NSString*)getDocumentPath;

+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSDate*)getCurrentDate;



+ (UIImageView*)addBackgroundImage:(NSString*)strImageName toView:(UIView*)view;

+ (UILabel*)addLableToView:(UIView*)view frame:(CGRect)frame text:(NSString*)strText tag:(int)iTag;

+ (UITextField*)addTextFieldToView:(UIView*)view frame:(CGRect)frame text:(NSString*)strText holdText:(NSString*)strHoldText tag:(int)iTag;

+ (UITextView*)addTextViewToView:(UIView*)view frame:(CGRect)frame text:(NSString*)strText tag:(int)iTag;

+ (UIButton *)addButtonToView:(UIView*)view frame:(CGRect)frame title:(NSString*)strTitle normalImageName:(NSString*)norName   highLightImageName:(NSString*)highName target:(id)target action:(SEL)sel tag:(int)iTag;

+(UIScrollView*)addScrollViewToView:(UIView*)view frame:(CGRect)frame Tag:(NSInteger)iTag;

+ (UIImageView*)addImageViewToView:(UIView*)view frame:(CGRect)frame imageName:(NSString*)strImageName Tag:(int)iTag;

+ (UIView*)addGraySeperatorLineToView:(UIView*)view frame:(CGRect)frame;



+ (UITableView*)addTableViewToView:(UIView*)view frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource;

+ (void)showAnimation:(CGRect)startFrame ShowRect:(CGRect)endFrame Time:(float)fTime View:(UIView*)view;

+ (void)cancelLocalNotification:(NSString*)strKey;


+ (void)cancelSpecialLotification:(UILocalNotification*)lotification;

+ (UIView *)addViewToView:(UIView*)view frame:(CGRect)frame tag:(int)iTag;

//+ (void)disableViewAWhile:(float)fSecond view:(UIView*)view;
+ (BOOL)isURL:(NSString *)strValue;
+ (NSString*)getEffeciveNum:(float)fValue;

+ (void)setValue:(id)value forKey:(NSString*)strKey;
+ (id)getValueForKey:(NSString*)strKey;

+ (int)currentLanguage;

+ (NSString*)getTimestamp;

+ (NSString*)stringByTrimmingwhitespaceCharacter:(NSString*)string;

+ (void)showMessage:(NSString*)message time:(float)time inView:(UIView*)view;
@end
