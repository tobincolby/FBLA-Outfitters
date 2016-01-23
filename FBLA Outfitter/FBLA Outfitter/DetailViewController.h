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

@property (strong, nonatomic) NSString *post_id;
@property (strong, nonatomic) NSData *photo;
@property (strong, nonatomic) NSArray *caption;
@property (strong, nonatomic) NSArray *likes;
@property (strong, nonatomic) NSString *user_id;

@end
