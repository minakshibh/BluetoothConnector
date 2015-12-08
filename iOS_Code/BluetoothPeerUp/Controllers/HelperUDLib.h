
#import <Foundation/Foundation.h>

@interface HelperUDLib : NSObject

/*To set object - important - id is for all kind datatypes
   @param - objectvalue is the value you wanted pass, it can be anything string,array,number,dictionary,date
   @param key - is the key you wanted to set for key
 */

+(void)setObject:(id)objectvalue forKey:(NSString *)key;




/*To get object
 @praram key - is the value you have to pass for objectForKey
*/
+(id)getObject:(NSString *)key;




/*To Remove object
 @praram key - is the value you have to pass for removeObjectForKey
*/
+(void)removeObject:(NSString *)key;


/*
 For string
 @pararm - stringIs - is the  string value you wanted pass
 @param keyIs - is the key you wanted to set for key
*/
+(void)setObjectForString:(NSString *)stringIs KeyIs:(NSString*)keyIs;
+(NSString *)getObjectForString:(NSString *)KeyIs;


/*
 For Number
 @pararm - numberIs - is the  numeric value you wanted pass
 @param keyIs - is the key you wanted to set for key
*/
+(void)setObjectForNumber:(NSNumber *)numberIs KeyIs:(NSString*)keyIs;
+(NSNumber *)getObjectForNumber:(NSString *)KeyIs;


/*
 For Date
 @pararm - dateIs - is the  date value you wanted pass
 @param keyIs - is the key you wanted to set for key
 */
+(void)setObjectForDate:(NSDate *)dateIs KeyIs:(NSString*)keyIs;
+(NSDate *)getObjectForDate:(NSString *)KeyIs;

/*
 For Array
 @pararm - mutableArray - is the  array you wanted pass
 @param keyIs - is the key you wanted to set for key
 */

+(void)setObjectForArray:(NSMutableArray *)mutableArray KeyIs:(NSString*)keyIs;
+(NSMutableArray *)getObjectForArray:(NSString *)KeyIs;


/*
 For Dictionary
 @pararm - dictionary - is the  dictionary you wanted pass
 @param keyIs - is the key you wanted to set for key
 */

+(void)setObjectForDictionary:(NSMutableDictionary *)dictionary KeyIs:(NSString*)keyIs;
+(NSMutableDictionary *)getObjectForDictionary:(NSString *)KeyIs;

@end
