

#import "SplashViewController.h"
#import "AppDelegate.h"
#import "loginViewController.h"
#import "scanViewController.h"
#import <Parse/PFUser.h>
@interface SplashViewController ()

@end


@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.navigator.navigationBarHidden = YES;
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(presentnextView) userInfo:nil repeats:NO];
}
- (void)presentnextView
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        scanViewController *scanVC;
        
        // Made some changes for logout functionality.
        loginViewController* loginview = [[loginViewController alloc] initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        [navigationArray addObject:loginview];  // You can pass your index here
        self.navigationController.viewControllers = navigationArray;
        
        
        if (IS_IPAD) {
            scanVC=[[scanViewController alloc]initWithNibName:@"scanViewController" bundle:[NSBundle mainBundle]];
        }else if (IS_IPHONE){
            scanVC=[[scanViewController alloc]initWithNibName:@"scanViewController" bundle:[NSBundle mainBundle]];
        //this is iphone 5 xib
        }
        [self.navigationController pushViewController:scanVC animated:NO];
    } else {
        loginViewController *loginVC;
        if (IS_IPAD) {
            loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController_ipad" bundle:[NSBundle mainBundle]];
        }else if (IS_IPHONE){
            loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
            //this is iphone 5 xib
        }
        //this is iphone 5 xib
        
        [self.navigationController pushViewController:loginVC animated:NO];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate  // iOS 6 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ||[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationPortrait;
}
@end
