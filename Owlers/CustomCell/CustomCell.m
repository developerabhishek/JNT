//
//  CustomCell.m
//  Owlers
//
//  Created by Biprajit Biswas on 12/10/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    
    //[label1 setFont:[UIFont systemFontOfSize:30]];
    //[label1 sizeToFit];
    //label1.text = [label1.text uppercaseString];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
   // [[self.cellBackgroundImage view] setFrame:[[self view] bounds]];
    
   // self.cellBackgroundImage.frame = self.bounds;
    
//    self.cellBackgroundImage.frame = CGRectMake(0,0,320,200);
//    self.overLayImage.frame = CGRectMake(0, 0, 320, 200);
}


@end
