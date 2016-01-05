//
//  LoginViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 25/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "LoginViewController.h"
#import "StartinhViewController.h"
#import "ForgotpasswordViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Connectionmanager.h"
#import "Header.h"
#import "OwlersViewController.h"
#import "ProductViewController.h"
#import "VerificationViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "AppDelegate.h"

static NSString * const kClientID = @"509181039153-i4mnrf976n999ornrh2eafeeg1cf4oka.apps.googleusercontent.com";

@interface LoginViewController () <UIAlertViewDelegate, GPPSignInDelegate>



@end

@implementation LoginViewController
{
    NSDictionary *parsedObject;
    UIAlertView *alertviewregister;
    
}
@synthesize googleloginaction;
- (void)viewDidLoad {
    

    
    [super viewDidLoad];
    
    
   
    if ([FBSDKAccessToken currentAccessToken]) {
       
    }
    self.fbloginaction.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tapGestureRecognizer1];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(infoPageHidden)];
    [self.view addGestureRecognizer:tapGestureRecognizer2];
    
    
    /**************[GOOGLE SIGNIN START]*********/
//    
//    GPPSignIn *signIn = [GPPSignIn sharedInstance];
//    signIn.shouldFetchGooglePlusUser = YES;
//    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
//    
//    // You previously set kClientId in the "Initialize the Google+ client" step
//    signIn.clientID = kClientID;
//    
//    // Uncomment one of these two statements for the scope you chose in the previous step
//    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
//    //signIn.scopes = @[ @"profile" ];            // "profile" scope
//    
//    // Optional: declare signIn.actions, see "app activities"
//    signIn.delegate = self;
    
    /************[GOOGLE SIGNIN END]**********/
    
    
    
     

}


-(void)infoPageHidden
{
    
}
-(void)keyBoardHidden
{
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField *textField = (UITextField *)view;
            [textField resignFirstResponder];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"loginStatus"] integerValue] == 1)
    {
        alertviewregister= [[UIAlertView alloc] initWithTitle:nil message:@"Thank you! You have been registered successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertviewregister.delegate=self;
        [alertviewregister show];
        
    }
    else
    {
        [self.emailtxtfld setPlaceholder:@" name@email.com"];
        // Do any additional setup after loading the view from its nib.
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        [self.emailtxtfld setLeftView:leftView];
        self.emailtxtfld.leftViewMode = UITextFieldViewModeAlways;
        
        
        [self.pwdtextfld setPlaceholder:@" ********"];
        UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        [self.pwdtextfld setLeftView:leftView2];
        self.pwdtextfld.leftViewMode = UITextFieldViewModeAlways;
        
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckSelected"] integerValue] == 1)
        {
            self.emailtxtfld.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"];
           // [self.rememberMe setSelected:YES];
        }
        else
        {
            self.emailtxtfld.text = @"";
        }
        
        self.pwdtextfld.text = @"";
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"FaceBook/Twitter"] isEqualToString:@"registerPage"])
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"FaceBook/Twitter"];
            
            UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"You are successfully logged in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView setTag:101];
            [alertView show];
        }
    }
}
#pragma mark - Alertview delegate tethods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101 && buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    if(alertView==alertviewregister)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (IBAction)backbtnaction:(id)sender {
    
    StartinhViewController *view =[[StartinhViewController alloc]initWithNibName:@"StartinhViewController" bundle:nil];
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    
}

- (IBAction)loginbtnaction:(id)sender {
    
    
    NSString *message = [[NSString alloc]init];
    
    if (self.emailtxtfld.text.length == 0)
    {
        message = @"Please enter your email id";
    }
    else if (![self validateEmail: self.emailtxtfld.text])
    {
        message = @"Please enter a valid email id";
    }
    else if (self.pwdtextfld.text.length == 0)
    {
        message = @"Please enter your password";
    }
    
    if (message.length > 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:Nil message:message delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else
    {
        [self performSelector:@selector(logInUserInApplication) withObject:nil afterDelay:0.0f];
    }
}

-(void)logInUserInApplication
{
    if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            [loginButton setEnabled:NO];
            
            NSString *urlString = [NSString stringWithFormat:@"%@/signin.php?email=%@&password=%@",BaseUrl,self.emailtxtfld.text,self.pwdtextfld.text];
            NSURL *url = [[NSURL alloc]initWithString:urlString];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             
             {
                 
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     if (data.length > 0)
                     {
                         [loginButton setEnabled:YES];
                         
                         parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                         NSLog(@"parsedObject =%@",parsedObject);
                         
                         if ([[parsedObject valueForKey:@"status"]  isEqual: @"success"])
                         {
                            /*****[GETTING USERID AND USEREMAIL]******/
                             NSString *user_id = [parsedObject valueForKey:@"user_id"];
                             NSString *user_email = [parsedObject valueForKey:@"user_email"];
                             
                             /*********[SETTING SESSION LOGIN DETAILS]********/
                             [[NSUserDefaults standardUserDefaults] setObject:user_email forKey:@"userEmail"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             
                             [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             
                             
                             
                             
                             UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:[parsedObject valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alertView show];
                             
                             ProductViewController *product = [[ProductViewController alloc]init];
                             
                             [self.navigationController pushViewController:product animated:YES];
                        
                         }else
                         {
                             
                             UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:[parsedObject valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alertView show];
                             
                           }
                         
                      }
                     
                     
                 });
             }];
        });
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Network not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    
    }
}

- (BOOL)validateEmail:(NSString *)email1
{
    NSString *emailRegex = @ "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email1];
}

    
   

- (IBAction)forgotpwdbtnaction:(id)sender {
    ForgotpasswordViewController *forgot =[[ForgotpasswordViewController alloc]init];
    [self.navigationController pushViewController:forgot animated:YES];
    
}

- (IBAction)fbloginaction:(id)sender
{
    
    //NSArray *permissions = ["public_profile","publish_actions","email","user_birthday","user_friends"];
    
    
//    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:@"id,name,email" forKey:@"fields"];
//    
//    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
//     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                  id result, NSError *error) {
//         aHandler(result, error);
//     }];
    
    self.fbloginaction.readPermissions = @[@"public_profile"];
    
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             [self fetchUserInfo];
             
          //   FBSDKLoginManagerLoginResult fbloginresult : FBSDKLoginManagerLoginResult = result;
//             if(fbloginresult.grantedPermissions.contains("email"))
//             {
//                 println(fbloginresult)
//                 self.returnUserData()
//             }

             
         }
     }];
    
    
    
    
    
    
    
    
    
//    
//    if ([FBSDKAccessToken currentAccessToken])
//    {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *result, id user, NSError *error)
//         {
//             if (error) {
//                 NSLog(@"Process error");
//                 //  NSDictionary *dictUser = (NSDictionary *)user;
//                 // This dictionary contain user Information which is possible to get from Facebook account.
//             }
//         }];
//    }
    
    
    
    
    
   
 
}



#pragma mark Notification method changed

-(void)_accessTokenChanged:(NSNotification *)notification
{
    FBSDKAccessToken *token = notification.userInfo[FBSDKAccessTokenChangeNewKey];
    if (!token) {
    } else {
        if ([FBSDKAccessToken currentAccessToken]) {
            [self fetchUserInfo];
        }
    }
}

-(void)fetchUserInfo
{
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id, name, email" forKey:@"fields"];

    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {

             [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"UserLoginIdSession"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             
             
             /*****[GETTING USERID AND USEREMAIL]******/
             NSString *user_id = [result valueForKey:@"user_id"];
             NSString *user_email = [result valueForKey:@"user_email"];
             
             /*********[SETTING SESSION LOGIN DETAILS]********/
             [[NSUserDefaults standardUserDefaults] setObject:user_email forKey:@"userEmail"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             

            // NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
             
            // NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserLoginIdSession"];
             
             
             VerificationViewController *verficationController = [[VerificationViewController alloc] init];
             [self.navigationController pushViewController:verficationController animated:YES];
             
             
             
//             ProductViewController *product = [[ProductViewController alloc]init];
//             [self.navigationController pushViewController:product animated:YES];
         }else{
             // [SVProgressHUD dismiss];
             UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Could not connect to server" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
             [alertView show];
         }
     }];
    
    
}


-(BOOL)login_status{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"user_id"];
    if(object != nil){
        return YES;
    }else{
        return NO;
    }
}

-(void)logout_status{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user_id"];
    [defaults synchronize];
}


- (IBAction)googleloginaction:(id)sender;
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.delegate = self;
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    
    signIn.clientID = kClientID;
    signIn.scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,nil];
    
    signIn.actions = [NSArray arrayWithObjects:@"https://www.googleapis.com/auth/userinfo.profile",nil];
    [[GPPSignIn sharedInstance] authenticate];
    
    

}


//- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {
//    NSLog(@"Received Error %@ and auth object==%@", error, auth);
//    
//    if (error) {
//        
//
//    } else {
//        
//        
//        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
//        
//        NSLog(@"email %@ ", [NSString stringWithFormat:@"Email: %@",[GPPSignIn sharedInstance].authentication.userEmail]);
//        
//       // NSLog(@"Received error %@ and auth object %@",error, auth);
//        
//        // 1. Create a |GTLServicePlus| instance to send a request to Google+.
//        GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
//        plusService.retryEnabled = YES;
//        
//        // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
//        [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
//        
//        // 3. Use the "v1" version of the Google+ API.*
//        plusService.apiVersion = @"v1";
//        [plusService executeQuery:query
//                completionHandler:^(GTLServiceTicket *ticket,
//                                    GTLPlusPerson *person,
//                                    NSError *error) {
//                    if (error) {
//                        //Handle Error
//                    } else {
//                        
//                        NSLog(@"Email= %@", [GPPSignIn sharedInstance].authentication.userEmail);
//                        NSLog(@"username= %@", [GPPSignIn sharedInstance].authentication.userData);
//                        NSLog(@"username_id= %@", [GPPSignIn sharedInstance].authentication.userID);
//                        
//                        NSLog(@"GoogleID=%@", person.identifier);
//                        NSLog(@"User Name=%@", [person.name.givenName stringByAppendingFormat:@" %@", person.name.familyName]);
//                        NSLog(@"aboutme=%@", person.aboutMe);
//                      
//                        
//                        
//                    }
//                }];
//    }
//}
//
-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error{
    
    NSLog(@"Received Error %@  and auth object==%@",error,auth);
    
    if (error) {
        // Do some error handling here.
    } else {
      //  [self refreshInterfaceBasedOnSignIn];
        
        NSLog(@"email %@ ",[NSString stringWithFormat:@"Email: %@",[GPPSignIn sharedInstance].authentication.userEmail]);
        NSLog(@"Received error %@ and auth object %@",error, auth);
        
        // 1. Create a |GTLServicePlus| instance to send a request to Google+.
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
        plusService.retryEnabled = YES;
        
        // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
        [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
        
        
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
        
        // *4. Use the "v1" version of the Google+ API.*
        plusService.apiVersion = @"v1";
        
        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error) {
                        
                        
                        
                        //Handle Error
                        
                    } else
                    {
                        
                        
                        NSLog(@"Email= %@",[GPPSignIn sharedInstance].authentication.userEmail);
                        NSLog(@"GoogleID=%@",person.identifier);
                        NSLog(@"User Name=%@",[person.name.givenName stringByAppendingFormat:@" %@",person.name.familyName]);
                        NSLog(@"Gender=%@",person.gender);
                        
                    }
                }];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return textField;
}

@end
