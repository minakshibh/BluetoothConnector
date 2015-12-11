

#import "HelperUDLib.h"

@implementation HelperUDLib

//for id - for all kind of types
+(void)setObject:(id)objectvalue forKey:(NSString *)key{
    
    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:objectvalue];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(id)getObject:(NSString *)key
{
    
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    id identifier = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return identifier;
}

+(void)removeObject:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    
}

//For String
+(void)setObjectForString:(NSString *)stringIs KeyIs:(NSString*)keyIs{
    [[NSUserDefaults standardUserDefaults] setObject:stringIs forKey:keyIs];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

+(NSString *)getObjectForString:(NSString *)KeyIs{
    NSString * string = [[NSUserDefaults standardUserDefaults]objectForKey:KeyIs];
    return string;
}



//For Number
+(void)setObjectForNumber:(NSNumber *)numberIs KeyIs:(NSString*)keyIs{
    [[NSUserDefaults standardUserDefaults] setObject:numberIs forKey:keyIs];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSNumber *)getObjectForNumber:(NSString *)KeyIs{
    
    NSNumber * number = [[NSUserDefaults standardUserDefaults]objectForKey:KeyIs];
    return number;
}


//For Date
+(void)setObjectForDate:(NSDate *)dateIs KeyIs:(NSString*)keyIs{
    
    [[NSUserDefaults standardUserDefaults] setObject:dateIs forKey:keyIs];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSDate *)getObjectForDate:(NSString *)KeyIs{
    NSDate * date = [[NSUserDefaults standardUserDefaults]objectForKey:KeyIs];
    return date;
}


//For Array
+(void)setObjectForArray:(NSMutableArray *)mutableArray KeyIs:(NSString*)keyIs{
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:keyIs];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(NSMutableArray *)getObjectForArray:(NSString *)KeyIs{
    NSMutableArray * array = [[NSUserDefaults standardUserDefaults]objectForKey:KeyIs];
    return array;
}


//For Dictionary
+(void)setObjectForDictionary:(NSMutableDictionary *)dictionary KeyIs:(NSString*)keyIs{
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:keyIs];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(NSMutableDictionary *)getObjectForDictionary:(NSString *)KeyIs{
    NSMutableDictionary * dictionary = [[NSUserDefaults standardUserDefaults]objectForKey:KeyIs];
    return dictionary;
}

@end
