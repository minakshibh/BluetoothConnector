#import "AppDelegate.h"
#import "SplashViewController.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    for (NSString *fontFamilyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
            NSLog(@"Family: %@    Font: %@", fontFamilyName, fontName);
        }
    }
    // Override point for customization after application launch.
    [Parse enableLocalDatastore];
    
    [Parse setApplicationId:@"aWzlBXzi72l7TVhqh1Y4uLzlMXdZGJUVnCtfL9OY" clientKey:@"iXKWARGAc8iOEfRuon8TppaXeDyZJMVZjOdwGXB8"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self createCopyOfDatabaseIfNeeded];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //UINavigationController *nav;
    
    
    SplashViewController *scanVC=[[SplashViewController alloc]initWithNibName:@"SplashViewController" bundle:[NSBundle mainBundle]];
    
    self.navigator.interactivePopGestureRecognizer.enabled = NO;
    
    self.navigator=[[UINavigationController alloc]initWithRootViewController:scanVC];
    self.window.rootViewController=self.navigator;
    [self.window makeKeyAndVisible];
    
    return YES;
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)createCopyOfDatabaseIfNeeded {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"hangman.sqlite"];
    NSLog(@"db path %@", dbPath);
    
    NSLog(@"File exist is %hhd", [fileManager fileExistsAtPath:dbPath]);
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    if (!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hangman.sqlite"];
        NSLog(@"default DB path %@", defaultDBPath);
        
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success) {
            NSLog(@"Failed to create writable DB. Error '%@'.", [error localizedDescription]);
        } else {
            NSLog(@"DB copied.");
        }
    }else {
        NSLog(@"DB exists, no need to copy.");
    }
    
}

#pragma mark - Show Indicator

-(void)ShowIndicator
{
    
    activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    if (IS_IPHONE_5 )
    {
        activityIndicatorObject.center = CGPointMake(160, 250);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 700)];
    }
    else if (IS_IPHONE_4_OR_LESS )
    {
        activityIndicatorObject.center = CGPointMake(160, 250);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    }
    else if (IS_IPHONE_6)
    {
        activityIndicatorObject.center = CGPointMake(207, 250);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 700)];
    }
    else if(IS_IPHONE_6P)
    {
        activityIndicatorObject.center = CGPointMake(207, 250);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 800)];
    }
    else if(IS_IPAD_PRO){
        activityIndicatorObject.center = CGPointMake(512, 683);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 1366)];
    }
    else
    {
        activityIndicatorObject.center = CGPointMake(384, 512);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    }
    
    DisableView.backgroundColor=[UIColor blackColor];
    DisableView.alpha=0.5;
    [self.window addSubview:DisableView];
    
    activityIndicatorObject.color=[UIColor grayColor];
    [DisableView addSubview:activityIndicatorObject];
    [activityIndicatorObject startAnimating];
}

#pragma mark - Hide Indicator

-(void)HideIndicator
{
    [activityIndicatorObject stopAnimating];
    [DisableView removeFromSuperview];
    
}
@end
