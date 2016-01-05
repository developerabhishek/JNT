//
//  BidSectionViewController.h
//  Owlers
//
//  Created by Biprajit Biswas on 22/10/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidSectionViewController : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITextFieldDelegate>
{
    NSMutableData *serverdata;
    NSMutableDictionary *serverDictionary;
    NSArray *arr;
    IBOutlet UITextField *bidAmtTextFld;
    
   IBOutlet UIScrollView *scrollview;
}
- (IBAction)backBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property(strong,nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic,strong) IBOutlet UIImageView *imageoo;
@property (strong, nonatomic) IBOutlet UILabel *maxbidLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalBidLabel;
@property(nonatomic,strong)IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UITextField *bidAmtTextFld;


@property(strong,nonatomic) NSString *desc;
@property(strong,nonatomic) NSString *owlersname;
@property(strong,nonatomic) NSString *owlersimage;
@property (strong,nonatomic) NSString *amount;
@property(nonatomic,strong) NSString *url;
- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)buyBtnAction:(id)sender;
- (IBAction)submitBtnAction:(id)sender;

@end
