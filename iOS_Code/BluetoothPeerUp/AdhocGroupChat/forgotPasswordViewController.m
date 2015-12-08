//
//  forgotPasswordViewController.m
//  HangmanPeerUp
//
//  Created by Krishna_Mac_4 on 19/11/15.
//  Copyright © 2015 Apple, Inc. All rights reserved.
//

#import "forgotPasswordViewController.h"
#import <Parse/PFUser.h>
#import "loginViewController.h"
#import "registerViewController.h"

@interface forgotPasswordViewController ()
@property (strong, nonatomic) IBOutlet UILabel *emailBackLbl;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;

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
#pragma mark Button Actions 
- (IBAction)recoverPasswordAction:(id)sender {
    if (self.emailTxt.text.length == 0) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please Enter password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
        
        // New Alert
        [HelperAlert alertWithOneBtn:AlertTitle description:AlertMessagePasswordRequired okBtn:OkButtonText];
        
        return;
    }
    else  if (![self.emailTxt emailValidation])
    {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:@"Please Check Your Email Address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
        
        // New Alert
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
                //this is iphone 5 xib
                
                [self.navigationController pushViewController:loginVC animated:NO];
                
            }
            else
            {
                NSString *errorString = [error userInfo][@"error"];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangman Peerup" message:[NSString stringWithFormat: @"Password reset failed: %@",errorString] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                [alert show];
                
                // New Alert
                [HelperAlert alertWithOneBtn:AlertTitle description:[NSString stringWithFormat: @"Password reset failed: %@",errorString] okBtn:OkButtonText];
                return;
            }
        }];
        
    }
}
// Added to Category Class
//- (BOOL)validateEmailWithString:(NSString*)email
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}
- (IBAction)loginAction:(id)sender {
    loginViewController *loginVC=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:[NSBundle mainBundle]];
    //this is iphone 5 xib
    
    [self.navigationController pushViewController:loginVC animated:NO];
}
- (IBAction)registerAction:(id)sender {
    registerViewController *registerVC=[[registerViewController alloc]initWithNibName:@"registerViewController" bundle:[NSBundle mainBundle]];
    //this is iphone 5 xib
    
    [self.navigationController pushViewController:registerVC animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
