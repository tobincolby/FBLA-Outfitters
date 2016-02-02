//
//  CommentViewCell.h
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/29/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@end
