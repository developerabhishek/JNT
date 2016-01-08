//
//  SignupViewController.h
//  Owlers
//
//  Created by Biprajit Biswas on 24/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SignupViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSData *data;
    NSMutableDictionary *dict;
    IBOutlet UITextField *emailTF;
    IBOutlet UITextField *userNameTf;
    IBOutlet UITextField *pwdTF;
    IBOutlet UITextField *confirmpass;
    IBOutlet UITextField *mobilenotf;
    
    IBOutlet UIScrollView *scrollview;
    
   
   

}
@property (strong, nonatomic) IBOutlet UITextField *mobilenotf;
@property (strong, nonatomic) IBOutlet UILabel *signuplabel;
@property (strong, nonatomic) IBOutlet UITextField *userNameTf;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *pwdTF;
@property (strong, nonatomic) IBOutlet UITextField *confirmpass;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)backbtnaction:(id)sender;
- (IBAction)continuebtnaction:(id)sender;
- (IBAction)fbbtnaction:(id)sender;
- (IBAction)googlebtnaction:(id)sender;


@end
