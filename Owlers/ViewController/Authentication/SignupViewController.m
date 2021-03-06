//
//  SignupViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 24/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "SignupViewController.h"
#import "Connectionmanager.h"
#import "Header.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ProductViewController.h"
#import "SVProgressHUD.h"
#import "SharedPreferences.h"
#import "NetworkManager.h"

@interface SignupViewController ()
@property (nonatomic, weak) IBOutlet UIButton *continueBtn;




@end

@implementation SignupViewController
NSDictionary *parsedObject;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollview.contentSize = CGSizeMake(320, 800);

[[self navigationController] setNavigationBarHidden:YES animated:YES];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backbtnaction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)continuebtnaction:(id)sender {
    
    NSString *message = [[NSString alloc]init];
    if ([self.userNameTf.text length] == 0)
    {
        message = @"Please enter User Name";
    }
    else if ([self.emailTF.text length] == 0)
    {
        message = @"Please enter your emailId";
    }
    else if ([self.pwdTF.text length] == 0)
    {
        message = @"Please enter password";
    }
    else if ([self.confirmpass.text length] == 0)
    {
        message = @"Please enter confirm password";
    }
    else if ([self.confirmpass.text length] != [self.pwdTF.text length])
    {
        message = @"Password does not match";
    }
    else if ([self.mobilenotf.text length] == 0)
    {
        message = @"Please enter your mobileno";
    }
    
    
        if (message.length != 0)
        {
            [[SharedPreferences sharedInstance] showCommonAlertWithMessage:message withObject:self];
        }
        else
        {
            [self performSelector:@selector(signupInapplication) withObject:nil];
        }
    
    
    
}

-(void)signupInapplication
{
    
    if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
    {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Thread
            
            [self.continueBtn setEnabled:NO];
            
            NSString *urlString = [[NSString stringWithFormat:@"%@/signup.php?name=%@&email=%@&password=%@&phone=%@&source=iPhone&@&mac_addr=4545.7765.767",BaseUrl,self.userNameTf.text,self.emailTF.text,self.pwdTF.text,self.mobilenotf.text,self.confirmpass.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [[NSURL alloc] initWithString:urlString];
           
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            

            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             
             {
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     //Run UI Updates
                     if (data.length > 0)
                     {
                         [self.continueBtn setEnabled:YES];
                         
                         parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                         
                         NSLog(@"parsedObject =%@",parsedObject);
                         
                         
                         if ([[parsedObject valueForKey:@"status"]  isEqual: @"success"])
                         {
                             [[SharedPreferences sharedInstance] showCommonAlertWithMessage:[parsedObject valueForKey:@"message"] withObject:self];
                             NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                             [user setObject:[parsedObject objectForKey:@"user_id"] forKey:@"userID"];
                             ProductViewController *product = [[ProductViewController alloc]init];
                             [self.navigationController pushViewController:product animated:YES];
                         }
                         else
                         {
                             [[SharedPreferences sharedInstance] showCommonAlertWithMessage:[parsedObject valueForKey:@"message"] withObject:self];
                         }
                     }
                     
                 });
             }];
        });
        
    }
}



- (IBAction)fbbtnaction:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             [self fetchUserInfo];
         }
     }];
}



#pragma mark Notification method changed

-(void)_accessTokenChanged:(NSNotification *)notification
{
    
    
    FBSDKAccessToken *token = notification.userInfo[FBSDKAccessTokenChangeNewKey];
    
    if (!token) {
        
    } else {
        
        if ([FBSDKAccessToken currentAccessToken]) {
            
            
            [self fetchUserInfo];
            
            
        }}     }

-(void)fetchUserInfo
{
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             
             ProductViewController *product = [[ProductViewController alloc]init];
             [self.navigationController pushViewController:product animated:YES];
             
             
         }else{

             [[SharedPreferences sharedInstance] showCommonAlertWithMessage:@"Could not connect to server" withObject:self];             
         }
     }];
}



- (IBAction)googlebtnaction:(id)sender {
    

    
}



#pragma mark Webservice ............

//-(void)webServicePlans{
//    
//    
//    if (![[ConnectionManager getSharedInstance] isConnectionAvailable])
//    {
//    
//    
//        return;
//    }
//    
//    
//     NSString *urlString = [[NSString stringWithFormat:@"%@/signup.php?name=%@&email=%@&password=%@&phone=%@&source=iPhone&@&mac_addr=4545.7765.767",BaseUrl,self.userNameTf.text,self.emailTF.text,self.pwdTF.text,self.mobilenotf.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeGradient];
//    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//   // [manager.requestSerializer setValue:[userdef objectForKey:@"access_token"] forHTTPHeaderField:@"Authorization"];
//    
//    
//    
//    [manager GET:urlString parameters:nil
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             // globalManager.isRequestFetchedForInboxPlan=YES;
//              NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//              NSLog(@"web service PLANS %@",dataDictionary);
//          /*    if (dataDictionary.count<=0 ||dataDictionary==0 || [[dataDictionary valueForKey:@"message"] isEqualToString:@"No Plan Found"]) {
//                  
//                  if (globalManager.isRequestFetchedForTimeLine &&
//                      globalManager.isRequestFetchedForInboxPlan &&
//                      globalManager.isRequestFetchedForInboxSlap &&
//                      globalManager.isRequestFetchedForInboxSlapall){
//                      [SVProgressHUD dismiss];
//                  }
//                  return ;
//              }
//              
//              arr_planList =nil;
//              arr_planList = [NSMutableArray new];
//              //  [arr_planList removeAllObjects];
//              NSArray *temp_arr =  [dataDictionary objectForKey:@"data"];
//              // NSDictionary *dic_temp = [temp_arr objectAtIndex:0];
//              
//              
//              for (NSDictionary *dic in temp_arr) {
//                  
//                  PlanLists *events = [[PlanLists alloc] initWithDictionary:dic error:nil];
//                  
//                  [arr_planList addObject:events];
//                  [globalManager.arr_planList addObject:events];
//              }
//              
//              self.segmented.selectedSegmentIndex=0;
//              if (globalManager.isRequestFetchedForTimeLine &&
//                  globalManager.isRequestFetchedForInboxPlan &&
//                  globalManager.isRequestFetchedForInboxSlap &&
//                  globalManager.isRequestFetchedForInboxSlapall){
//                  [SVProgressHUD dismiss];
//              }*/
//             [SVProgressHUD dismiss];
//              
//              
//          } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//              
//              
//              NSLog(@"error%@",error.description);
//              [SVProgressHUD dismiss];
//              
//            /*  [[tView viewWithTag:8787] removeFromSuperview];
//              UIView *netconnectionview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-50, self.view.frame.size.width,100)];
//              [netconnectionview setTag:8787];
//              UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, netconnectionview.frame.size.width-20,50)];
//              [label setTextColor:[UIColor whiteColor]];
//              [netconnectionview addSubview:label];
//              [label setNumberOfLines:0];
//              [label setTextAlignment:NSTextAlignmentCenter];
//              [label setLineBreakMode:NSLineBreakByWordWrapping];
//              [label setFont:[UIFont fontWithName:@"Titillium-Light" size:17]];
//              [label setText:@"Unable to load data from the server. Tap to retry"];
//              UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetchAgainPlans:)];
//              [netconnectionview setUserInteractionEnabled:YES];
//              [netconnectionview addGestureRecognizer:tap];
//              
//              
//              [tView addSubview:netconnectionview];
//              */
//              
//          }];
//}

//-(void)fetchAgainPlans:(UITapGestureRecognizer *)sender{
//   // [[tView viewWithTag:8787] removeFromSuperview];
//    
//    [self webServicePlans];
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return textField;
}


@end
