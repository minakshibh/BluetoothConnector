
#import "HelperAlert.h"

@implementation HelperAlert


+ (UIAlertView *) alertWithOneBtn:(NSString*)title description:(NSString*)description okBtn:(NSString *)okBtn{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:okBtn otherButtonTitles:nil, nil];
    [alert show];
    return alert;
}

+(UIAlertView*) alertWithTwoBtns:(NSString *)title description:(NSString *)description okBtn:(NSString *)okBtn cancelBtn:(NSString *)cancelBtn{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:description delegate:self cancelButtonTitle:okBtn otherButtonTitles:cancelBtn, nil];
    [alert show];
    return alert;
    
}



@end
