//
//  ViewMyOutfitsViewController.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "ViewMyOutfitsViewController.h"
#import "SWRevealViewController.h"
#import "CollectionViewCell.h"

@interface ViewMyOutfitsViewController ()

@end

@implementation ViewMyOutfitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    _barButton.image = [UIImage imageNamed:@"menu2.png"];
    self.navigationItem.title = @"View My Outfits";
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    username.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    name.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    bio.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"bio"];
    _user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    //NSLog(@"%@", _user_id);
    [self getMyPhotos];
    
}

-(void) getData:(NSData *) data{
    NSError *error;
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //NSLog(@"%@", json);
}

-(void) getMyPhotos{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/viewmyoutfits.php"];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_id", _user_id]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    NSURL *url = [NSURL URLWithString:postString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getData:data];
    //NSLog(@"%@", postString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [json count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Reusable Cell" forIndexPath:indexPath];*/
    CollectionViewCell *cell = [self->collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *info = [json objectAtIndex:indexPath.row];
    NSString *img = [@"http://www.thestudysolution.com/fbla_outfitter/" stringByAppendingString:[info objectForKey:@"post_image_url"]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    cell.photo.image = [UIImage imageWithData:data];
    NSLog(@"%@", img);
    return cell;
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
