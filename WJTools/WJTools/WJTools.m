//
//  WJTools.h
//  Kevin
//
//  Created by Kevin on 13/1/14.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//  自定义工具类

#import "WJTools.h"
#import <AdSupport/AdSupport.h>
#import "iHasApp.h"
#import "SSKeychain.h"

@implementation WJTools

#pragma mark - 外部调用方法

/** 检查手机内是否已安装微博 */
+ (void)isHasWeiboWithHaveApp : (void (^)(void))haveAppBlock orHaveNoApp : (void (^)(void))haveNoAppBlock
{
    NSNumber * weiboID = @(386098453); // 微博有3个id : 350962117 , 422038334
    [self isHasAppWithAppID:weiboID WithHaveApp:haveAppBlock orHaveNoApp:haveNoAppBlock];

}

/** 检查手机内是否已安装QQ */
+ (void)isHasQQWithHaveApp : (void (^)(void))haveAppBlock orHaveNoApp : (void (^)(void))haveNoAppBlock
{
    NSNumber * QQAppID = @(444934666);
 
    [self isHasAppWithAppID:QQAppID WithHaveApp:haveAppBlock orHaveNoApp:haveNoAppBlock];
}

/** 检查手机内是否已安装微信 */
+ (void)isHasWechatWithHaveApp : (void (^)(void))haveAppBlock orHaveNoApp : (void (^)(void))haveNoAppBlock
{
    NSNumber * wechatID = @(414478124);
    [self isHasAppWithAppID:wechatID WithHaveApp:haveAppBlock orHaveNoApp:haveNoAppBlock];
}

/** 复制字符串到手机剪切板 */
+ (void)copyStringToPasteboard : (NSString *)string
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = string;

}

/** 获取当前app的版本号 */
+ (NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return nowVersion.length > 0 ? nowVersion : @"";
}

/** 获取设备的唯一标识符号 (目前用的是IDFA) */
+ (NSString *)getDeviceIdentifitier
{
    
    NSString * IDFA = [SSKeychain passwordForService:@"test" account:@"Identifier"];
    
//    NSLog(@"钥匙串获取到 : %@",IDFA);
    
    if ([IDFA isKindOfClass:[NSString class]] && IDFA.length > 0)
        return IDFA;
 
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    NSLog(@"生成IDFA : %@",adId);
    if (adId.length < 1)
        return @"";
    
    [SSKeychain setPassword:adId forService:@"test" account:@"Identifier"];

    return adId;
}

#pragma mark - 内部处理方法

/** 根据应用ID判断程序内是否已安装该应用程序 (需要在第三方iHasApp框架的schemeApps.json文件中配置相关AppID) */
+ (void)isHasAppWithAppID : (NSNumber *)appID WithHaveApp : (void (^)(void))haveAppBlock orHaveNoApp : (void (^)(void))haveNoAppBlock
{
    
    [[[iHasApp alloc] init] detectAppIdsWithIncremental:nil withSuccess:^(NSArray *appIds) {
        
        if (appIds.count < 1)
        {
            haveNoAppBlock();
            return ;
        }
        
        [appIds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if ([appID isEqualToNumber:obj])
            {
                *stop = YES;
                haveAppBlock();
                return ;
            }
            else if (idx == appIds.count - 1)
            {
                
                haveNoAppBlock();
                return;
            }
            
        }];
        
    } withFailure:^(NSError *error) {
        
        haveNoAppBlock();
        
    }];
    
}

@end