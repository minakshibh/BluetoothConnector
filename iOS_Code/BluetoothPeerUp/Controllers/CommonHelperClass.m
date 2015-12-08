

#import "CommonHelperClass.h"

@implementation CommonHelperClass
+(CGFloat) CalculateStringHeight:(NSString *)String{
    NSString *str = String;
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Roboto-Light" size:10] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%f",size.height);
    return size.height;
   
}

+(NSString *)jsonWrapper:(id)input
{
    NSError *error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    return jsonString;
}

+(NSString*)remaningTime:(NSString *)startDate endDate:(NSString*)endDate{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[NSLocale currentLocale]];
    [format setDateFormat:@"hh:mm:ss a"];
    NSDate *sDate = [format dateFromString:startDate];
    NSDate *eDate = [format dateFromString:endDate];
    NSInteger seconds;
    NSInteger minutes = 0;
    NSString *durationString;
    NSTimeInterval interval = [eDate timeIntervalSinceDate:sDate];
    if (interval > 60) {
        minutes=interval/60;
        durationString=[NSString stringWithFormat:@"%2ld mins",(long)minutes];
    }else{
        seconds = interval;
        durationString=[NSString stringWithFormat:@"%2ld sec",(long)seconds];
    }
    
    return durationString;
}


@end
