//
//  main.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2021-10-31.
//

import Foundation
import FinderSync

var script_version = "1.0.2"
var dir_exist = false
var Evict = icloud_evict()

// Project Info: Manual Update (could not figure out how to do automatic using info.plist)
print("\n############\niCloud Control Script")
print("Version: \(script_version)\nDate: 2023-03-26")
print("Copyright (c) 2023 by Tom Sung.\n############")

// If filepath does not exist, get user input again.
while dir_exist == false{
    Evict.get_input()
    dir_exist = Evict.verify_directory()
}

Evict.get_all_urls()
Evict.evict_urls()

exit(0)
