//
//  UploadOutfitViewController.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "UploadOutfitViewController.h"
#import "SWRevealViewController.h"


@interface UploadOutfitViewController ()

@end

@implementation UploadOutfitViewController

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view, typically from a nib.
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    _barButton.image = [UIImage imageNamed:@"menu2.png"];
    self.navigationItem.title = @"Upload Outfit";
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.commentText.layer.cornerRadius = 5;
    self.commentText.clipsToBounds = YES;
    self.commentText.layer.borderWidth = 1.0f;
    self.commentText.layer.borderColor = [[UIColor blackColor]CGColor];
    
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];

}
- (IBAction)lookInLibrary:(id)sender {
    [self selectImageFromLibrary];
}
- (IBAction)takePic:(id)sender {
    [self takeImageWithCamera];
}

-(void)takeImageWithCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    }else{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Source Unavailable"
                                                   message: @"Sorry for the inconvenience, but your camera is currently unavailable!"
                                                  delegate: self
                                         cancelButtonTitle:@"Dismiss"
                                         otherButtonTitles:nil];
    [alert show];
    }
}

-(void)selectImageFromLibrary{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.imgHolder.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)uploadPost:(id)sender {
    
    //this is where db connection comes in and post is uploaded
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
