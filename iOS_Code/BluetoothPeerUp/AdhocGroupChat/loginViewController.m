
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    
    [self.passwordTxt resignFirstResponder];
    
    NSString *usernameStr = [NSString stringWithFormat:@"%@",self.usernameTxt.text];
    NSString *passwordStr = [NSString stringWithFormat:@"%@",self.passwordTxt.text];
    
    if (usernameStr.length == 0) {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please add First Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        // New Alert view added using class method
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageFirstNameRequired okBtn:OkButtonText];
    }
    else if (passwordStr.length == 0)
    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please add Last Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        // New Alert
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
                                            
                                            //[[NSUserDefaults standardUserDefaults] setValue:self.usernameTxt.text forKey:@"Username"];
                                            [HelperUDLib setObject:self.usernameTxt.text forKey:@"Username"];
                                            scanViewController *scanVC=[[scanViewController alloc]initWithNibName:@"scanViewController" bundle:[NSBundle mainBundle]];
                                            //this is iphone 5 xib
                                            
                                            [self.navigationController pushViewController:scanVC animated:NO];
                                        } else {
//                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:[NSString stringWithFormat:@"%@",[error userInfo][@"error"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                                            [alert show];
                                            
                                            // New Alert
                                            [HelperAlert alertWithOneBtn:AlertTitle description:[NSString stringWithFormat:@"%@",[error userInfo][@"error"]] okBtn:OkButtonText];
                                            
                                            NSLog(@"The login failed. Error = %@", [error userInfo][@"error"]);
                                            // The login failed. Check error to see why.
                                        }
                                    }];
    }
}

- (IBAction)register:(id)sender {
    registerViewController *registerVC=[[registerViewController alloc]initWithNibName:@"registerViewController" bundle:[NSBundle mainBundle]];
    //this is iphone 5 xib
    
    [self.navigationController pushViewController:registerVC animated:NO];
}
- (IBAction)forgotPasswordAction:(id)sender {
    forgotPasswordViewController *forgotPasswordVC=[[forgotPasswordViewController alloc]initWithNibName:@"forgotPasswordViewController" bundle:[NSBundle mainBundle]];
    //this is iphone 5 xib
    
    [self.navigationController pushViewController:forgotPasswordVC animated:NO];
}
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
