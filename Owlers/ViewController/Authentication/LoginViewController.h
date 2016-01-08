//
//  LoginViewController.h
//  Owlers
//
//  Created by Biprajit Biswas on 25/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GooglePlus/GooglePlus.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,GPPSignInDelegate>

@property (strong, nonatomic) IBOutlet UILabel *addresslabel;
@property (strong, nonatomic) IBOutlet UILabel *loginlabel;
@property (strong, nonatomic) IBOutlet UILabel *pwdlabel;
@property (strong, nonatomic) IBOutlet UILabel *orlabel;
@property (strong, nonatomic) IBOutlet UIButton *loginbtn;
@property (strong, nonatomic) IBOutlet UITextField *emailtxtfld;
@property (strong, nonatomic) IBOutlet UITextField *pwdtextfld;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong , nonatomic) IBOutlet FBSDKLoginButton *fbloginaction;
@property (retain, nonatomic) IBOutlet GPPSignInButton *googleloginaction;

- (IBAction)backbtnaction:(id)sender;
- (IBAction)loginbtnaction:(id)sender;
- (IBAction)forgotpwdbtnaction:(id)sender;
- (IBAction)fbloginaction:(id)sender;

- (IBAction)googleloginaction:(id)sender;
;

@end
