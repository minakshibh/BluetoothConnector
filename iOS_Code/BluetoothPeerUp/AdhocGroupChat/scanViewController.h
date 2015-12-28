

#import <UIKit/UIKit.h>


@interface scanViewController : UIViewController

typedef NS_OPTIONS(NSUInteger, isSyncState) {
    isSyncState_Deleted     = 0,
    isSyncState_Sync        = 1 ,
    isSyncState_unSync      = -1
    
};
@end
