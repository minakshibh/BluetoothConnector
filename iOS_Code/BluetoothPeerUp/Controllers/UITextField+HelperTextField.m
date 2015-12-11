

#import "UITextField+HelperTextField.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."

@implementation UITextField (HelperTextField)

//Email Validation
-(BOOL)emailValidation{
    
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
    return[emailTest evaluateWithObject:self.text];
}


//Phone number Validation
-(BOOL)numberValidation{
    NSString *phoneRegex = @"^+(?:[0-9] ?){9,14}[0-9]$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return[phoneTest evaluateWithObject:self.text];
}

//Enter only numbers
-(void)enterOnlyNumber{
    self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.delegate=self;
}


//Enter Only Letters
-(void)enterOnlyLetters{
    
    self.delegate=self;
}

//Enter Only Letters and characters

-(void)ristrictSpecialChar{
    self.tag = 4545;
    self.delegate=self;
}


#pragma mark - Textfield delegate method
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *chr=[NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    NSCharacterSet *characterSet = [NSCharacterSet letterCharacterSet];
    
    
    NSCharacterSet *leterChar = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:leterChar] componentsJoinedByString:@""];
    
    
    
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    
    if(textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation)
    {
        return (![chr isSupersetOfSet:stringSet]|| (newLength > 30) ? NO : YES );
    }
    else if (textField.tag==4545){
        return (![string isEqualToString:filtered]? NO : YES );
        
    }
    else if (textField==self){
        return (![characterSet isSupersetOfSet:stringSet] ? NO : YES );
    }
    
    return YES;
    
}

-(BOOL)isEmpty
{
    self.text = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    if ([self.text isEqualToString:@""]||[self.text isEqualToString:nil]) {
        return YES;
    }
    return NO;
}

@end
