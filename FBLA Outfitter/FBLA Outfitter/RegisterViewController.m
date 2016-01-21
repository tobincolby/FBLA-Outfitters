//
//  RegisterViewController.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/20/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)returnToLogin{
    [self performSegueWithIdentifier:@"loginreturn" sender:self];
}

-(void)submitData{
    NSMutableString *str = [NSMutableString stringWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/newuser.php?"];
    [str appendFormat:@"first_name=%@&last_name=%@&username=%@&email=%@&password=%@",[self.firstname text],[self.lastname text],[self.username text],[self.email text],[self.password text]];
    NSURL *url = [NSURL URLWithString:str];
    
    NSError *error = nil;
    
    NSString *returnString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if([returnString isEqualToString:@"failure"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Registration Failure"
                                                       message: @"Sorry for the inconvenience, but this user could not be registered. Please try again at a later time!"
                                                      delegate: self
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Registration Success"
                                                       message: @"This user has been successfully registered!"
                                                      delegate: self
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
        [alert show];
        [self returnToLogin];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)submitRegistration:(id)sender {
    [self submitData];
}

@end
