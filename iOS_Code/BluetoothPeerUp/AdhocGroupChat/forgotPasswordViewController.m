

#import "forgotPasswordViewController.h"
#import <Parse/PFUser.h>
#import "loginViewController.h"
#import "registerViewController.h"

@interface forgotPasswordViewController ()
@property (strong, nonatomic) IBOutlet UILabel *emailBackLbl;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UILabel *lblHeadingEmail;
@property (strong, nonatomic) IBOutlet UIImageView *imgEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnRecoverPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;

@end

@implementation forgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailBackLbl.layer.borderColor = [UIColor colorWithRed:5.0/255.0f green:61.0/255.0f blue:131.0/255.0f alpha:0.3].CGColor;
    self.emailBackLbl.layer.borderWidth = 2.0;
    self.emailBackLbl.layer.cornerRadius = 4.0;
    [self.emailBackLbl setClipsToBounds:YES];
    
    UITapGestureRecognizer* tapper = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    if (IS_IPAD) {
        self.lblHeadingEmail.font = [UIFont systemFontOfSize:25];
        self.emailTxt.font = [UIFont systemFontOfSize:25];
        [self.imgEmail setFrame:CGRectMake(self.imgEmail.frame.origin.x+5, self.imgEmail.frame.origin.y+1, self.imgEmail.frame.size.width-5, self.imgEmail.frame.size.height-2)];
        [self.view addSubview:self.imgEmail];
        self.btnLogin.titleLabel.font = [UIFont systemFontOfSize:30];
        self.btnRecoverPassword.titleLabel.font = [UIFont systemFontOfSize:30];
        self.btnRegister.titleLabel.font = [UIFont systemFontOfSize:30];
    }
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Button Actions
- (IBAction)recoverPasswordAction:(id)sender {
    if (self.emailTxt.text.length == 0) {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessagePasswordRequired okBtn:OkButtonText];
        
        return;
    }
    else  if (![self.emailTxt emailValidation])
    {
        
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageIvalidEmail okBtn:OkButtonText];
        
        [self.emailTxt becomeFirstResponder];
        return;
    }else{
        [kappDelegate ShowIndicator];
        [PFUser requestPasswordResetForEmailInBackground:self.emailTxt.text block:^(BOOL succeeded,NSError *error)
         {
             [kappDelegate HideIndicator];
             if (!error) {
                 loginViewController *loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
                 
                 [self.navigationController pushViewController:loginVC animated:NO];
                 
             }
             else
             {
                 NSString *errorString = [error userInfo][@"error"];
                 
                 [HelperAlert alertWithOneBtn:AlertTitle description:[NSString stringWithFormat: @"Password reset failed: %@",errorString] okBtn:OkButtonText];
                 return;
             }
         }];
        
    }
}

- (IBAction)loginAction:(id)sender {
    loginViewController *loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:loginVC animated:NO];
}
- (IBAction)registerAction:(id)sender {
    registerViewController *registerVC=[[registerViewController alloc]initWithNibName:@"registerViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:registerVC animated:NO];
}


@end
