//
//  DetailViewController.h
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/23/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THChatInput.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, THChatInputDelegate>{
    IBOutlet UITextView *captionText;
    IBOutlet UILabel *likesLabel;
    IBOutlet UIImageView *photoImg;
    IBOutlet UIButton *usernameLabel;
    
    //User who posted outfit
    NSMutableArray *jsonUser;
    //All of the comments
    NSMutableArray *jsonComments;
    //All of the users
    NSMutableArray *jsonUsers;
    //Usernames of users who posted comments
    NSMutableArray *usernameArray;
    
    NSURLConnection *postConnection;
    IBOutlet UITableView *tableView;
    UIRefreshControl *refreshControl;
    IBOutlet UILabel *messageLabel;
    
}

@property (strong, nonatomic) NSString *logged_user_id;

@property (weak, nonatomic) IBOutlet UIButton *likeOufit;
@property (strong, nonatomic) NSString *post_id;
@property (strong, nonatomic) NSData *photo;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) NSString *likes;
@property (strong, nonatomic) NSString *user_id;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet THChatInput *chatInput;
@property (strong, nonatomic) IBOutlet UIView *emojiInputView;

-(IBAction)shareOutfit:(id)sender;

@end
