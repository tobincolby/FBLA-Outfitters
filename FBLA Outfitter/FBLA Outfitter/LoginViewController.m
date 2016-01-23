//
//  LoginViewController.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 12/4/15.
//  Copyright © 2015 Tobin Technologies. All rights reserved.
//

#import "LoginViewController.h"
#import "SWRevealViewController.h"
@interface LoginViewController (){
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    self.navbar.hidden = YES;
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}
- (IBAction)addRegisterStuff:(id)sender {
    
    self.usernameLogin.hidden = YES;
    self.passwordLogin.hidden = YES;
    self.loginButton.hidden = YES;
    self.registerhere.hidden = YES;
    self.logo.hidden = YES;
    self.titleLabel.hidden = YES;
    
    self.firstname.hidden = NO;
    self.lastname.hidden = NO;
    self.email.hidden = NO;
    self.usernameRegister.hidden = NO;
    self.passwordRegister.hidden = NO;
    self.confirmpassRegister.hidden = NO;
    self.registerSubmit.hidden = NO;
    self.navbar.hidden = NO;
    
    
}

- (IBAction)addLoginStuff:(id)sender {
    
    [self loginStuffAppear];
}

-(void)loginStuffAppear{
    self.usernameLogin.hidden = NO;
    self.passwordLogin.hidden = NO;
    self.loginButton.hidden = NO;
    self.registerhere.hidden = NO;
    self.logo.hidden = NO;
    self.titleLabel.hidden = NO;
    
    self.firstname.hidden = YES;
    self.lastname.hidden = YES;
    self.email.hidden = YES;
    self.usernameRegister.hidden = YES;
    self.passwordRegister.hidden = YES;
    self.confirmpassRegister.hidden = YES;
    self.registerSubmit.hidden = YES;
    self.navbar.hidden = YES;
}

-(void)login: (NSString *) username withString:(NSString *) password{
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",username, password];
    NSString *strUrl = @"http://www.thestudysolution.com/fbla_outfitter/serverside/login.php?";
    strUrl = [strUrl stringByAppendingString:post];
    NSData *dataUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataUrl encoding:NSUTF8StringEncoding];
    if(![serverOutput isEqualToString:@"failure"]){
        NSError *error;
        json = [NSJSONSerialization JSONObjectWithData:dataUrl options:kNilOptions error:&error];
        if([json count] > 0){
        NSDictionary *info = [json objectAtIndex:0];
        email = [info objectForKey:@"email"];
        firstName = [[info objectForKey:@"first_name"]stringByAppendingString:@" "];
        lastName = [info objectForKey:@"last_name"];
        name = [firstName stringByAppendingString:lastName];
        userID = [info objectForKey:@"user_id"];
        usrname = [info objectForKey:@"username"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:usrname forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"login" sender:self];
        
    } else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @""
                                                       message: @"Invalid username or password"
                                                      delegate: self
                                             cancelButtonTitle:@"Okay"
                                             otherButtonTitles:nil];
        [alert show];

    }
}

-(IBAction)sendLogin:(id)sender{
    [self login:_usernameLogin.text withString:_passwordLogin.text];
}


-(void)registration{
    NSMutableString *str = [NSMutableString stringWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/newuser.php?"];
    [str appendFormat:@"first_name=%@&last_name=%@&username=%@&email=%@&password=%@",[self.firstname text],[self.lastname text],[self.usernameRegister text],[self.email text],[self.passwordRegister text]];
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
        [self loginStuffAppear];
    }
    
}


- (IBAction)submitRegistration:(id)sender {
    if([[self.passwordRegister text] isEqualToString:[self.confirmpassRegister text]]){
        if(![[self.passwordRegister text] isEqualToString:@""] && ![[self.firstname text] isEqualToString:@""] && ![[self.lastname text]isEqualToString:@""] && ![[self.email text]isEqualToString:@""] && ![[self.usernameRegister text] isEqualToString:@""]){
    [self registration];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Registration Error"
                                                           message: @"You must fill out all parts of this form!"
                                                          delegate: self
                                                 cancelButtonTitle:@"Dismiss"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Registration Error"
                                                       message: @"Your passwords do not match!"
                                                      delegate: self
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
        [alert show];
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

@end
