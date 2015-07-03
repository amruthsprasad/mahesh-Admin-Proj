//
//  SlideBarTitleTableViewCell.m
//  USTCalander
//
//  Created by Amruth on 04/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "SlideBarTitleTableViewCell.h"

@implementation SlideBarTitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.profilePic_imageview.layer.cornerRadius = self.profilePic_imageview.frame.size.width / 2;
    self.profilePic_imageview.clipsToBounds = YES;
    self.profilePic_imageview.layer.borderWidth = 2.0f;
    self.profilePic_imageview.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
