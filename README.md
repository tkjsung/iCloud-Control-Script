# iCloud Control Script

Author: Tom Sung<br>
Repository Creation Date: January 18, 2023

## About this project/script

This script was inspired by Robbert Brandsma's (Obbut) GitHub project iCloud Control (available here: [https://github.com/Obbut/iCloud-Control](https://github.com/Obbut/iCloud-Control)). The developer of said project deemed it unnecessary to continue developing the Finder extension as Apple has implemented the download/remove local file feature in macOS Catalina (macOS 10.15), which at the time is built for Intel-based Macs. In other words, the Finder extension runs Intel x86 instruction code. In the future, though, Apple will remove support for x86 applications, which will render the iCloud Control extension unusable. To ensure I personally can continue to use a form of iCloud Control, I created this script.

Apple's solution is not ideal for removing local iCloud files. If an iCloud folder has a non-zero amount of downloaded files, it is not possible to remove local copies of the iCloud files by using the secondary options (right click). One would need to click the "Download Now" button to download the entire folder before the "Remove Download" button would appear. Alternatively, downloads can be removed by visiting each file manually, which is tedious. This script solves this problem; local iCloud files can be removed without downloading the entire folder or manually removing individual files.

As I have no expertise in macOS app development and I am personally not from a software background, I did not know how to modify and build the iCloud Control Finder extension for Universal/Apple Silicon (it could be really simple for all I know). Therefore, I opted to piece together this command line tool, which is called iCloud Control Script. This script's only functionality is removing local copies of iCloud files, which is the function I used the most.

There are three files, other than the project file, in this Xcode project folder. I couldn't figure out how to make another file the "main" file, so _main.swift_ calls on the class I wrote in _icloud_evict.swift_ to enable the remove local file functionality. The last file, _testing.swift_, is simply where I dumped all the testing code I used.

This project is built with Xcode 14.2 for macOS 13.1 deployment. I cannot guarantee the code will work with earlier versions of macOS.

## Disclaimer

As I have mentioned, I am not from a software background. **USE THIS SOFTWARE AT YOUR OWN RISK.** I suggest reading the source code to make sure you understand what is written before running anything on your machine.

## Project Maintenance

This project will not be actively maintained. I will not be addressing issues or pull requests.
