//
//  NavigationViewController.m
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 11/23/15.
//  Copyright (c) 2015 Tobin Technologies. All rights reserved.
//

#import "NavigationViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController{
    NSArray *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menu = @[@"title", @"view", @"mine", @"friend", @"upload", @"search",@"logout"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 6){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"bio"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"logout" sender:self];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        if([[segue identifier] isEqualToString:@"view_friend"]){
            ViewController *view = [segue destinationViewController];
            view.navTitle = @"View Friend's Outfits";
        }
        if([[segue identifier] isEqualToString:@"view_all"]){
            ViewController *view = [segue destinationViewController];
            view.navTitle = @"View Outfits";
        }
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
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
