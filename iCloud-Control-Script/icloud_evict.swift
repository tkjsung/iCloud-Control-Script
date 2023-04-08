//
//  icloud_evict.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2023-01-18.
//

import Foundation
import FinderSync

// TODO: Still need to figure out how to suppress NSLog output properly without messing up string formatting when outputting.

class icloud_evict{
    var evict_total:Int, evict_succ:Int, evict_fail:Int
    var dir:String
    var fileURLs:[URL]
    var skippedURLs:[URL]
    let fm = FileManager()
    
    /// Initialize class attributes.
    init() {
        dir = ""
        fileURLs = []
        skippedURLs = []
        evict_total = 0
        evict_succ = 0
        evict_fail = 0
    }
    
    func get_input(){
        print("Enter filepath (Copy Shortcut: CMD-OPT-C): ")
        if let usr_input = readLine(){
            self.dir = String(usr_input)
        }
    }
    
    /// Get directory of the filepath to be evicted from iCloud.
    func verify_directory() -> Bool{
        // FileManager: See if the given directory/file exists.
        let exist = self.fm.fileExists(atPath: dir)
        if exist == false {
            print("The input \"\(self.dir)\" is not a valid filepath. Try again.\n############\n")
        } else {
            print("The entered directory exists. Attempting file eviction from local drive.")
        }
        return exist
    }
    
    
    /// Code excerpt taken from: https://developer.apple.com/documentation/foundation/filemanager/2765464-enumerator
    func get_all_urls(){
        let dirURL = URL.init(fileURLWithPath: self.dir)
        let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey, .isPackageKey])
        let options: FileManager.DirectoryEnumerationOptions = .skipsHiddenFiles//[.skipsHiddenFiles, .skipsPackageDescendants]
        let directoryEnumerator = self.fm.enumerator(at: dirURL, includingPropertiesForKeys: Array(resourceKeys), options: options)!
        
        for case let fileURL as URL in directoryEnumerator {
            guard let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
                  let isDirectory = resourceValues.isDirectory,
                  let isPackage = resourceValues.isPackage
                    //                let name = resourceValues.name
            else {
                continue
            }
            
            // If the file is recognized as a package in macOS, evictUbiquitousItem will fail. Therefore, these files must be skipped.
            if isPackage {
                skippedURLs.append(fileURL)
                directoryEnumerator.skipDescendants()
                continue
            }
            
            if isDirectory {
                // Uncomment below to skip certain directories' files
                //                if name == "_extras" {
                //                    directoryEnumerator.skipDescendants()
                //                }
                continue
            }
            else {
                self.fileURLs.append(fileURL)
            }
        }
        
        NSLog("Items to evict: \(fileURLs.count)")
        self.evict_total = fileURLs.count
        
        //        for (index, item) in self.fileURLs.enumerated(){
        //            print(index, ": ", item)
        //        }
        //        print(self.fileURLs)
    }
    
    func evict_urls(){
        /// Added skipped files display as some files will fail to evict due to macOS's package system.
        if self.skippedURLs.count != 0 {
            print("\n############\nThe following file(s) are skipped.\n")
            for fileURL in self.skippedURLs{
                print("* \(fileURL.path())")
            }
        }
        
        if self.evict_total == 0 {
            print("\n############\nNo files to evict. Exit program.\n############\n")
        }
        else{
            NSLog("Removing locally downloaded iCloud files.")
            for target in self.fileURLs {
                //                NSLog("REQUESTED: Local removal of \(target)")
                NSLog("REQUESTED: Local removal of %@", "\(target)")
                do {
                    try fm.evictUbiquitousItem(at: target)
                    //                    NSLog("EVICT SUCCESS: \(target)")
                    //                    var formatted_string = String(format: "2 EVICT SUCCESS: %@", arguments: [target as CVarArg])
                    //                    NSLog(formatted_string)
                    NSLog("EVICT SUCCESS: %@", "\(target)")
                    self.evict_succ += 1
                } catch {
                    //                    var formatted_string = String(format: "EVICT FAILED: %@ with error %@", arguments: [target as CVarArg, error as CVarArg])
                    //                    NSLog(formatted_string)
                    //                    NSLog("EVICT FAILED: \(target) with error \(error)")
                    NSLog("EVICT FAILED: %@", "\(target)", "failed with error %@", "\(error)")
                    self.evict_fail += 1
                }
            }
            NSLog("EVICT_TOTAL: \(self.evict_total); EVICT_SUCC: \(self.evict_succ); EVICT_FAIL: \(self.evict_fail)")
            print("############\nProcess complete.")
            print("* Total files to evict: \(self.evict_total).\n* Successfully evicted: \(self.evict_succ).\n* Failed to evict: \(self.evict_fail).\n############\n")
        }
        return
    }
}
