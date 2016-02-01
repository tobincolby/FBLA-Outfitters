FBLA Outfitter 1/24/2016

Authors
=============================
Colby Tobin
Ryan Tobin

General Usage
=============================
This is an application designed for the purpose of giving users the capability to share tips/information on different styles of fashion according to the FBLA-style dress code. Users have the ability to create accounts within this application, and use these accounts to upload their own photos and request varying tips and guidance regarding their outfits. In addition, these users have the ability to view other individuals’ outfits and provide feedback and comments to the user giving a social aspect to this application. 

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

How to Run Application
=============================
For Mac:
	1. Open up Folder named “FBLA Outfitter”
	2. Double click on file named “FBLA Outfitter.xcodeproj”
	3. Once Xcode has opened the project successfully, in the top left hand corner of the Xcode interface, there is a play/stop button with a target simulator to the right of it.
	4. Select the desired simulator from the list of simulators given and press the play/run button.
	5. This will launch the simulator with the application running from it.
	6. If the simulator does not run the application right away once the simulator has launched and the home screen of the simulator is visible, then press the stop button in the Xcode interface, and once the application stops, press the play/run button again, and the application will run.



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
CustomCell.h
CustomCell.m
CollectionViewCell.h
CollectionViewCell.m
Main.storyboard
Images.xcassets
LaunchScreen.xib
SWRevealViewController.h
SWRevealViewController.m
Info.plist
main.m


Server Application Files
=============================
db.php
getcommentsforoutfit.php
getlikesforoutfit.php
infoforuser.php
likeoutfit.php
login.php
makecomment.php
newuser.php
uploadoutfit.php
viewalloutfits.php
viewmyoutfits.php
viewoutfit.php
