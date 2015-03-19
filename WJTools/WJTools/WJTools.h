//
//  WJTools.h
//  Kevin
//
//  Created by Kevin on 13/1/14.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//  自定义工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJTools : NSObject

/** 检查手机内是否已安装微博 */
+ (void)isHasWeiboWithHaveApp : (void (^)(void))haveAppBlock orHaveNoApp : (void (^)(void))haveNoAppBlock;

/** 检查手机内是否已安装QQ */
+ (void)isHasQQWithHaveApp : (void (^)(void))haveAppBlock orHaveNoApp : (void (^)(void))haveNoAppBlock;

/** 检查手机内是否已安装微信 */
+ (void)isHasWechatWithHaveApp : (void (^)(void))haveAppBlock orHaveNoApp : (void (^)(void))haveNoAppBlock;

/** 复制字符串到手机剪切板 */
+ (void)copyStringToPasteboard : (NSString *)string;

/** 获取当前app的版本号 */
+ (NSString *)getAppVersion;

/** 获取设备的唯一标识符号 (目前用的是IDFA) */
+ (NSString *)getDeviceIdentifitier;

@end




