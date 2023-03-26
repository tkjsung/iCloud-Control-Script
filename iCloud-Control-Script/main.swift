//
//  main.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2021-10-31.
//

import Foundation
import FinderSync

var dir_exist = false
var Evict = icloud_evict()

// If filepath does not exist, get user input again.
while dir_exist == false{
    Evict.get_input()
    dir_exist = Evict.verify_directory()
}

Evict.get_all_urls()
Evict.evict_urls()

exit(0)
