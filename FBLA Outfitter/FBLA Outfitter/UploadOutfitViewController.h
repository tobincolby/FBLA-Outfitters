//
//  UploadOutfitViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THChatInput.h"
#import "TWPhotoPickerController.h"

int count;
@interface UploadOutfitViewController : UIViewController <UIImagePickerControllerDelegate, UITextViewDelegate>

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *imgHolder;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end
