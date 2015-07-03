//
//  SlideBarTitleTableViewCell.h
//  USTCalander
//
//  Created by Amruth on 04/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideBarTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *locationInfo_label;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic_imageview;

@end
