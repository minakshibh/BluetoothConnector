
#import "registerViewController.h"
#import <Parse/PFUser.h>
#import "loginViewController.h"

@interface registerViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *userBackLbl;
@property (strong, nonatomic) IBOutlet UITextField *usernameTxt;
@property (strong, nonatomic) IBOutlet UILabel *emailBackLbl;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UILabel *passworkBackLbl;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UILabel *confirmPasswordBackLbl;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTxt;
@property (strong, nonatomic) IBOutlet UILabel *lblHeadingUsername;
@property (strong, nonatomic) IBOutlet UILabel *lblHeadingEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblHeadingPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblHeadingConfirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnSignup;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIImageView *imgUsername;
@property (strong, nonatomic) IBOutlet UIImageView *imgEmail;
@property (strong, nonatomic) IBOutlet UIImageView *imgPassword;
@property (strong, nonatomic) IBOutlet UIImageView *imgConfirmPassword;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userBackLbl.layer.borderColor = [UIColor colorWithRed:5.0/255.0f green:61.0/255.0f blue:131.0/255.0f alpha:0.3].CGColor;
    self.userBackLbl.layer.borderWidth = 2.0;
    self.userBackLbl.layer.cornerRadius = 4.0;
    [self.userBackLbl setClipsToBounds:YES];
    
    self.emailBackLbl.layer.borderColor = [UIColor colorWithRed:5.0/255.0f green:61.0/255.0f blue:131.0/255.0f alpha:0.3].CGColor;
    self.emailBackLbl.layer.borderWidth = 2.0;
    self.emailBackLbl.layer.cornerRadius = 4.0;
    [self.emailBackLbl setClipsToBounds:YES];
    
    self.passworkBackLbl.layer.borderColor = [UIColor colorWithRed:5.0/255.0f green:61.0/255.0f blue:131.0/255.0f alpha:0.3].CGColor;
    self.passworkBackLbl.layer.borderWidth = 2.0;
    self.passworkBackLbl.layer.cornerRadius = 4.0;
    [self.passworkBackLbl setClipsToBounds:YES];
    
    self.confirmPasswordBackLbl.layer.borderColor = [UIColor colorWithRed:5.0/255.0f green:61.0/255.0f blue:131.0/255.0f alpha:0.3].CGColor;
    self.confirmPasswordBackLbl.layer.borderWidth = 2.0;
    self.confirmPasswordBackLbl.layer.cornerRadius = 4.0;
    [self.confirmPasswordBackLbl setClipsToBounds:YES];
    
    UITapGestureRecognizer* tapper = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    if (IS_IPAD) {
        self.lblHeadingUsername.font = [UIFont systemFontOfSize:25];
        self.lblHeadingEmail.font = [UIFont systemFontOfSize:25];
        self.lblHeadingPassword.font = [UIFont systemFontOfSize:25];
        self.lblHeadingConfirmPassword.font = [UIFont systemFontOfSize:25];
        self.usernameTxt.font = [UIFont systemFontOfSize:25];
        self.passwordTxt.font = [UIFont systemFontOfSize:25];
        self.confirmPasswordTxt.font = [UIFont systemFontOfSize:25];
        self.emailTxt.font = [UIFont systemFontOfSize:25];
        self.btnLogin.titleLabel.font = [UIFont systemFontOfSize:30];
        self.btnSignup.titleLabel.font = [UIFont systemFontOfSize:30];
        
        [self.imgEmail setFrame:CGRectMake(self.imgEmail.frame.origin.x+5, self.imgEmail.frame.origin.y, self.imgEmail.frame.size.width-5, self.imgEmail.frame.size.height)];
        [self.view addSubview:self.imgEmail];
        
        [self.imgUsername setFrame:CGRectMake(self.imgUsername.frame.origin.x+5, self.imgUsername.frame.origin.y, self.imgUsername.frame.size.width-3, self.imgUsername.frame.size.height)];
        [self.view addSubview:self.imgUsername];
        
        [self.imgPassword setFrame:CGRectMake(self.imgPassword.frame.origin.x+3, self.imgPassword.frame.origin.y, self.imgPassword.frame.size.width-3, self.imgPassword.frame.size.height)];
        [self.view addSubview:self.imgPassword];
        
        [self.imgConfirmPassword setFrame:CGRectMake(self.imgConfirmPassword.frame.origin.x+4, self.imgConfirmPassword.frame.origin.y, self.imgConfirmPassword.frame.size.width-3, self.imgConfirmPassword.frame.size.height)];
        [self.view addSubview:self.imgConfirmPassword];
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.confirmPasswordTxt)
    {
        [self.scrollView setContentOffset:CGPointMake(0.0, 50.0) animated:YES];
    }
    return  YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == self.confirmPasswordTxt)
    {
        [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    }
    
    return  YES;
}


#pragma mark Button Actions
- (IBAction)loginAction:(id)sender {
    loginViewController *loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (IBAction)signUpAction:(id)sender {
    [self.confirmPasswordTxt resignFirstResponder];
    [self.view endEditing:YES];
    NSString *password = [NSString stringWithFormat:@"%@",self.passwordTxt.text];
    NSString *confirmPassword = [NSString stringWithFormat:@"%@",self.confirmPasswordTxt.text];
    
    if (self.usernameTxt.text.length == 0)
    {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageUsernameRequired okBtn:OkButtonText];
        return;
    }
    else if (![self.emailTxt emailValidation])
    {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageIvalidEmail okBtn:OkButtonText];
        [self.emailTxt becomeFirstResponder];
        return;
    }
    else if (self.passwordTxt.text.length==0)
    {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessagePasswordRequired okBtn:OkButtonText];
        return;
    }
    else if (self.confirmPasswordTxt.text.length==0)
    {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageConfirmPasswordRequired okBtn:OkButtonText];
        return;
    }
    else if (![password isEqualToString:confirmPassword])
    {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessagePasswordMismatch okBtn:OkButtonText];
        
    }else{
        [kappDelegate ShowIndicator];
        NSString *userName = [NSString stringWithFormat:@"%@",self.usernameTxt.text];
        NSString *password = [NSString stringWithFormat:@"%@",self.passwordTxt.text];
        NSString *email = [NSString stringWithFormat:@"%@",self.emailTxt.text];
        PFUser *user = [PFUser user];
        user.username = userName;
        user.password = password;
        user.email = email;
        // other fields can be set just like with PFObject
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [kappDelegate HideIndicator];
            if (!error) {
                NSLog(@"SignUp Successful");
                loginViewController *loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
                
                [self.navigationController pushViewController:loginVC animated:NO];
                
            } else
            {   NSString *errorString = [error userInfo][@"error"];
                NSLog(@"unable to Signup. Error = %@",errorString);
                
                [HelperAlert alertWithOneBtn:AlertTitle description:[NSString stringWithFormat:@"%@",[error userInfo][@"error"]] okBtn:OkButtonText];
            }
        }];
    }
}

@end
