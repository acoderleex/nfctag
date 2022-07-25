//
//  AppDelegate.m
//  NFCDemo
//
//  Created by Tony on 2022/6/24.
//

#import "AppDelegate.h"
#import "WXApiManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString *log) {
        NSLog(@"WeChatSDK: %@", log);
    }];
    
    
    [WXApi registerApp:@"wx67d80e0d013261c1" universalLink:@"https://www.fenghuoxing.cn"];
    
    //调用自检函数
    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
        NSLog(@"checkUniversalLinkReady %@, %u, %@, %@", @(step), result.success, result.errorInfo, result.suggestion);
    }];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler
{
    return [WXApi handleOpenUniversalLink:userActivity delegate:[WXApiManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
