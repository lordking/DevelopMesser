//
//  AppShare.m
//  Pods
//
//  Created by 金磊 on 14-4-12.
//
//

#import "AppShare.h"
#import "DMDebug.h"



@interface AppShare ()
{
    NSMutableArray *_shareScenes;
}


@end


@implementation AppShare

- (void)registerScene:(AppScene)scene withAppID:(NSString *)appId type:(AppType)type
{
    ShareScene *shareScene = [[ShareScene alloc] init];
    shareScene.scene = scene;
    shareScene.appId = appId;
    shareScene.appType = type;
    [_shareScenes addObject:shareScene];
}

- (NSArray*)getShareScenes
{
    return _shareScenes;
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
