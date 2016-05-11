FBLA Outfitter 1/24/2016

Authors
=============================
Colby Tobin
Ryan Tobin



General Usage
=============================
This is an application designed for the purpose of giving users the capability to share tips/information on different styles of fashion according to the FBLA-style dress code. Users have the ability to create accounts within this application, and use these accounts to upload their own photos and request varying tips and guidance regarding their outfits. In addition, these users have the ability to view other individuals’ outfits and provide feedback and comments to the user giving a social aspect to this application.

How to Use
=============================
1. First must create and register an account within the application in order to access outfits.
2. This can be done by clicking the “Register Here” button.
3. Once a user has registered, they can now login into the application using their credentials.
4. When the user logs in, the first screen that appears shows all of the current outfits that have been posted on the application.
5. The user can scroll through each of these outfits, and in order to see more details about the outfit/comments on the outfit, they can click on it.
6. This will take them to a detail view showing more information about the outfit and the comments on the outfit.
7. At this point, the user can make comments on the outfit by using the text view at the bottom of the screen, or he can click on a current comment to view the outfits posted by the user who posted the comment. The user also has the ability to click on the username of the individual who posted the original outfit to see more outfits that he has posted as well.
8. If a username is selected in the detailed outfit view, then it will take the user to a page with a collection of outfits that the user has posted on the application.In this page, the user can select an image/outfit that the user has posted to view more details on the outfit.
9. Another option that the user has is to view their own posted outfits through the side menu bar. By selecting “View My Outfits”, the user has the ability to view all of the outfits they’ve posted thus far. They can click on these outfits to view more information regarding their outfits.
10. Another option that the user has is to upload an outfit. In order to view this capability, the user must select “Upload Outfit.” At this stage, the user has the ability to take a picture using their phone or select an image from their photo library to upload into the application for others to view. The user can also ask a question about this outfit as a caption in attempts to get information from others about their outfit. 
11. Another option that the user has is to search for other users. In order to view this capability, the user must select “Search For Users.” In this view, the user can type in different usernames to search for a specific user. Once the desired username is found, the user can click on this username to view all of the outfits that this user has posted to the application thus far. From this view, the user can click on each of these outfits to view more information regarding the outfits.
12. Another option that the user has is to view his friend’s outfits. In the app, the user has the capability to follow different users. Once he follows these users, he can view each of the user’s outfits that they have posted as a way to filter those specific outfits out. Similar to the view all outfits page, the user can click on any of the outfits posted in order to view more details on the outfit.


Installation Requirements
=============================
Can run on Mac computer:
For Mac:
	MAC OS X El Capitan
	Xcode 7.2
	Internet Connection*

This application will not run on a computer with a Windows/Linux/Ubuntu based operating system

*This application uses the internet connection in order to connect to a server hosted at “http://www.thestudysolution.com/“ in order to store and request information in a database hosted at this address.

Application Permissions
=============================
In the application, it will ask the user for permission to access his/her photo library and/or camera on the phone. The user must give the application permission to access the photo library and camera. The application will only be able to perform fully if these permissions are granted. 



Limited Capabilities of Simulator
==============================
Due to the limited capabilities of the iPhone simulator that the application will run on, there are some features that will not be able to work, such as the “Sharing” feature, as it requires a messaging/emailing app that doesn’t exist on the iPhone simulator. In addition to this, taking a photo with the camera to upload an outfit is also not possible due to the fact that the simulator lacks a camera.


How to Run Application (Simulator) (Not for sale on App Store)
=============================
For Mac:
	1. Open up Folder named “FBLA Outfitter”.
	2. Double click on file named “FBLA Outfitter.xcodeproj”.
	3. Once Xcode has opened the project successfully, in the top left hand corner of the Xcode interface, there is a play/stop button with a target simulator to the right of it.
	4. Select the desired simulator from the list of simulators given and press the play/run button.
	5. This will launch the simulator with the application running from it.
	6. If the simulator does not run the application right away once the simulator has launched and the home screen of the simulator is visible, then press the stop button in the Xcode interface, and once the application stops, press the play/run button again, and the application will run.

How to Run Application (iPhone) (Through Xcode) 
**This method only works if you have a developer’s license**
=============================
On Mac:
	1. Open up Folder named “FBLA Outfitter”
	2. Double click on file named “FBLA Outfitter.xcodeproj”
	3. Once Xcode has opened the project, there will be a file navigator on the right hand side.At the top of the file navigator, there will be a file with a blue logo named FBLA Outfitter. Click on this file and it will navigate you to the project properties.
	4. In this view, under the category, “Identity,” there will be a section that denotes where a Team can be placed in. Select this drop down menu and either add your developer’s account as a team for this application or select your developer’s account to use them as a team for this application.
	5. Once the developer’s account has been linked to the application, plug your phone into the Mac computer, and the name of the phone should appear in the top left hand corner of Xcode to the right of a play/stop button. 
	6. Once this phone pops up as a device in Xcode, you can press the play button in order to start the application to run it.

File Locations
=============================
GUI Screenshots 
	“Application_Screenshots.pdf”
Main Project File
	“FBLA Outfitter/FBLA Outfitter.xcodeproj”
Source Code (iOS)
	“FBLA Outfitter/FBLA Outfitter/”
	They are the *.m, *.h, *.storyboard files within this directory
Source Code (Server Files)
	“FBLA Outfitter/Server Files/“
	They are the *.php files within this directory

iOS Application Files
=============================
ThChatInput.h
ThChatInput.m
UploadOutfitViewController.h
UploadOutfitViewController.m
ViewMyOutfitsViewController.h
ViewMyOutfitsViewController.m
AppDelegate.h
AppDelegate.m
LoginViewController.h
LoginViewController.m
ViewController.h
ViewController.m
DetailViewController.h
DetailViewController.m
NavigationViewController.h
NavigationViewController.m
CommentViewCell.h
CommentViewCell.m
CustomCell.h
CustomCell.m
CollectionViewCell.h
CollectionViewCell.m
SearchUserViewController.h
SearchUserViewController.m
SearchCell.h
SearchCell.m
Main.storyboard
Iphone6plus.storyboard
Iphone5.storyboard
Iphone4.storyboard
Images.xcassets
LaunchScreen.xib
SWRevealViewController.h
SWRevealViewController.m
Info.plist
main.m


Server Application Files
=============================
db.php
followinguser.php
followuser.php
getcommentsforoutfit.php
getFollowers.php
getFollowing.php
getFollowingOutfits.php
getFollowingUsers.php
getlikesforoutfit.php
getUsername.php
getUsers.php
infoforuser.php
likeoutfit.php
login.php
makecomment.php
newuser.php
openapp.php
unfollowuser.php
unlikeoutfit.php
uploadoutfit.php
users_i_follow.php
viewalloutfits.php
viewmyoutfits.php
viewoutfit.php

MySQL Database Structure
=============================
Tables:
	users
		user_id
		username
		password
		email
		first_name
		last_name
		bio
	posts
		post_id
		user_id
		post_image_url
		post_text
		num_likes
	likes
		like_id
		user_id
		comment_id
		post_id
	comments
		comment_id
		user_id
		comment
		post_id
	followers
		follow_id
		user_id
		person_following_id
