//
//  AddPostViewController.m
//  USTCalander
//
//  Created by Amruth on 19/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AddPostViewController.h"
#import "AgendaViewController.h"
#import "USTServiceProvider.h"

@interface AddPostViewController ()
@property(nonatomic, strong)NSString * selectedAgenda;

@end

@implementation AddPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*ContainerBridgeView * contBridgObj = [ContainerBridgeView sharedInstance];
    RootContainerView * rootContObj = (RootContainerView *)[contBridgObj getRootContainerObj];
    rootContObj.titleLabel.text = @"Add Post";*/
    
    [self addNotificationObserver];
//    self.statusText.delegate=self;
    self.statusText.text = @"";
    _selectedAgenda=@"";
   // self.statusText.textColor = [UIColor lightGrayColor];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    //self.statusText.text = @"";
   // self.statusText.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.statusText.text.length == 0){
       // self.statusText.textColor = [UIColor lightGrayColor];
        //self.statusText.text = @"Status";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
-(void)addNotificationObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(agendaSelected:) name:@"AgendaSelectedNotification" object:nil];

}

-(void)agendaSelected:(NSNotification*)notification{
    _selectedAgenda=(NSString*)notification.object;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(IBAction)openCamera:(id)sender{
    [self showCameraUI];
}

-(IBAction)openGallery:(id)sender{
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)tagAgenda:(id)sender{
    AgendaViewController * agendaList = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AgendaVC"];
        agendaList.agendaType=@"selectAgenda";
    UINavigationController * navCtrl = [[UINavigationController alloc]initWithRootViewController:agendaList];
    [navCtrl.navigationBar setBarTintColor: [UIColor colorWithRed:2/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
    navCtrl.navigationBar.topItem.title = @"Select Agenda";
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:21],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    navCtrl.navigationBar.titleTextAttributes = size;
      /*[self presentViewController:agendaList animated:YES completion:^{
        
    }];*/
    [self presentViewController:navCtrl animated:YES completion:nil];
}


- (IBAction)postActivity:(id)sender{
    //    //to post activity
        NSData *data= [[NSData alloc]init];//
        data=UIImagePNGRepresentation(self.postImage.image);
    if (data.length) {
        [USTServiceProvider uploadImage:data WithCompletionHandler:^(USTRequest * request) {
            NSString* imageName = [NSString stringWithFormat:@"%@",[request.responseDict objectForKey:@"image_name"]];
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:_statusText.text forKey:@"text"];
            [dict setObject:_selectedAgenda forKey:@"agendaId"];
//            [dict setObject:data forKey:@"imageData"];
            
            if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
                [USTServiceProvider addPostWithData:dict andImageName:imageName WithCompletionHandler:^(USTRequest * request) {
                    if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
                        [self dismissViewControllerAnimated:YES completion:^{

                            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"UST" message:@"Post added.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                        }];
                    }
                    else{
                        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"UST" message:@"Post failed try again.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                    }
                    
//                    [USTServiceProvider getActivityFeed:[NSNumber numberWithInt:20] andPage:[NSNumber numberWithInt:0] withCompletionHandler:^(USTRequest * request) {
//                        
//                        if (request.responseDict) {
//                           // self.dataArray = [NSMutableArray arrayWithArray:[request.responseDict objectForKey:@"post"]];
//                        }
//                        
//                    }];
                }];
            }
            
        }];
    }
    else{
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:_statusText.text forKey:@"text"];
        [dict setObject:_selectedAgenda forKey:@"agendaId"];
        
        [USTServiceProvider addPostWithData:dict andImageName:@"" WithCompletionHandler:^(USTRequest * request) {
            if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"UST" message:@"Post added.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }];
            }
            else{
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"UST" message:@"Post failed try again.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
           
        }];
    }
    
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    self.postImage.image = image;
    //pngData = UIImagePNGRepresentation(image);
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)){
        return NO;
    }
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:^{
        
    }];//cameraUI animated: YES];
    return YES;
}

- (void)showCameraUI {
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}



@end
