//
//  CustomCell.h
//  Owlers
//
//  Created by Biprajit Biswas on 12/10/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *label1;
}

@property (strong, nonatomic) IBOutlet UIImageView *cellBackgroundImage;
@property (strong, nonatomic) IBOutlet UIImageView *overLayImage;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;

@end
