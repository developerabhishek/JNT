//
//  ProductViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 25/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "ProductViewController.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "MyBidsViewController.h"
#import "OwlersViewController.h"
#import "CustomCell.h"
#import "CollectionViewCell.h"
#import "LoginViewController.h"
#import "AuctionViewController.h"
#import "Header.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "UIImageView+WebCache.h"
#import "DSLCalendarView.h"

@interface ProductViewController ()  <DSLCalendarViewDelegate>{


    NSURLConnection *connection_json;
    
}
@property (nonatomic, strong) CalendarView * sampleView;

@property (nonatomic, weak) IBOutlet DSLCalendarView *calendarView;

@property(nonatomic,strong) IBOutlet UITableView *listtable;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *search;
@property (nonatomic, strong) NSDate * selectedDate;

@end

@implementation ProductViewController
@synthesize calendarView;

NSString *UserId;
NSInteger myInteger = 0;
UIButton *button, *button2,*Calander, *searchbutton;
NSMutableArray *myObject;
NSDictionary *dictionary;

/*      for list table       */


NSMutableData *webdata;
NSMutableArray *array11;
NSURLConnection *connection;

UIRefreshControl *refreshControl;


-(void)viewWillAppear:(BOOL)animated{
    
    
}

- (void)viewDidLoad {
    [self.listtable setScrollEnabled:YES];
    
    //activityindicator.hidden = NO;
    
    
    self.listtable.backgroundColor =[UIColor blackColor];
    UIColor *color = [UIColor whiteColor];
    textfield.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Search Event"
     attributes:@{NSForegroundColorAttributeName:color}];
    
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@"Profile",
    @"Setings",
    @"My Bids",
    @"Logout",
    @"Auction", nil];
    login_status =YES;
    [super viewDidLoad];
    
    /**********[OWLERS LOADER WORK START]***********/
    self.loaderOwlersImage.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithDouble:M_PI_2];
    animation.duration = 0.4f;
    animation.cumulative = YES;
    animation.repeatCount = HUGE_VALF;
    [self.loaderOwlersImage.layer addAnimation:animation forKey:@"activityIndicatorAnimation"];
    /**********[OWLERS LOADER WORK END]***********/
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserId= [defaults objectForKey:@"user_id"];
    [self.navigationController setNavigationBarHidden:YES];
    
    location_arr = [[NSMutableArray alloc]init];
    locationID = [[NSMutableArray alloc]init];
//    [location_arr addObject:@"Delhi"];
//    [location_arr addObject:@"Gurgaon"];
//    [location_arr addObject:@"Bangalore"];
//    [location_arr addObject:@"Pune"];
//    [location_arr addObject:@"Mumbai"];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(-5, 65, 300, 170);
    self.tableView.bounces=NO;
    self.tableView.delegate=self;
    self.tableView.bounces =NO;
   
    
    NSString *_urlstring =[NSString stringWithFormat:@"%@/list_events.php?location_id=1",BaseUrl];
    
    NSURL *url=[[NSURL alloc]initWithString:_urlstring];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *connection_jso=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection_jso start];
    
    NSString *url_string=[NSString stringWithFormat:@"%@/get_locations.php",BaseUrl];
    NSURL *url_json=[[NSURL alloc]initWithString:url_string];
    NSURLRequest *request_json=[[NSURLRequest alloc]initWithURL:url_json];
    connection_json=[[NSURLConnection alloc]initWithRequest:request_json delegate:self];
    [connection_json start];
    
    self.search = [self.search initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar:)];
    
    
    [[self listtable]setDelegate:self];
    [[self listtable]setDataSource:self];
    
    searchbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    [searchbutton setImage:[UIImage imageNamed:@"search_eventss.png"] forState:UIControlStateNormal];
    [searchbutton setFrame:CGRectMake(100, 5, 350, 38)];
    
    
    Calander=[UIButton buttonWithType:UIButtonTypeCustom];
    [Calander setTitle:@"Calender" forState:UIControlStateNormal];
    [Calander setFrame:CGRectMake(self.view.frame.size.width/2-20, 10, 110, 30)];
    [Calander setTitle:@"Calender" forState:UIControlStateNormal];
    [Calander setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [Calander addTarget:self action:@selector(calendar:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"global_icon_left_logo.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(-10, 2.5, 38, 38)];
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    /*2222222222222222=====================222222222222222222*/
    
    
    
    
    //city_btn.font = [UIFont fontWithName:@"" size:20];
    /*********[Table Refresh Control]************/
   
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor blackColor] ;
    refreshControl.tintColor = [UIColor whiteColor];
    
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.listtable addSubview:refreshControl];
    
    
    /*****[CALENDER VIEW]*****/
    
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(0, 60, 320, 360)];
    _sampleView.delegate    = self;
    _sampleView.calendarDate = [NSDate date];
   // _sampleView.backgroundColor = [UIColor blackColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:_sampleView];
        _sampleView.center = CGPointMake(self.view.center.x, _sampleView.center.y);
    });
    _sampleView.hidden=YES;
    
}


#pragma mark - CalendarDelegate protocol conformance

-(void)dayChangedToDate:(NSDate *)selectedDate
{
    NSLog(@"dayChangedToDate %@(GMT)",selectedDate);
}


- (void)handleRefresh:(id)sender
{
    NSLog(@"Hello Refreshing");
   
    NSString *_urlstring =[NSString stringWithFormat:@"%@/list_events.php?location_id=1",BaseUrl];
    
    NSURL *url=[[NSURL alloc]initWithString:_urlstring];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *connection_jso=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection_jso start];
    [connection_json start];
    
    [refreshControl endRefreshing];
}


-(void)viewDidLayoutSubviews{
    
    NSLog(@"location Array : %@",location_arr);
    
    
    aution_button.layer.cornerRadius = aution_button.frame.size.width/2;
    aution_button.layer.borderColor = [UIColor colorWithRed:251.0f/255 green:156.0f/255 blue:0.0f/255 alpha:1].CGColor;
    aution_button.layer.borderWidth = 2.0f;
    
    scrllview.hidden = YES;
    scrllview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 62, 6*84, 29)];
    scrllview.backgroundColor = [UIColor blackColor];
    scrllview.scrollEnabled=YES;
    [scrllview setContentSize:CGSizeMake(106*(location_arr.count+2), 0)];
    [scrllview setContentOffset:CGPointMake(self.view.frame.size.width*6, 0) animated:YES];
    /*******[CITY BUTTONS IN SCROLL VIEW]*******/
    for (int i=0; i<location_arr.count; i++) {
        
        UIButton *temp_btn = [[UIButton alloc]initWithFrame:CGRectMake((110*i)+2, 4, 100, 15)];
        temp_btn.tag = i;
        temp_btn.layer.cornerRadius = 4.0f;
        temp_btn.backgroundColor = [UIColor darkGrayColor];
        
       // [cell.label1 setText:[text uppercaseString]];
       // temp_btn.font = [UIFont systemFontOfSize:13];
        [temp_btn.titleLabel setFont:[UIFont fontWithName:@"GothamBook-1.otf" size:12]];
        NSString *textCaps;
        textCaps = [[location_arr objectAtIndex:i] uppercaseString];
        [temp_btn setTitle:[NSString stringWithFormat:@"%@",textCaps] forState:UIControlStateNormal];
        
        [temp_btn addTarget:self action:@selector(selectcityAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrllview addSubview:temp_btn];
        
    }
    
    [self.view addSubview:scrllview];
    
    [scrllview setContentOffset:CGPointMake(0, 0)];
    scrllview.hidden=YES;
    
}



-(void)selectcityAction:(UIButton*)sender{
    
    
    int arrayIndex = 0;
    arrayIndex = (int)[location_arr indexOfObject:[NSString stringWithFormat:@"%@",[sender titleForState:UIControlStateNormal]]];
    NSString *location_id = [locationID objectAtIndex:arrayIndex];
    NSString *_urlstring =[NSString stringWithFormat:@"%@/list_events.php?location_id=%@",BaseUrl,location_id];
    NSURL *url=[[NSURL alloc]initWithString:_urlstring];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *connection_jso=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    /**********[OWLERS LOADER WORK START]***********/
    //self.loaderOwlersImage.hidden = NO;
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.toValue = [NSNumber numberWithDouble:M_PI_2];
//    animation.duration = 0.4f;
//    animation.cumulative = YES;
//    animation.repeatCount = HUGE_VALF;
//    [self.loaderOwlersImage.layer addAnimation:animation forKey:@"activityIndicatorAnimation"];
//    /**********[OWLERS LOADER WORK END]***********/
    
    
    [connection_jso start];
}

#pragma marks IBAction

-(IBAction)seachBackAction:(id)sender{
    
    
    search_back_btn.hidden=YES;
    topSearchBGImage.hidden=YES;
    textfield.hidden=YES;
    
    
}

-(IBAction)searchAction:(id)sender{
    
    if(textfield.hidden){
        
        topSearchBGImage.backgroundColor = [UIColor colorWithRed:65.0f/255 green:65.0f/255 blue:65.0f/255 alpha:1];
        
        search_back_btn.hidden=NO;
        topSearchBGImage.hidden=NO;
        textfield.hidden=NO;
        
    }else if(textfield.text.length != 0){
        
        NSString *_urlstring =[NSString stringWithFormat:@"%@/search_events.php?search_box=%@",BaseUrl,textfield.text.self];
        NSURL *url=[[NSURL alloc]initWithString:_urlstring];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        NSURLConnection *connection_jso=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        [connection_jso start];
    
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Search cannot be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
        [alertView show];
    }
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


-(IBAction)cityBtn:(id)sender{
    
    if (!scrllview.hidden) {
        
        
        //citycheck = NO;
        scrllview.hidden=YES;
        self.listtable.frame = CGRectMake(self.listtable.frame.origin.x, 62, self.listtable.frame.size.width, self.listtable.frame.size.height);
    }
    else{
        
        scrllview.hidden=NO;
        self.listtable.frame = CGRectMake(self.listtable.frame.origin.x, 85, self.listtable.frame.size.width, self.listtable.frame.size.height);
        
        //citycheck = YES;
    }
    
    
    
    //    NSLog(@"Hello  !!");
    //
    //    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-5, 65, 130, 300) style:UITableViewStylePlain];
    //    [self.tableView setDataSource:self];
    //    [self.tableView setDelegate:self];
    //    [self.tableView setShowsVerticalScrollIndicator:NO];
    //    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //    [self.view addSubview:self.tableView];
    //    self.dataArray = [@[@""] mutableCopy];
    //
}
/***************[AUCTION BUTTON HIDDEN]******************/
- (IBAction)btnAction:(id)sender {
    
    if (!login_status) {
        
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Unable to auction without login" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
    
    [alert show];
        return;
    }
    
    AuctionViewController *auction=[[AuctionViewController alloc]init];
    [self.navigationController pushViewController:auction animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{



    if (buttonIndex==1) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
}

/*******[OWLERS HOME MENU BUTTON]*******/
-(IBAction)button:(UIButton *)sender
{
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    if (login_status) {
        self.tableView.frame = CGRectMake(5, 63, 200, 250);
    }else
        self.tableView.frame = CGRectMake(5, 63, 200, 100);
    if (menucheck) {
        menucheck=NO;
        self.tableView.hidden=YES;
    }
    else{
        menucheck=YES;
        self.tableView.hidden=NO;
    }
    [self.tableView reloadData];
}

-(void)loginStatus{
    
    if (!login_status) {
        
        // self.listtable.userInteractionEnabled  = NO;
        
    }else{
    
       //  self.listtable.userInteractionEnabled  = YES;
    
    }
}

//-(void)searchbarbutton:(UIButton *)sender
//{
//
//   // self.search =[[UISearchBar alloc]init];
//
//}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error = %@", [error localizedDescription]);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    serverData = [[NSMutableData alloc]init];
    locationData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [serverData appendData:data];
    [locationData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    if (connection == connection_json) {
        
      //  location_arr = nil;
      //  location_arr = [[NSMutableArray alloc]init];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:locationData options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@ city list ",dic);
        
      //        if (dic == NULL) {
//            UIAlertView
//        }
        
        NSArray *temparr = [dic objectForKey:@"Locations"];
      //  NSLog(@"Location array : %@",temparr);
        
        
        [location_arr removeAllObjects];
        [locationID removeAllObjects];
      
        
       
        for (NSDictionary *dic in temparr) {
            
            [location_arr addObject:[dic objectForKey:@"location_name"]];
            [locationID addObject:[dic objectForKey:@"location_id"]];
            //[location_arr addObject:[dic objectForKey:@"Locations"]];
            
            
        }
        NSLog(@"LocationName Array : %@",locationID);
        
        [self viewDidLayoutSubviews];
        return;
        
        
    }
    serverDataDictionary = [NSJSONSerialization JSONObjectWithData:serverData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"serverDataArray =%@",serverDataDictionary);
    
//    NSString *items = [serverDataDictionary objectForKey:@"items"];
//    
//    if (items.length == 0) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"No data found according to search" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
//        [alertView show];
//        [self.listtable reloadData];
//    }
    
    
    
    [self.listtable reloadData];
    
   
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==self.tableView)
    {
        return [self.dataArray count];
        
    }
    return [[serverDataDictionary objectForKey:@"items"] count];
    return [recipes count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        // This is the last cell
       // [self loadMore];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (tableView ==self.tableView) {
        
                 if (indexPath.row ==0) {
            
            if (!login_status) {
                LoginViewController *profile =[[LoginViewController alloc]init];
                [self.navigationController pushViewController:profile animated:YES];

                return;
            }
            ProfileViewController *profile=[[ProfileViewController alloc]init];
            [self.navigationController pushViewController:profile animated:YES];
            
        }
        if (indexPath.row ==1) {
            
            if (!login_status) {
                SignupViewController *profile =[[SignupViewController alloc]init];
                [self.navigationController pushViewController:profile animated:YES];
                
                return;
            }

            
            SettingViewController *setting =[[SettingViewController alloc]init];
            [self.navigationController pushViewController:setting animated:YES];
        }
//        if (indexPath.row ==2) {
//            AuctionViewController *auction =[[AuctionViewController alloc]init];
//            [self.navigationController pushViewController:auction animated:YES];
//        }
        if (indexPath.row ==2) {
            MyBidsViewController *bids =[[MyBidsViewController alloc]init];
            [self.navigationController pushViewController:bids animated:YES];
            
        }
        if (indexPath.row == 3) {
            
            
            self.loginViewController = [[LoginViewController alloc] init];
            
            [self.loginViewController logout_status];
            
            
            login_status = NO;
            
            [self.dataArray removeAllObjects];
            
            [self.dataArray addObject:@"Login"];
            [self.dataArray addObject:@"Signup"];
            
            [self loginStatus];
            
        
        }
        self.tableView.hidden=YES;
    }
    
    
    
    //    UIButton *btn ;
    //
    //
    //    [btn setTitle:[self.dataArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    else if (tableView ==self.listtable)
    {
        
        OwlersViewController *owlers=[[OwlersViewController alloc]init];
        
        [owlers setEvent_id:[[[serverDataDictionary objectForKey:@"items"]objectAtIndex:indexPath.row] objectForKey:@"event_id"]];
        
        
        
        [self.navigationController pushViewController:owlers animated:YES];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView ==self.tableView)
    {
        NSString *cellIdentifier = @"CustomCell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
      

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        
        int dataIndex = (int) indexPath.row % [self.dataArray count];
        cell.textLabel.text = self.dataArray[dataIndex];
        cell.textLabel.font = [UIFont systemFontOfSize:22];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        
//        Recipe *recipe = [recipes objectAtIndex:indexPath.row];
//        cell.nameLabel.text = recipe.name;
//        cell.thumbnailImageView.image = [UIImage imageNamed:recipe.image];
//        cell.prepTimeLabel.text = recipe.prepTime;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 50, 200, 1)];
        view.backgroundColor =[UIColor colorWithRed:241.0f/255 green:241.0f/255 blue:241.0f/255 alpha:0.35];
        [cell addSubview:view];
        
       
        self.tableView.separatorColor = [UIColor clearColor];
        if (indexPath.row==0) {
            cell.backgroundColor= [UIColor colorWithRed:48.0f/255 green:48.0f/255 blue:48.0f/255 alpha:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        if (indexPath.row) {
            cell.backgroundColor= [UIColor colorWithRed:48.0f/255 green:48.0f/255 blue:48.0f/255 alpha:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        if(myInteger == 0){
            
            [self.tableView setHidden:NO];
            myInteger = 1;
        }else{
            
            [self.tableView setHidden:YES];
            myInteger = 0;
        }
        return cell;
    }
    
    
    
    
    static NSString *cellId = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        cell =[nib objectAtIndex:0];
    }
    
    self.listtable.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSString *text = [[[serverDataDictionary objectForKey:@"items"]objectAtIndex:indexPath.row] objectForKey:@"event_name"];
    [cell.label1 setText:[text uppercaseString]];
    cell.label2.text = [[[serverDataDictionary objectForKey:@"items"]objectAtIndex:indexPath.row] objectForKey:@"venue"];
    cell.label3.text = [[[serverDataDictionary objectForKey:@"items"]objectAtIndex:indexPath.row] objectForKey:@"location_code"];
    
    NSString *temp_img = @"http://owlers.com/event_images/";
    temp_img = [temp_img stringByAppendingString:[[[serverDataDictionary objectForKey:@"items"]objectAtIndex:indexPath.row] objectForKey:@"event_image"]];
    
    [cell.cellBackgroundImage sd_setImageWithURL:[NSURL URLWithString:temp_img]
                                placeholderImage:[UIImage imageNamed:@"new_background_ullu.png"]];
    //cell.cellBackgroundImage .clipsToBounds = YES;
    cell.cellBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, cell.frame.size.width, 202)];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    self.loaderOwlersImage.hidden = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        return 50;
    }
    return 202;
}



#pragma tableview refresh
//- (void)reloadData
//{
//    [self.tableView reloadData];
//}






/* for table 11111111111111*/


-(void) showAndEnableRightNavigationItem
{
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}


#pragma marks UICollection View Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 6;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    if (cell==nil) {
        
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil];
        
        cell = (CollectionViewCell*)[arr objectAtIndex:0];
    }
    
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *temp = [location_arr objectAtIndex:indexPath.row];
    
    
    
    
}

#pragma mark UITextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textfield resignFirstResponder];
    
    return YES;
    
}

#pragma mark private methods


/*
-(void)locationSearching:(NSString*)search_txt{
    
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self.address contains[cd] %@",search_txt];
    arr_searching=[arr_slapsall filteredArrayUsingPredicate:predicate ];
    for (SlapsList *sl in arr_slapsall) {
        NSLog(@"---%@",sl.address);
    }
    if (arr_searching.count>0)
    {
        isSlapSearching=YES;
        [table_location reloadData];
    }else{
        if ([search_location.text isEqualToString:@""]) {
            isSlapSearching=NO;
        }
        isSlapSearching=YES;
        [table_location reloadData];
        
        
    }
    
}

 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma calendar coding


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)calendarView:(DSLCalendarView*)calendarView didSelectRange:(DSLCalendarRange*)range;
{
    if (range != nil) {
        NSLog( @"Selected %ld/%ld - %ld/%ld", (long)range.startDay.day, (long)range.startDay.month, (long)range.endDay.day, (long)range.endDay.month);
        
        NSString *month =@"";
        if (range.startDay.month==1) {
            
            month = @"January";
        }
        if (range.startDay.month==2) {
            
            month = @"February";
        }
        if (range.startDay.month==3) {
            
            month = @"March";
        }
        if (range.startDay.month==4) {
            
            month = @"April";
        }
        if (range.startDay.month==5) {
            
            month = @"May";
        }
        if (range.startDay.month==6) {
            
            month = @"June";
        }if (range.startDay.month==7) {
            
            month = @"July";
        }
        if (range.startDay.month==8) {
            
            month = @"August";
        }
        if (range.startDay.month==9) {
            
            month = @"September";
        }
        if (range.startDay.month==10) {
            
            month = @"October";
        }
        if (range.startDay.month==11) {
            
            month = @"November";
        }
        if (range.startDay.month==12) {
            
            month = @"December";
        }
        
        //[btn_calender setTitle:[NSString stringWithFormat:@"%@ %ld",month,range.startDay.year] forState:UIControlStateNormal];
        
    }
    else {
        NSLog( @"No selection" );
    }
    
}
- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range {
    if (NO) { // Only select a single day
        return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
    }
    else if (/* DISABLES CODE */ (NO)) { // Don't allow selections before today
        NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
        
        NSDateComponents *startDate = range.startDay;
        NSDateComponents *endDate = range.endDay;
        
        if ([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today]) {
            return nil;
        }
        else {
            if ([self day:startDate isBeforeDay:today]) {
                startDate = [today copy];
            }
            if ([self day:endDate isBeforeDay:today]) {
                endDate = [today copy];
            }
            
            return [[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate];
        }
    }
    
    return range;
}
- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}

- (IBAction)calendarAction:(id)sender {
    if (!_sampleView.hidden) {
        _sampleView.hidden = YES;
        self.listtable.frame = CGRectMake(self.listtable.frame.origin.x, 62, self.listtable.frame.size.width, self.listtable.frame.size.height);

    }
    else{
        _sampleView.hidden = NO;
        self.listtable.frame = CGRectMake(self.listtable.frame.origin.x, 350, self.listtable.frame.size.width, self.listtable.frame.size.height);

    }
    
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = nil;
        recipes  = nil;
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            recipes = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            recipes = [recipes objectAtIndex:indexPath.row];
        }
        
        OwlersViewController *destViewController = segue.destinationViewController;
    }
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

@end
