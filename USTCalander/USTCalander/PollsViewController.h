//
//  PollsViewController.h
//  USTCalander
//
//  Created by Rony Antony on 21/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PollTableCell.h"
#import "AddPostViewController.h"

@interface PollsViewController : UIViewController

@property(nonatomic,weak) IBOutlet UILabel * voteRemainLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic , strong)NSString* agendaID;
- (IBAction)postQuestionBtnAction:(id)sender;

@end
