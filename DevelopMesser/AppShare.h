//
//  AppShare.h
//  Pods
//
//  Created by 金磊 on 14-4-12.
//
//

#import <Foundation/Foundation.h>
#import "ShareContent.h"


typedef NS_ENUM(NSInteger, AppType) {
    AppTypeWX,          //微信
    AppTypeQQ,          //QQ
    AppTypeSinaWeibo    //新浪微博
};

//分享平台的应用场景

FOUNDATION_EXPORT NSString * const SceneWXSession; //微信好友
FOUNDATION_EXPORT NSString * const SceneWXTimeline; //微信朋友圈
FOUNDATION_EXPORT NSString * const SceneWXFavorite;  //微信收藏

@interface AppShare : NSObject

/*!
 *  采用单例模式实例化对象
 *
 *  @return 实例化的单例对象
 */
+ (AppShare*)shared;


/**
 *  注册开放平台的AppID
 *
 *  @param appId
 *  @param appType <#appType description#>
 */
- (void)registerAppId:(NSString*)appId withAppType: (AppType)appType;

/**
 *  注册需要支持的应用场景。应用场景由AppScene定义。
 *
 *  @param scenes 需要应用场景组成的数组。
 */
- (void)setSupportScenes:(NSArray*)scenes;


/*!
 *  分享内容到单个场景。
 *
 *  @param shareContent
 *  @param appId        <#appId description#>
 *  @param scene        <#scene description#>
 */
- (void)share:(ShareContent*)shareContent withScene:(NSString*)scene;

/*!
 *  一键分享内容到多个场景。微信不能一键分享。
 *
 *  @param shareContent <#shareContent description#>
 *  @param scenes       <#scenes description#>
 */
- (void)share:(ShareContent*)shareContent withScenes:(NSArray*)scenes;

@end



