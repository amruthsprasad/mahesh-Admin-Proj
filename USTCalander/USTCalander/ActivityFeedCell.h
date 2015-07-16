//
//  ActivityFeedCell.h
//  USTCalander
//
//  Created by Amruth on 02/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *seperator1;
@property (weak, nonatomic) IBOutlet UIView *seperator2;
@property (weak, nonatomic) IBOutlet UIView *seperator3;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;

@end
