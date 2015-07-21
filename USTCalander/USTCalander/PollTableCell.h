//
//  PollTableCell.h
//  USTCalander
//
//  Created by Rony Antony on 21/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView * profileImageView;
@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UILabel * descripLabel;
@property (weak, nonatomic) IBOutlet UILabel * timeLabel;
@property (weak, nonatomic) IBOutlet UILabel * voteLabel;


@end
