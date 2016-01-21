//
//  RegisterViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/20/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "ViewController.h"

@interface RegisterViewController : ViewController
@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmpass;

@end
