//
//  ActivityFeedCell.h
//  USTCalander
//
//  Created by Amruth on 02/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel * title;
@property (weak, nonatomic) IBOutlet UILabel * time;
@property (weak, nonatomic) IBOutlet UILabel * description;
@property (weak, nonatomic) IBOutlet UIImageView * actionImg;

@end
