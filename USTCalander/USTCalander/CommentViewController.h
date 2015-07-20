//
//  CommentViewController.h
//  USTCalander
//
//  Created by Amruth on 20/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController

@property(nonatomic,strong)NSString * postID;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

- (IBAction)closeView:(id)sender;
- (IBAction)commentAction:(id)sender;

@end
