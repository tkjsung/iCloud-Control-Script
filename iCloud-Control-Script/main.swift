//
//  main.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2021-10-31.
//
//  ############################
//  About this project/script
//
//  This script was created just over a year ago from today in the attempt to replicate Robbert Brandsma's (Obbut) GitHub project iCloud Control, available here: https://github.com/Obbut/iCloud-Control. The developer of said project deemed it unncessary to continue developing the Finder extension as Apple has implemented the download/remove local file feature in macOS Catalina (macOS 10.15), which at the time is built for Intel-based Macs. In other words, the Finder extension runs Intel x86 instruction code. In the future, though, Apple will remove support for x86 applications, which will render the iCloud Control extension unusable. To ensure I personally can continue to use a form of iCloud Control, I created this script.
//
//  Apple's solution is not ideal for removing local iCloud files. If an iCloud folder has a non-zero amount of downloaded files, it is not possible to remove local copies of the iCloud files by using the secondary options (right click). One would need to click the "Download Now" button to download the entire folder before the "Remove Download" button would appear.
//
//  As I have no expertise in macOS app development and I am personally not from a software background, I did not know how to modify and build the iCloud Control Finder extension for Universal/Apple Silicon (it could be really simple for all I know). Therefore, I opted to piece together this command line tool, which is called iCloud Control Script. This script's only functionality is removing local copies of iCloud files, which is the function I used the most.
//
//  There are three files, other than the project file, in this Xcode project folder. I couldn't figure out how to make another file the "main" file, so main.swift calls on the class I wrote in icloud_evict.swift to enable the remove local file functionality. The last file, testing.swift, is simply where I dumped all the testing code I used.
//
//  ############################

import Foundation
import FinderSync

var dir_exist = false
var Evict = icloud_evict()

while dir_exist == false{
    Evict.get_input()
    dir_exist = Evict.verify_directory()
}

Evict.get_all_urls()
Evict.evict_urls()

exit(0)
