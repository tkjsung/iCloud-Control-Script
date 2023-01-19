//
//  icloud_evict.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2023-01-18.
//

import Foundation
import FinderSync

class icloud_evict{
    var dir:String
    var fileURLs:[URL]
    let fm = FileManager()
    
    /** Initialize class attributes.*/
    init() {
        dir = ""
        fileURLs = []
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
            print("The input \"\(self.dir)\" is not a valid filepath. Try again.\n\n############")
        } else {
            print("The entered directory exists. Attempting file eviction from local drive.")
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
                let isDirectory = resourceValues.isDirectory,
                let name = resourceValues.name
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
        
        NSLog("Items to evict: %@", "\(fileURLs.count)")
        
//        for (index, item) in self.fileURLs.enumerated(){
//            print(index, ": ", item)
//        }
//        print(self.fileURLs)
    }

    func evict_urls(){
        NSLog("removing locally downloaded iCloud files.")
        for target in self.fileURLs {
            NSLog("REQUESTED: Local removal of %@", "\(target)")
            
            do {
                try fm.evictUbiquitousItem(at: target)
                NSLog("EVICT SUCCESS: %@", "\(target)")
            } catch {
                NSLog("EVICT FAILED: %@", "\(target)", "failed with error %@", "\(error)") // I'm not sure if this will throw exception.
            }
        }
        
        print("############\nProcess complete.\n############")
    }
}
