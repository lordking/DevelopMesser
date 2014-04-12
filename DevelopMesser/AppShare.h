//
//  AppShare.h
//  Pods
//
//  Created by 金磊 on 14-4-12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AppType) {
    APP_TYPE_WEIXIN,    //微信
    APP_TYPE_QQ,        //QQ
    APP_TYPE_SINAWEIBO      //新浪微博
};

typedef NS_ENUM(NSInteger, AppScene) {
    WXSceneSession  = 0,        /**< 聊天界面    */
    WXSceneTimeline = 1,        /**< 朋友圈      */
    WXSceneFavorite = 2,        /**< 收藏       */
};

@interface AppShare : NSObject

/*!
 *  采用单例模式实例化对象
 *
 *  @return <#return value description#>
 */
+ (AppShare*)shared;

/*!
 *  注册AppID
 *
 *  @param appId <#appId description#>
 *  @param type  <#type description#>
 *  @param scene <#scene description#>
 */
- (void)registerAppId:(NSString*)appId withAppType:(AppType)type AppScene:(AppScene)scene;

/*!
 *  获取当前可使用的分享模块。根据注册的AppID来定。
 *
 *  @return <#return value description#>
 */
- (NSArray*)getShareScene;

@end

/*!
 *  分享模块的模型组成
 */
@interface shareModule : NSObject

@property (nonatomic) AppType type;
@property (nonatomic) AppScene scene;
@property (nonatomic, strong) UIImage *image;

@end
