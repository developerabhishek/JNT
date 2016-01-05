//
//  ProfileViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 30/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "ProfileViewController.h"
#import "EditViewController.h"
#import "ProductViewController.h"
#import "CustomCell3.h"
#import "Header.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import <UIKit/UIKitDefines.h>
@interface ProfileViewController (){
    
    
    NSString *UserId;
}

@end

@implementation ProfileViewController

@synthesize tableview;


NSURLConnection *connection_, *_connection;
NSString *UserId;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserId= [defaults objectForKey:@"user_id"];
    
    
    tableview.delegate=self;
    tableview.dataSource=self;
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self.navigationItem setRightBarButtonItem:nil];
    self.navigationItem.hidesBackButton = YES;
    
    
    NSString *_urlstring=[NSString stringWithFormat:@"%@/profile.php?user_id=%@",BaseUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"]];
    
    NSLog(@"Url to fetch profile details : %@",_urlstring);
    //  [defaults objectForKey:@"userID"]];
    NSURL *url_=[[NSURL alloc]initWithString:_urlstring];
    NSURLRequest *request_=[[NSURLRequest alloc]initWithURL:url_];
    connection_=[[NSURLConnection alloc]initWithRequest:request_ delegate:self];
    [connection_ start];
    
  //  NSString *string_url=[NSString stringWithFormat:@"%@/get_booking.php?user_id=%@",BaseUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"]];
    NSString *string_url=[NSString stringWithFormat:@"%@/get_booking.php?user_id=41",BaseUrl];
    
    
    // NSLog(@"my json data =%@",string_url);
    NSURL *_url=[[NSURL alloc]initWithString:string_url];
    NSURLRequest *_request=[[NSURLRequest alloc]initWithURL:_url];
    _connection=[[NSURLConnection alloc]initWithRequest:_request delegate:self];
    [_connection start];
    
}


-(void)viewWillLayoutSubviews{
    
    scrolview.frame = CGRectMake( 0, scrolview.frame.origin.y, self.view.frame.size.width*2, scrolview.frame.size.height);
    
    scrolview.scrollEnabled = YES;
    scrolview.bounces = NO;
    scrolview.pagingEnabled = YES;
    for (int i=0; i<2; i++) {
        
        
        
        
        if (i==0) {
            
            tableview.frame = CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, scrolview.frame.size.height);
            
            
            [scrolview addSubview:tableview];
            
        }else{
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, scrolview.frame.size.height)];
            image.backgroundColor = [UIColor whiteColor];
            // image.backgroundColor = [UIColor brownColor];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width+10, 10, self.view.frame.size.width-20, 20)];
            label.text = @"lkdjfkjdkfjkjf";
            
            
            [scrolview addSubview:image];
            label.text = @"Here Wallet detail of user will show !!";
            [scrolview addSubview:label];
            
        }
        
        
    }
    tableview.bounces = NO;
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [scrolview setContentSize:CGSizeMake(self.view.frame.size.width*3, 0)];
    
    
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (connection ==connection_) {
        NSLog(@"Error = %@", [error localizedDescription]);
    }
    else if (connection ==_connection){
        NSLog(@"Error =%@",[error localizedDescription]);
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if (connection ==connection_) {
        serverData = [[NSMutableData alloc]init];
    }
    else if (connection ==_connection){
        serDATA =[[NSMutableData alloc]init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if (connection ==connection_) {
        [serverData appendData:data];
    }
    else if (connection ==_connection)
    {
        [serDATA appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (connection ==connection_) {
        serverDictionary = [NSJSONSerialization JSONObjectWithData:serverData options:NSJSONReadingMutableLeaves error:nil];
        
        // NSLog(@"serverDataArray =%@",serverDictionary);
        
        _nameLabel.text=[NSString stringWithFormat:@"%@",[serverDictionary  objectForKey:@"name"]];
        _emaillabel.text=[NSString stringWithFormat:@"%@",[serverDictionary objectForKey:@"email"]];
        _mobileNoLabel.text=[NSString stringWithFormat:@"%@",[serverDictionary objectForKey:@"phone"]];
    }
    
    else if (connection ==_connection)
    {
        serDICT =[NSJSONSerialization JSONObjectWithData:serDATA options:NSJSONReadingMutableLeaves error:nil];
        
        
        // NSLog(@"my json data =%@",serDICT);
        
        [self.tableview reloadData];
    }
    
}


-(IBAction)bokkingAction:(id)sender{
    
    [scrolview setContentOffset:CGPointMake(0, 0)];
    
    
    
}

-(IBAction)walletAction:(id)sender{
    
    
    [scrolview setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)actionSheet:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Select Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo With Camera", @"Choose Photo From Gallery", nil];
    [actionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *gallery = [[UIImagePickerController alloc]init];
                [gallery setAllowsEditing:YES];
                [gallery setDelegate:self];
                [gallery setSourceType:UIImagePickerControllerSourceTypeCamera];
                [self presentViewController:gallery animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Camera is not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
            }
            break;
        case 1:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                UIImagePickerController *gallery = [[UIImagePickerController alloc]init];
                [gallery setAllowsEditing:YES];
                [gallery setDelegate:self];
                [gallery setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                [self presentViewController:gallery animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Gallery is not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
            }
            break;
            
        default:
            break;
    }
}

/*
 -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
 
 
 
 }*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info = %@", info);
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [profileImage setImage:chosenImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [addImageButton setTitle:@"Change Image" forState:UIControlStateNormal];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)editbtnAction:(id)sender {
    EditViewController *edit=[[EditViewController alloc]init];
    [self.navigationController pushViewController:edit animated:YES];
}

- (IBAction)backBtn:(UIBarButtonItem *)sender {
    
    ProductViewController *view =[[ProductViewController alloc]initWithNibName:@"ProductViewController" bundle:nil];
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return serDICT.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celid =@"cell";
    CustomCell3*cell = [tableView dequeueReusableCellWithIdentifier:celid];
    
    NSLog(@"dict =%lu",(unsigned long)serDICT.count);
    NSLog([serDICT objectForKey:(@"history")]);
    
    /*******[CHECKING SERVER DATA IS EMPTY OR NOT]*********/
    if([[serDICT objectForKey:(@"history")] isEqualToString:@"No Data Found"]){
        NSLog(@"its not found");
        cell.label1.text = @"No Data Found";
    }
    else
    {
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell3" owner:self options:nil];
            cell =(CustomCell3*)[nib objectAtIndex:0];
        }
        
        if (indexPath==indexpath) {
            cell.viewd.hidden = NO;
        }else
            cell.viewd.hidden=YES;
        cell.label1.text=[[[serDICT objectForKey:(@"history")]objectAtIndex:indexPath.row]objectForKey:@"event_name"];
        cell.label2.text=[[[serDICT objectForKey:(@"history")]objectAtIndex:indexPath.row]objectForKey:@"event_venue"];
        //cell.label3.text=[[[serDICT objectForKey:(@"history")]objectAtIndex:indexPath.row]objectForKey:@""];
        cell.rupees_Lab.text =[[[serDICT objectForKey:@"history"]objectAtIndex:indexpath.row]objectForKey:@"total_amount"];
        // cell.description_label.text =[[[serDICT objectForKey:@"history"]objectAtIndex:indexpath.row]objectForKey:@"event_description"];
        //  cell.condition_label.text =[[[serDICT objectForKey:@"history"]objectAtIndex:indexpath.row]objectForKey:@"event_terms"];
        NSString *strgfhfg=[[[serDICT objectForKey:(@"history")]objectAtIndex:indexPath.row]objectForKey:@"event_date"];
        
        NSArray *itemsrr = [strgfhfg componentsSeparatedByString:@" "];   //take the one arraysplit the string
        
        
        NSString *dddd = [itemsrr objectAtIndex:0];
        cell.date_label.text =dddd;
        NSString *ddddff = [itemsrr objectAtIndex:1];
        cell.time_label.text =ddddff;
        
        
        // NSLog(@"arr time =%@",dddd);
        //  NSLog(@"arr date =%@",ddddff);
        
        NSString *payment_mrthod = [[[serDICT objectForKey:(@"history")]objectAtIndex:indexPath.row]objectForKey:@"payment_method"];
        
        if([payment_mrthod isEqual:@"Cash"]){
            cell.label3.text = @"Cash Payment !!";
        }else{
            cell.label3.text = @"Online Payment !!";
        }
        
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault setObject:@"" forKey:@"index"];
    
    
    if (indexpath==indexPath) {
        NSLog(@"this is same indexpath");
        indexpath=nil;
        [userdefault setObject:@"60" forKey:@"changecell"];
    }else{
        
        
        indexpath=indexPath;
        [userdefault setObject:@"250" forKey:@"changecell"];
        
        
    }
    
    [tableview reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexpath==indexPath) {
        return 248;
    }
    
    return 83;
    
}

@end
