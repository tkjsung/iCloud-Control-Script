//
//  main.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2021-10-31.
//

import Foundation
import FinderSync

// TODO: Cleanup main.swift. Everything in here should either be put into a different file or be re-organized as functions in this file.
// TODO: Add utility functions so repeated function prints "############" can be written as a function instead of manually copying the code string every single time.
// TODO: Next minor version (.X update, not .X.X) update should add -h functionality.
// TODO: After script launches without filepath in terminal, script prompts for filepath. Consider removing this so that filepath must be given at script launch (a.k.a. cmd_line_args should always have two elements in it instead of one)

// Script Metadata
var script_version = "1.2.1"
var script_edit_date = "2023-10-08"
var script_edit_date_year = "2023"

// Necessary variables
var dir_exist = false
var Evict = icloud_evict()
let cmd_line_args = CommandLine.arguments  // First argument always the executable name (at index 0).

// Project Info: Manual Update (could not figure out how to do automatic using info.plist)
print("\n############\niCloud Control Script")
print("Version: \(script_version)\nDate: \(script_edit_date)")
print("Copyright (c) \(script_edit_date_year) by Tom Sung\n############")


// Check if command line has additional filepath arguments
if cmd_line_args.count > 1{
    Evict.dir = cmd_line_args[1]
    print("Entered filepath from command line: \"\(Evict.dir)\"\n")
    dir_exist = Evict.verify_directory()
    if dir_exist == false{
//        print("The filepath argument is invalid. Try again with a valid filepath.")
        exit(0)
    }
    else{
        DLog("The entered directory exists. Attempting file eviction from local drive.")
    }
}
else{
    while dir_exist == false{
        Evict.get_input()
        dir_exist = Evict.verify_directory()
    }
}

Evict.get_all_urls()
Evict.evict_urls()
exit(0)
