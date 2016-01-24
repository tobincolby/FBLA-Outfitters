//
//  DetailViewController.m
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/23/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.likeOufit.enabled = YES;
    NSError *error;
    NSString *user_id = _user_id;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/infoforuser.php?user_id=%@",user_id]];
    NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if([result isEqualToString:@"failure"]){
        //nserror alert
    }else{
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSDictionary *dict = [json objectAtIndex:0];
        
    }
    
    NSLog(@"%@", _user_id);
    likesLabel.text = [NSString stringWithFormat:@"Likes: %@",_likes];
    captionText.text = _caption;
    photoImg.image = [UIImage imageWithData:_photo];
    self.navigationItem.title = @"View Outfits";
    self.navigationItem.backBarButtonItem.title = @"";
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getlikesforoutfit.php?post_id=%@",_post_id]];
    NSString *resultS = [NSString stringWithContentsOfURL:url2 encoding:NSUTF8StringEncoding error:&error];
    if([resultS isEqualToString:@"0"]){
        
    }else{
        NSData *data2 = [NSData dataWithContentsOfURL:url];
        NSMutableArray *json2 = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:&error];
        for(int i=0;i<[json2 count];i++){
            NSDictionary *dict2 = [json2 objectAtIndex:i];
            if ([[dict2 objectForKey:@"user_id" ] isEqualToString: [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
                //blur out like_oufit
                self.likeOufit.enabled = NO;
                [self.likeOufit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)like:(id)sender {
    [self likeOutfit];
}
                       
-(void)likeOutfit{
    NSError *error;
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/likeoutfit.php?user_id=%@&post_id=%@",user_id,_post_id]];
    NSLog(@"%@", url);
    NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if([result isEqualToString:@"success"]){
        likesLabel.text = [NSString stringWithFormat:@"Likes: %i",([_likes intValue] + 1)];
        self.likeOufit.enabled = NO;
        [self.likeOufit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    }else{
        
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
