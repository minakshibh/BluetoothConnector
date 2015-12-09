

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

//- (void)textfieldwithLabel
//{
//
//    //Creating UIlabel on Textfield
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 17 + 12*isipad())];
//    lable.textAlignment = NSTextAlignmentLeft;
//    lable.contentMode= UIControlContentVerticalAlignmentTop;
//    lable.backgroundColor = [UIColor clearColor];
//    lable.font = [UIFont fontWithName:@"Roboto-Regular" size:15+ 10*isipad()];
//    lable.numberOfLines = 0;
//    lable.textColor= [UIColor colorWithRed:0/255.0f green:81/255.0f blue:138/255.0f alpha:1.0f];
//    lable.text = self.placeholder;
//    [self addSubview:lable];
//
//    //Realigning the Textfield frame
//    CGRect frame = self.frame;
//    frame.origin.y = frame.origin.y+20;
//    frame.size.height = frame.size.height-15;
//    self.frame = frame;
//    self.placeholder = @"";
//
//    //Textfield Text and contentVerticalAlignment
//    self.textAlignment = NSTextAlignmentLeft;
//    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
//
//    //Drawing an Layer on the bottom of texfield
//    CALayer *border = [CALayer layer];
//    CGFloat borderWidth = 1;
//    border.borderColor = [UIColor lightGrayColor].CGColor;
//    border.frame = CGRectMake(-5, self.frame.size.height - borderWidth, self.frame.size.width+5, self.frame.size.height);
//    border.borderWidth = borderWidth;
//    [self.layer addSublayer:border];
//    self.layer.masksToBounds = YES;
//
//}

-(BOOL)isEmpty
{
    self.text = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    if ([self.text isEqualToString:@""]||[self.text isEqualToString:nil]) {
        return YES;
    }
    return NO;
}


//- (void)textfieldwithLabelBlack
//{
//
//    //Creating UIlabel on Textfield
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 15 +12 *isipad())];
//    lable.textAlignment = NSTextAlignmentLeft;
//    lable.contentMode= UIControlContentVerticalAlignmentTop;
//    lable.backgroundColor = [UIColor clearColor];
//    lable.font = [UIFont fontWithName:@"Roboto-Regular" size:15 + 10*isipad()];
//    lable.numberOfLines = 0;
//    lable.textColor= [UIColor colorWithRed:55/255.0f green:55/255.0f blue:55/255.0f alpha:1.0f];
//    lable.text = self.placeholder;
//    [self addSubview:lable];
//
//    //Realigning the Textfield frame
//    CGRect frame = self.frame;
//    frame.origin.y = frame.origin.y+20;
//    frame.size.height = frame.size.height-15;
//    self.frame = frame;
//    self.placeholder = @"";
////    NSMutableAttributedString *tee = [[NSMutableAttributedString alloc] init];
////    [tee addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Roboto-Bold" size:50] range:NSMakeRange(0, self.text.length)];
////    self.attributedPlaceholder = tee;
//
//    //Textfield Text and contentVerticalAlignment
//    self.textAlignment = NSTextAlignmentLeft;
//    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
//
//    //Drawing an Layer on the bottom of texfield
//    CALayer *border = [CALayer layer];
//    CGFloat borderWidth = 1;
//    border.borderColor = [UIColor lightGrayColor].CGColor;
//    border.frame = CGRectMake(-5, self.frame.size.height - borderWidth, self.frame.size.width+5, self.frame.size.height);
//    border.borderWidth = borderWidth;
//    [self.layer addSublayer:border];
//    self.layer.masksToBounds = YES;
//
//}

@end
