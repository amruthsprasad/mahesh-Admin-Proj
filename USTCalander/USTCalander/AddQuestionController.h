//
//  AddQuestionController.h
//  USTCalander
//
//  Created by Rony Antony on 22/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddQuestionController : UIViewController

@property(nonatomic,weak) IBOutlet UITextView * QuestionTextView;

- (IBAction)closeView:(id)sender;
- (IBAction)postQuestion:(id)sender;



@end
