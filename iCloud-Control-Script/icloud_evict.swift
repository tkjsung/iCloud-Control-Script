//
//  icloud_evict.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2023-01-18.
//

import Foundation
import FinderSync

class icloud_evict{
    var evict_total:Int, evict_succ:Int, evict_fail:Int
    var dir:String
    var fileURLs:[URL]
    let fm = FileManager()
    
    /** Initialize class attributes.*/
    init() {
        dir = ""
        fileURLs = []
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
    
    /**Get directory of the filepath to be evicted from iCloud.*/
    func verify_directory() -> Bool{
        // FileManager: See if the given directory/file exists.
        let exist = self.fm.fileExists(atPath: dir)
        if exist == false {
            NSLog("The input \"\(self.dir)\" is not a valid filepath. Try again.\n\n############")
        } else {
            NSLog("The entered directory exists. Attempting file eviction from local drive.")
        }
        return exist
    }
    
    
    // Code excerpt taken from: https://developer.apple.com/documentation/foundation/filemanager/2765464-enumerator
    func get_all_urls(){
        let dirURL = URL.init(fileURLWithPath: self.dir)
        let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
        let directoryEnumerator = self.fm.enumerator(at: dirURL, includingPropertiesForKeys: Array(resourceKeys), options: .skipsHiddenFiles)!
        
        for case let fileURL as URL in directoryEnumerator {
            guard let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
                let isDirectory = resourceValues.isDirectory//,
//                let name = resourceValues.name
                else {
                    continue
            }
            
            if isDirectory {
                // Uncomment below to skip certain directories' files
//                if name == "_extras" {
//                    directoryEnumerator.skipDescendants()
//                }
                continue
            } else {
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
        if self.evict_total == 0{
            NSLog("\n############\nNo files to evict. Exit program.\n############")
            return
        }
        else{
            NSLog("Removing locally downloaded iCloud files.")
            for target in self.fileURLs {
                NSLog("REQUESTED: Local removal of %@", "\(target)")
                do {
                    try fm.evictUbiquitousItem(at: target)
                    NSLog("EVICT SUCCESS: %@", "\(target)")
                    self.evict_succ += 1
                } catch {
                    NSLog("EVICT FAILED: %@", "\(target)", "failed with error %@", "\(error)") // I'm not sure if this will throw exception.
                    self.evict_fail += 1
                }
            }
            NSLog("EVICT_TOTAL: \(self.evict_total); EVICT_SUCC: \(self.evict_succ); EVICT_FAIL: \(self.evict_fail)")
            print("############\nProcess complete.")
            print("* Total files to evict: \(self.evict_total).\n* Successfully evicted: \(self.evict_succ).\n* Failed to evict: \(self.evict_fail).\n############")
        }
    }
}
