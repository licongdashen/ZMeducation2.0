//
//  CACUtility.h
//  cacwallte
//
//  Created by Queen on 2017/4/25.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACUtility : NSObject

/**
 提示框 1.2秒消失

 @param tips 提示内容
 */
+ (void)showTips:(NSString *)tips;
//检测银行卡号正确性
+ (BOOL)checkBankCardNumber:(NSString *)bankCardNo;
//检测身份证号是否正确(高强度验证)
+ (BOOL)checkIDNum:(NSString *)str;
//出生日期和性别与身份证号匹配的方法
+ (NSString *)checkIDNum:(NSString *)str bith:(NSString *)birth gender:(NSString *)gender;
//性别与身份证号匹配的方法
+ (NSString *)checkIDNum:(NSString *)str gender:(NSString *)gender;
//获取用户头像
+ (UIImage *)getUserHeadPortraitImage:(NSString *)headName;
//获取消息图片
+ (UIImage *)getUserMessageImage:(BOOL)login;
/** 检测头像文件是否存在 */
+ (BOOL)checkUserHeadImageFileExists:(NSString *)headName;
//传入一个时间戳，获取指定格式的时间
+ (NSString *)getNewDateWithFormatter:(NSString *)formatter oldDate:(NSString *)oldDate;
//当前时间，加减年月日
+ (NSString *)getNewDateWithFormatter:(NSString *)formatter AddYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
//计算指定字符串的Size
+ (CGSize )getStringSize:(NSString*)l_str_input font:(UIFont*)l_font width:(CGFloat)l_width;
//计算指定字符串的高
+ (CGFloat)getStringHeight:(NSString*)l_str_input font:(UIFont*)l_font width:(CGFloat)l_width;
//判断字符串是否为空
+ (BOOL) isBlankString:(NSString*)string;
//获取颜色（16进制）
+ (UIColor *)getColorFromRGB:(NSString *)inColorString;
//验证注册用户名格式
+ (BOOL) validateUserName:(NSString *)userName;
//验证邮箱格式
+ (BOOL)validateEmail:(NSString *)email;
//验证密码格式
+ (BOOL)validatePassword:(NSString *)passWord;
//验证密码格式（只包含字母）
+ (BOOL)validatePasswordWithOnlyLetter:(NSString *)passWord;
//验证密码格式（只包含数字）
+ (BOOL)validatePasswordWithOnlyNum:(NSString *)passWord;
//验证密码格式(6-20位，不能纯数字或纯字母,可包含符号)
+ (BOOL)validatePasswordWithLetterAndNum:(NSString *)passWord;
//验证真实姓名（汉字或英文名）
+ (BOOL)validateRealName:(NSString *)realName;
//验证手机号码（13，14，15，17，18开头的）
+ (BOOL)validateTelephoneNum:(NSString *)telephone;
//验证身份证号（15或18位）
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
//验证数字（大于0的整数）
+ (BOOL)validateNumber: (NSString *)number;
//排除特殊符号
+ (BOOL)validateSpecialSymbols: (NSString *)symbols;
//验证固定号码
+ (BOOL)validateHomephone:(NSString *)homephone;
//验证数字（非负，可小数）
+ (BOOL)validateWithDecimalNumbers:(NSString *)num;
//验证网址url
+ (BOOL)validateWithURL:(NSString *)urlStr;
//Unicode转化为汉字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
//utf-8转Unicode
+ (NSString *)utf8ToUnicode:(NSString *)string;
//计算字符串大小
+ (CGSize)autoCalculateRectWithSingleText:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
//得到UUID
+ (NSString*)getUUID;
//手机型号
+ (NSString *)getPhoneModel;
//加密验证码
+ (NSString *)encryptCode:(NSString*)phoneNo imgCode:(NSString*)imgCode;
//昵称(字母或数字)
+ (BOOL)validateNickName:(NSString *)nickname;
//时间戳转换为  xx天xx小时xx分:xx秒 的格式
+ (NSString *)dateMMssFromString:(NSString *)dateString;
/**
 *  风火轮
 *
 *  @param _targetView 显示提示框的视图
 *  @param _msg 内容
 */
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

//隐藏风火轮
+ (void)hideMBProgress:(UIView*)_targetView;
/**
 *  动态算出文本大小
 *
 *  @param size   限制宽高
 *  @param font   字体的大小
 *  @param spacing 行间距
 *  @param string 内容
 *
 *  @return cgsize
 */
+(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font string:(NSString*)string withSpacing:(CGFloat)spacing;

+(NSString *)getNowTime;

+(NSString *)getSignWithMethod:(NSString *)method;
@end
