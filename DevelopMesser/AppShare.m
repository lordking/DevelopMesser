//
//  AppShare.m
//  Pods
//
//  Created by 金磊 on 14-4-12.
//
//

#import "AppShare.h"
#import "DMDebug.h"

NSString * const SceneWXSession = @"wxSession";; //微信好友
NSString * const SceneWXTimeline = @"wxTimeline";; //微信朋友圈
NSString * const SceneWXFavorite = @"wxFavorite";;  //微信收藏

@interface AppShare ()
{
    NSMutableArray *_shareApp;
    NSArray *_scenes;
}

@end

@implementation AppShare

- (void)registerAppId:(NSString *)appId withAppType:(AppType)appType
{
    NSDictionary *shareScene = @{@"appId": appId,
                              @"appType": [NSNumber numberWithInt:appType]};
    
    [_shareApp addObject:shareScene];
}

- (void)setSupportScenes:(NSArray *)scenes
{
    _scenes = scenes;
}

- (void)share:(ShareContent *)shareContent withScene:(NSString*)scene
{
    DMPRINTMETHODNAME();
    
    if ([scene isEqualToString: SceneWXSession] ) {
        DMPRINT(@"分享到微信好友");
    } else if ([scene isEqualToString:SceneWXTimeline]) {
        DMPRINT(@"分享到微信朋友圈");
    } else if ([scene isEqualToString:SceneWXFavorite]) {
        DMPRINT(@"分享到微信收藏");
    }
}

- (void)share:(ShareContent *)shareContent withScenes:(NSArray *)scenes
{
    
}

+ (AppShare*)shared
{
    DMPRINTMETHODNAME();
    
    static AppShare *class;
    static dispatch_once_t onceToken;
    
    //单例模式的实例化。实例化默认调用init
    dispatch_once(&onceToken, ^{
        class = [AppShare new];
    });
    
    return class;
}

@end
