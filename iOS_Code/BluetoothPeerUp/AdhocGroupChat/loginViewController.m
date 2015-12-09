
#import "loginViewController.h"
#import <Parse/PFUser.h>
#import "registerViewController.h"
#import "scanViewController.h"
#import "forgotPasswordViewController.h"
@interface loginViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *usernameBackLbl;
@property (strong, nonatomic) IBOutlet UITextField *usernameTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UILabel *passwordBackLbl;
@property (strong, nonatomic) IBOutlet UILabel *lblHeadingUsername;
@property (strong, nonatomic) IBOutlet UILabel *lblHeadingPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnRegisterNow;
@property (strong, nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIImageView *imgUserimage;
@property (strong, nonatomic) IBOutlet UIImageView *imgLockimage;


@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameBackLbl.layer.borderColor = [UIColor colorWithRed:5.0/255.0f green:61.0/255.0f blue:131.0/255.0f alpha:0.3].CGColor;
    self.usernameBackLbl.layer.borderWidth = 2.0;
    self.usernameBackLbl.layer.cornerRadius = 4.0;
    [self.usernameBackLbl setClipsToBounds:YES];
    
    self.passwordBackLbl.layer.borderColor = [UIColor colorWithRed:5.0/255.0f green:61.0/255.0f blue:131.0/255.0f alpha:0.3].CGColor;
    self.passwordBackLbl.layer.borderWidth = 2.0;
    self.passwordBackLbl.layer.cornerRadius = 4.0;
    [self.passwordBackLbl setClipsToBounds:YES];
    
    if (IS_IPAD) {
        self.usernameTxt.font = [UIFont systemFontOfSize:25];
        self.passwordTxt.font = [UIFont systemFontOfSize:25];
        self.lblHeadingUsername.font = [UIFont systemFontOfSize:25];
        self.lblHeadingPassword.font = [UIFont systemFontOfSize:25];
        self.btnLogin.titleLabel.font = [UIFont systemFontOfSize:30];
        self.btnForgotPassword.titleLabel.font = [UIFont systemFontOfSize:20];
        self.btnRegisterNow.titleLabel.font = [UIFont systemFontOfSize:20];
        self.imgLogo.frame = CGRectMake(125, 100, 70, 100);
        
        [self.imgUserimage setFrame:CGRectMake(self.imgUserimage.frame.origin.x+5, self.imgUserimage.frame.origin.y, self.imgUserimage.frame.size.width-3, self.imgUserimage.frame.size.height)];
        [self.view addSubview:self.imgUserimage];
        
        [self.imgLockimage setFrame:CGRectMake(self.imgLockimage.frame.origin.x+5, self.imgLockimage.frame.origin.y, self.imgLockimage.frame.size.width-3, self.imgLockimage.frame.size.height)];
        [self.view addSubview:self.imgLockimage];
        
        
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Actions
- (IBAction)login:(id)sender {
    
    [self.passwordTxt resignFirstResponder];
    
    NSString *usernameStr = [NSString stringWithFormat:@"%@",self.usernameTxt.text];
    NSString *passwordStr = [NSString stringWithFormat:@"%@",self.passwordTxt.text];
    
    if (usernameStr.length == 0) {
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageFirstNameRequired okBtn:OkButtonText];
    }
    else if (passwordStr.length == 0)
    {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageLastNameRequired okBtn:OkButtonText];
    }
    else
    {
        [kappDelegate ShowIndicator];
        [PFUser logInWithUsernameInBackground:usernameStr password:passwordStr
                                        block:^(PFUser *user, NSError *error) {
                                            [kappDelegate HideIndicator];
                                            [self.view endEditing:YES];
                                            if (user) {
                                                NSLog(@"Successful login.");
                                                [HelperUDLib setObject:self.usernameTxt.text forKey:@"Username"];
                                                scanViewController *scanVC=[[scanViewController alloc]initWithNibName:@"scanViewController" bundle:[NSBundle mainBundle]];
                                                
                                                [self.navigationController pushViewController:scanVC animated:NO];
                                            } else {
                                                
                                                [HelperAlert alertWithOneBtn:AlertTitle description:[NSString stringWithFormat:@"%@",[error userInfo][@"error"]] okBtn:OkButtonText];
                                                
                                                NSLog(@"The login failed. Error = %@", [error userInfo][@"error"]);
                                            }
                                        }];
    }
}

- (IBAction)register:(id)sender {
    registerViewController *registerVC=[[registerViewController alloc]initWithNibName:@"registerViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:registerVC animated:NO];
}
- (IBAction)forgotPasswordAction:(id)sender {
    forgotPasswordViewController *forgotPasswordVC=[[forgotPasswordViewController alloc]initWithNibName:@"forgotPasswordViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:forgotPasswordVC animated:NO];
}

#pragma mark UITextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.passwordTxt)
    {
        [self.scrollView setContentOffset:CGPointMake(0.0, 50.0) animated:YES];
    }
    return  YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == self.passwordTxt)
    {
        [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    }
    
    return  YES;
}


@end
