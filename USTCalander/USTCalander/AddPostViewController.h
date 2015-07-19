//
//  AddPostViewController.h
//  USTCalander
//
//  Created by Amruth on 19/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerBridgeView.h"

@interface AddPostViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak) IBOutlet UIImageView * postImage;
@property(nonatomic,weak) IBOutlet UITextView * statusText;

- (IBAction)closeView:(id)sender;
- (IBAction)openCamera:(id)sender;
- (IBAction)openGallery:(id)sender;
- (IBAction)tagAgenda:(id)sender;
- (IBAction)postActivity:(id)sender;


@end
