//
//  AppDelegate.m
//  edecorate
//
//  Created by hxx on 9/16/14.
//
//

#import "AppDelegate.h"
#import "APService.h"
#import "HNHomeViewController.h"
#import "HNLoginViewController.h"
#import "MBProgressHUD.h"

@implementation AppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    //    HNHomeViewController *homeViewController = [[HNHomeViewController alloc] init];
    [self configureNavigationAppearance];
    HNHomeViewController *homeViewController = [[HNHomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    self.window.rootViewController = nav;
    nav.navigationBar.translucent = NO;
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

    //    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    return YES;
}

- (void)configureNavigationAppearance{
    UIImage *arrowImage = [[UIImage  imageNamed:@"arrowBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 27, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:arrowImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0]];
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0],
    //                                                           NSFontAttributeName : [UIFont systemFontOfSize:18]
    //                                                           }];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
    //使用UUID设置别名
    NSString *alias = [[[[[UIDevice currentDevice]identifierForVendor] UUIDString]stringByReplacingOccurrencesOfString:@"-" withString:@""]uppercaseString];
    [APService setAlias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"123:%@",userInfo);
//    NSDictionary *dic = [userInfo objectForKey:@"aps"];
//    NSString *str = [dic objectForKey:@"alert"];
//    if ([str length]>1) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//        hud.dimBackground = YES;
//        [hud setLabelText:[NSString stringWithFormat:@"收到消息:\n%@", str]];
//        NSLog(@"%@",[NSString stringWithFormat:@"收到消息:\n%@", str]);
//        [hud hide:YES afterDelay:1.5f];
//    }
    [APService handleRemoteNotification:userInfo];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias {
    NSString *callbackString = [NSString stringWithFormat:@"%d, alias: %@\n", iResCode, alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
    if (iResCode != 0){
        NSLog(@"注册别名失败");
    }
}

//avoid compile error for sdk under 7.0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%@",userInfo);
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.dimBackground = YES;
    [hud setLabelText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    NSLog(@"%@",[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]);
    [hud hide:YES afterDelay:1.5f];
    //    [dateFormatter release];
}
@end
