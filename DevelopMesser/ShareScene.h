//
//  ShareScene.h
//  Pods
//
//  Created by 金磊 on 14-4-12.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppType) {
    AppTypeWX,          //微信
    AppTypeQQ,          //QQ
    AppTypeSinaWeibo    //新浪微博
};

typedef NS_ENUM(NSInteger, AppScene) {
    ShareWXSceneSession  = 0,        /**< 微信聊天界面    */
    ShareWXSceneTimeline = 1,        /**< 微信朋友圈      */
    ShareWXSceneFavorite = 2,        /**< 微信收藏       */
};

/*!
 *  分享模块的模型组成
 */
@interface ShareScene:NSObject

@property (nonatomic) AppScene scene;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic) AppType appType;

@end