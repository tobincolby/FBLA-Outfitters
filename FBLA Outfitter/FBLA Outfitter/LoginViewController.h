//
//  LoginViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 12/4/15.
//  Copyright © 2015 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *passwordLogin;
@property (strong, nonatomic) IBOutlet UITextField *usernameLogin;
@property (strong, nonatomic) IBOutlet UITextField *registerhere;
@property (strong, nonatomic) IBOutlet UIButton *registerSubmit;
@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UINavigationBar *navbar;
@property (strong, nonatomic) IBOutlet UITextField *usernameRegister;
@property (strong, nonatomic) IBOutlet UITextField *passwordRegister;
@property (strong, nonatomic) IBOutlet UITextField *confirmpassRegister;
@end
