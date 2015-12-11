
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HelperAlert : NSObject

/*This method is for AlertView having 1 button (OK Button)
 @param title - is used to give the title to alert
 @param description - is used to give description message to alert
 @param okBtn - is used to give button title
*/

+(UIAlertView*) alertWithOneBtn:(NSString*)title description:(NSString*)description okBtn:(NSString *)okBtn;

/*This method is for alert view with 2 buttons (ok and cancel)
 @param title - is used to give the title to alert
 @param description - is used to give description message to alert
 @param okBtn - is used to give title to button
 @param cancelBtn - is used to give title to button
*/

+(UIAlertView*) alertWithTwoBtns:(NSString*)title description:(NSString*)description okBtn:(NSString *)okBtn cancelBtn:(NSString*)cancelBtn;

@end

