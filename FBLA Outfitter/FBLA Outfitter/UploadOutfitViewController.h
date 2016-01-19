//
//  UploadOutfitViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadOutfitViewController : UIViewController <UIImagePickerControllerDelegate>

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (strong, nonatomic) IBOutlet UIImageView *imgHolder;
@property (strong, nonatomic) IBOutlet UITextView *commentText;

@end
