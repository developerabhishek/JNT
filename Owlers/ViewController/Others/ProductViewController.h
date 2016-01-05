//
//  ProductViewController.h
//  Owlers
//
//  Created by Biprajit Biswas on 25/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CalendarView.h"
@interface ProductViewController : UIViewController<UINavigationBarDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate,CalendarDelegate>

{
     
    /*         for 2nd url          */
    
    NSArray *ar;
    NSMutableDictionary *diCT;
    NSMutableData *daTA;
    
    /*          end              */
    
    NSArray *searchResults;
    IBOutlet UIActivityIndicatorView *activityindicator;
    
    IBOutlet UIButton *city_btn;
    NSArray *arrayname ,*recipes;
    NSArray *listimage;
    NSMutableData *serverData;
    NSMutableData *locationData;
    NSMutableDictionary *serverDataDictionary;
    NSMutableArray *location_arr;
    NSMutableArray *locationID;
   // IBOutlet UITableView *tablelist;
    UICollectionView *collectionview;
    IBOutlet UIButton *btn_calender;
    IBOutlet UIButton *search_back_btn;
    IBOutlet UIImageView *topSearchBGImage;
    IBOutlet UITextField *textfield;
    
    IBOutlet UICollectionView *collection;
    IBOutlet UIButton *aution_button;
    
    BOOL menucheck;
    BOOL searchCheck;
    BOOL citycheck;
    BOOL flag;
    BOOL calendar_check;
    BOOL login_status;

    UIScrollView *scrllview;
}
@property (strong, nonatomic)  NSString *location_id;
@property(nonatomic,strong) UICollectionView *collection;
@property (strong , nonatomic) IBOutlet UIImageView *loaderOwlersImage;

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UITableViewCell *customCell;

@property (nonatomic, strong) LoginViewController * loginViewController;

@property(strong,nonatomic) NSMutableArray *arraydata;
@property(strong,nonatomic) NSArray *imagelist;
-(IBAction)cityBtn:(id)sender;
- (IBAction)btnAction:(id)sender;
//@property (strong, nonatomic) IBOutlet UITextField *calendarAction;
- (IBAction)calendarAction:(id)sender;

@end
