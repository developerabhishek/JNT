//
//  ChangePasswordViewController.h
//  Owlers
//
//  Created by Biprajit Biswas on 30/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connectionmanager.h"
@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    
    IBOutlet UITextField *confirmPassword;
    IBOutlet UITextField *newpassword;
    IBOutlet UITextField *currnetPassword;
    IBOutlet UIButton *saveButton;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}
@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)backbtnAction:(id)sender;
- (IBAction)savebtnAction:(id)sender;

@end
