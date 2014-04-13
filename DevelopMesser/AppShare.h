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
#import "ShareContent.h"

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
- (void)registerShareScene:(ShareScene*)scene;


/*!
 *  获取当前可使用的分享模块)。获取之前，需要注册AppID和分享场景。
 *
 *  @return (ShareScene的Array数组
 */
- (NSArray*)getShareScenes;


/*!
 *  分享内容到单个场景。
 *
 *  @param shareContent <#shareContent description#>
 *  @param appId        <#appId description#>
 *  @param scene        <#scene description#>
 */
- (void)share:(ShareContent*)shareContent withScene:(ShareScene*)scene;

/*!
 *  一键分享内容到多个场景。微信不能一键分享。
 *
 *  @param shareContent <#shareContent description#>
 *  @param scenes       <#scenes description#>
 */
- (void)share:(ShareContent*)shareContent withScenes:(NSArray*)scenes;

@end



