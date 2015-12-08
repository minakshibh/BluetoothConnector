

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonHelperClass : NSObject

+(NSString *)jsonWrapper:(id)input;

+(CGFloat) CalculateStringHeight:(NSString *)String;

+(NSString*)remaningTime:(NSString *)startDate endDate:(NSString*)endDate;

@end
