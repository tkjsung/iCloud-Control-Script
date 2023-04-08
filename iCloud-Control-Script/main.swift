//
//  main.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2021-10-31.
//

import Foundation
import FinderSync

// Script Metadata
var script_version = "1.1.0"

// Necessary variables
var dir_exist = false
var Evict = icloud_evict()
let cmd_line_args = CommandLine.arguments  // First argument always the executable name (at index 0).

// Project Info: Manual Update (could not figure out how to do automatic using info.plist)
print("\n############\niCloud Control Script")
print("Version: \(script_version)\nDate: 2023-04-07")
print("Copyright (c) 2023 by Tom Sung.\n############")


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
        NSLog("The entered directory exists. Attempting file eviction from local drive.")
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
