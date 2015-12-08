//
//  registerViewController.m
//  HangmanPeerUp
//
//  Created by Krishna_Mac_4 on 19/11/15.
//  Copyright © 2015 Apple, Inc. All rights reserved.
//

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

// Added to Category Class
//- (BOOL)validateEmailWithString:(NSString*)email
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}

#pragma mark Button Actions
- (IBAction)loginAction:(id)sender {
    loginViewController *loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
    //this is iphone 5 xib
    
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (IBAction)signUpAction:(id)sender {
    [self.confirmPasswordTxt resignFirstResponder];
    [self.view endEditing:YES];
    NSString *password = [NSString stringWithFormat:@"%@",self.passwordTxt.text];
    NSString *confirmPassword = [NSString stringWithFormat:@"%@",self.confirmPasswordTxt.text];
    
    if (self.usernameTxt.text.length == 0)
    {
        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please add Username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        
        // New Alert
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageUsernameRequired okBtn:OkButtonText];
        return;
    }
    else if (![self.emailTxt emailValidation])
    {
        //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please Check Your Email Address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alert show];
        
        // New Alert
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageIvalidEmail okBtn:OkButtonText];
        [self.emailTxt becomeFirstResponder];
        return;
    }
    else if (self.passwordTxt.text.length==0)
    {
        //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please Enter password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alert show];
        
        // New Alert
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessagePasswordRequired okBtn:OkButtonText];
        return;
    }
    else if (self.confirmPasswordTxt.text.length==0)
    {
        //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please Enter password to confirm." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alert show];
        
        // New Alert
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessageConfirmPasswordRequired okBtn:OkButtonText];
        return;
    }
    else if (![password isEqualToString:confirmPassword])
    {
        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Password do not match." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        
        // New Alert
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
                //this is iphone 5 xib
                
                [self.navigationController pushViewController:loginVC animated:NO];
                // Hooray! Let them use the app now.
            } else
            {   NSString *errorString = [error userInfo][@"error"];
                NSLog(@"unable to Signup. Error = %@",errorString);
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:[NSString stringWithFormat:@"%@",[error userInfo][@"error"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //                [alert show];
                
                // New Alert
                [HelperAlert alertWithOneBtn:AlertTitle description:[NSString stringWithFormat:@"%@",[error userInfo][@"error"]] okBtn:OkButtonText];
                
                // Show the errorString somewhere and let the user try again.
            }
        }];
    }
}

@end
