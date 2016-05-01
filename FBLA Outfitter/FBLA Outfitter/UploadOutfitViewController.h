//
//  UploadOutfitViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THChatInput.h"

@interface UploadOutfitViewController : UIViewController <UIImagePickerControllerDelegate, THChatInputDelegate>

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet THChatInput *chatInput;
@property (strong, nonatomic) IBOutlet UIView *emojiInputView;

@property (strong, nonatomic) IBOutlet UIImageView *imgHolder;

@end
