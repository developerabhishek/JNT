//
//  BidSectionViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 22/10/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "BidSectionViewController.h"
#import "ProductViewController.h"
#import "Connectionmanager.h"
#import "Header.h"
@interface BidSectionViewController ()

@end

@implementation BidSectionViewController
NSString *UserId;
@synthesize desc,owlersname,owlersimage,amount,url;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserId= [defaults objectForKey:@"user_id"];
    

    self.descLabel.text=desc;
    self.nameLabel.text=owlersname;
    self.amountLabel.text=amount;
   // self.imageoo.image=owlersimage;
    

    
    NSString *urlstring =[NSString stringWithFormat:@"%@/get_bid.php?auction_id=%@",BaseUrl,UserId];
    NSURL *url =[[NSURL alloc]initWithString:urlstring];
    NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *connection =[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
    [self downloadImageWithURL:[NSURL URLWithString:self.url] completionBlock:^(BOOL succeeded, UIImage *image) {
        
        if (succeeded) {
            
            // change the image in the cell
            [self.imageoo setImage:image];
            
            // cell.image = image;
            
        }}];
    
                          
}


-(void)viewWillLayoutSubviews{

    scrollview.contentSize = CGSizeMake(0, 750);

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error = %@", [error localizedDescription]);
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    serverdata =[[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [serverdata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    serverDictionary =[NSJSONSerialization JSONObjectWithData:serverdata options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"my json data =%@",serverDictionary);
    
    // _getDetailLabel.text=[NSString stringWithFormat:@"%@",[[[serverdict objectForKey:@"events"] objectAtIndex:0]objectForKey:@"event_desc"]];
    
    _maxbidLabel.text=[NSString stringWithFormat:@"%@",[serverDictionary objectForKey:@"total_bids"]];
    _totalBidLabel.text=[NSString stringWithFormat:@"%@",[serverDictionary objectForKey:@"max_bidAmount"]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)backBtnAction:(id)sender {
    ProductViewController *pro=[[ProductViewController alloc]initWithNibName:@"ProductViewController" bundle:nil];
    
    UINavigationController *navigate=self.navigationController;
    [navigate popViewControllerAnimated:YES];
}
- (IBAction)cancelBtnAction:(id)sender {
    ProductViewController *pro=[[ProductViewController alloc]init];
    UINavigationController *navi=self.navigationController;
    [navi popViewControllerAnimated:YES];
}
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock

{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
     
                                       queue:[NSOperationQueue mainQueue]
     
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if ( !error )
                                   
                               {
                                   
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   
                                   completionBlock(YES,image);
                                   
                               } else{
                                   
                                   completionBlock(NO,nil);
                                   
                               }
                               
                           }];
    
}

- (IBAction)buyBtnAction:(id)sender {
    
    if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            
            NSString *urlString = [NSString stringWithFormat:@"%@/save_buy_now.php?user_id=%@&auction_id=%@&bid_amount=%@",BaseUrl,@"41", @"2", amount];
            NSURL *url = [[NSURL alloc]initWithString:urlString];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     if (data.length > 0)
                     {
                         NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                         
                         NSLog(@"parsedObject =%@",parsedObject);
                         
                NSString* message = [parsedObject  objectForKey:@"message"];
                NSLog(@"message   =%@",message);
                         
                         UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"You have buyed auction." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alertView show];
                         
                         }
                     
                 });
             }];
        });
    }
    
}

- (IBAction)submitBtnAction:(id)sender {
    
    if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            
            NSString *urlString = [NSString stringWithFormat:@"%@/save_bid.php?user_id=%@&auction_id=%@&bid_amount=%@",BaseUrl,@"41", @"2", self.bidAmtTextFld.text];
            NSURL *url = [[NSURL alloc]initWithString:urlString];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     if (data.length > 0)
                     {
                         NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                         
                        NSLog(@"parsedObject =%@",parsedObject);
                         
                         NSString* message = [parsedObject  objectForKey:@"message"];
                         NSLog(@"message   =%@",message);
                         UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter the amount greater than 150000" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alertView show];

                     }
                     
                 });
             }];
        });
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return textField;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{

    scrollview.contentOffset = CGPointMake(0, 100);
   

}

-(void)textFieldDidEndEditing:(UITextField *)textField{

     scrollview.contentOffset = CGPointMake(0, 0);

}


@end
