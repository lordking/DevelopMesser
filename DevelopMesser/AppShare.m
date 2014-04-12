//
//  AppShare.m
//  Pods
//
//  Created by 金磊 on 14-4-12.
//
//

#import "AppShare.h"
#import "DMDebug.h"

@implementation AppShare

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
