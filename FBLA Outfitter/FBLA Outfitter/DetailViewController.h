//
//  DetailViewController.h
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/23/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{
    IBOutlet UITextView *captionText;
    IBOutlet UILabel *likesLabel;
    IBOutlet UIImageView *photoImg;
    
}

@property (weak, nonatomic) IBOutlet UIButton *likeOufit;
@property (strong, nonatomic) NSString *post_id;
@property (strong, nonatomic) NSData *photo;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) NSString *likes;
@property (strong, nonatomic) NSString *user_id;

@end
