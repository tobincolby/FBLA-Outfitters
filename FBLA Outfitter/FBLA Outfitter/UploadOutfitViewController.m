//
//  UploadOutfitViewController.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "UploadOutfitViewController.h"
#import "SWRevealViewController.h"

@interface UploadOutfitViewController (){
    UIAlertView *alert;
}

@end

@implementation UploadOutfitViewController

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view, typically from a nib.
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    _barButton.image = [UIImage imageNamed:@"menu2.png"];
    self.navigationItem.title = @"Upload Outfit";
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.imgHolder.layer.cornerRadius = 6;
    self.imgHolder.clipsToBounds = YES;
    self.imgHolder.layer.borderWidth = 1.0f;
    
    
    // Do any additional setup after loading the view.
    if (self.view.frame.size.height != 480){
        [_textView becomeFirstResponder];

    }
    
    alert = [[UIAlertView alloc]initWithTitle:@"Select Image" message:@"Select an image to upload by taking a picture from your Camera or Photo Library!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Photo Library", nil];
    //[alert show];
    
    count = 0;
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _textView.delegate = self;
    _textView.text = @"Question...";
    _textView.textColor = [UIColor lightGrayColor];

    
    [super viewDidLoad];

}

-(void) viewDidAppear:(BOOL)animated{
    if(count == 0){
        [self show];
    }
    [super viewDidAppear:YES];
}

-(void) show{
    TWPhotoPickerController *photoPicker = [[TWPhotoPickerController alloc] init];
    
    photoPicker.cropBlock = ^(UIImage *image) {
        //do something
        self.imgHolder.image = image;
    };
    
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:photoPicker];
    [navCon setNavigationBarHidden:YES];
    
    [self presentViewController:navCon animated:NO completion:NULL];
    count++;
}

- (IBAction)showAction:(id)sender {
    TWPhotoPickerController *photoPicker = [[TWPhotoPickerController alloc] init];
    
    photoPicker.cropBlock = ^(UIImage *image) {
        //do something
        self.imgHolder.image = image;
    };
    
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:photoPicker];
    [navCon setNavigationBarHidden:YES];
    
    [self presentViewController:navCon animated:YES completion:NULL];
}


//Text View Properties
-(BOOL)textView:(UITextView *)_textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self adjustFrames];
    return YES;
}


-(void) adjustFrames {
    CGRect textFrame = _textView.frame;
    textFrame.size.height = _textView.contentSize.height;
    
    CGRect imageFrame = self.imgHolder.frame;
    imageFrame.origin.y += (textFrame.size.height - _textView.frame.size.height);
    self.imgHolder.frame = imageFrame;
    self.imgHolder.translatesAutoresizingMaskIntoConstraints = YES;
    
    /*CGRect buttonFrame = _editButton.frame;
    buttonFrame.origin.y += (textFrame.size.height - _textView.frame.size.height);
    _editButton.frame = buttonFrame;
    self.editButton.translatesAutoresizingMaskIntoConstraints = YES;
    _submitButton.frame = buttonFrame;
    self.submitButton.translatesAutoresizingMaskIntoConstraints = YES;*/
    
    _textView.frame = textFrame;
    self.textView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = CGSizeMake(contentRect.size.width, contentRect.size.height+15);
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textField {
    if([self.textView.text isEqualToString:@""] || [self.textView.text isEqualToString:@"Question..."]){
        self.textView.text = @"";
    }
    
    self.textView.textColor = [UIColor blackColor];
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if([self.textView.text isEqualToString:@""] || [self.textView.text isEqualToString:@"Question..."]){
        self.textView.text = @"Question...";
        self.textView.textColor = [UIColor lightGrayColor];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.textView resignFirstResponder];
        [self.view endEditing:YES];
        
        if([self.textView.text isEqualToString:@""]){
            self.textView.textColor = [UIColor lightGrayColor];
            self.textView.text = @"Question...";
        }
    }
}


/*-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == alert){
    if(buttonIndex == 1){
        [self takeImageWithCamera];
    }else if(buttonIndex == 2){
        [self selectImageFromLibrary];
    }
    }
}*/


- (IBAction)takePic:(id)sender {
    TWPhotoPickerController *photoPicker = [[TWPhotoPickerController alloc] init];
    
    photoPicker.cropBlock = ^(UIImage *image) {
        //do something
        self.imgHolder.image = image;
    };
    
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:photoPicker];
    [navCon setNavigationBarHidden:YES];
    
    [self presentViewController:navCon animated:YES completion:NULL];
}

-(IBAction)sumbit:(id)sender{
    [self uploadPost:self.textView.text];
}

-(IBAction)resign:(id)sender{
    [_textView resignFirstResponder];
    [self.view endEditing:YES];
    
    if([self.textView.text isEqualToString:@""]){
        self.textView.textColor = [UIColor lightGrayColor];
        self.textView.text = @"Question...";
    }

}


//Chat Input Properties
- (void)tappedView:(UITapGestureRecognizer*)tapper
{
    [_textView resignFirstResponder];
    [self.view endEditing:YES];
    
    if([self.textView.text isEqualToString:@""]){
        self.textView.textColor = [UIColor lightGrayColor];
        self.textView.text = @"Question...";
    }

}


-(void)takeImageWithCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    }else{
    UIAlertView *alertError = [[UIAlertView alloc]initWithTitle: @"Source Unavailable"
                                                   message: @"Sorry for the inconvenience, but your camera is currently unavailable!"
                                                  delegate: self
                                         cancelButtonTitle:@"Dismiss"
                                         otherButtonTitles:nil];
    [alertError show];
    }
}

/*-(void)selectImageFromLibrary{
    
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
    [_chatInput.textView becomeFirstResponder];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [_chatInput.textView becomeFirstResponder];

}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)uploadPost: (NSString *) text {
    
    //this is where db connection comes in and post is uploaded
    if(![self.imgHolder.image isEqual:nil] && ! [text isEqualToString:@""]){
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set Params
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    //Create boundary, it can be anything
    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
        NSMutableString *str = [NSMutableString stringWithString:text];
        str = [str stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        str = [str stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];


    [parameters setValue:user forKey:@"user_id"];
    
    [parameters setValue:str forKey:@"post_text"];
    
    
    
    // add params (all params are strings)
    for (NSString *param in parameters) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *FileParamConstant = @"fileToUpload";
    
    NSData *imageData = UIImageJPEGRepresentation(self.imgHolder.image,1);
    
    //Assuming data is not nil we add this to the multipart form
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //Close off the request with the boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:[NSURL URLWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/uploadoutfit.php"]];
    NSLog(@"about to request");
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                               NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                               NSLog(responseString);
                               if ([httpResponse statusCode] == 200 && [responseString isEqualToString:@"success"]) {
                                   NSLog(@"success");
                                   //self.imgHolder.image = nil;
                                   //text = @"";
                                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Upload Success"
                                                                                  message: @"Your outfit has been successfully uploaded!"
                                                                                 delegate: self
                                                                        cancelButtonTitle:@"Dismiss"
                                                                        otherButtonTitles:nil];
                                   [alert show];
                                   [_textView becomeFirstResponder];
                                   [_textView setText:@"Question..."];
                                   [_textView setTextColor:[UIColor lightGrayColor]];

                               }else{
                                   NSLog(@"error");
                                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Upload Error"
                                                                                  message: @"There was an error in trying to upload your outfit! Please try again!"
                                                                                 delegate: self
                                                                        cancelButtonTitle:@"Dismiss"
                                                                        otherButtonTitles:nil];
                                   [alert show];
                               }
                               
                           }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Upload Error"
                                                       message: @"You must fill out all parts of this form!"
                                                      delegate: self
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
        [alert show];
    }
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
