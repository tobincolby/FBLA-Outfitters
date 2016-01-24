//
//  LoginViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 12/4/15.
//  Copyright © 2015 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    NSString *loginSuc;
    NSMutableArray *json;
    NSString *email;
    NSString *firstName;
    NSString *lastName;
    NSString *name;
    NSString *userID;
    NSString *usrname;
    NSString *about_me;
}
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *passwordLogin;
@property (strong, nonatomic) IBOutlet UITextField *usernameLogin;
@property (strong, nonatomic) IBOutlet UIButton *registerhere;
@property (strong, nonatomic) IBOutlet UIButton *registerSubmit;
@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UINavigationBar *navbar;
@property (strong, nonatomic) IBOutlet UITextField *usernameRegister;
@property (strong, nonatomic) IBOutlet UITextField *passwordRegister;
@property (strong, nonatomic) IBOutlet UITextField *confirmpassRegister;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UITextView *bio;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end
