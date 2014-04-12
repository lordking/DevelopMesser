//
//  AppShare.h
//  Pods
//
//  Created by 金磊 on 14-4-12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ShareScene.h"

@interface AppShare : NSObject

/*!
 *  采用单例模式实例化对象
 *
 *  @return 实例化的单例对象
 */
+ (AppShare*)shared;

/*!
 *  注册分享场景。
 *
 *  @param scene 开放平台定义的应用场景
 *  @param appId 应用ID，一般为在开放平台上注册的AppID
 * @param type  开放平台的类型
 */
- (void)registerScene:(AppScene)scene withAppID:(NSString*)appId type:(AppType)type;

/*!
 *  获取当前可使用的分享模块)。获取之前，需要注册AppID和分享场景。
 *
 *  @return (ShareScene的Array数组
 */
- (NSArray*)getShareScenes;

@end



