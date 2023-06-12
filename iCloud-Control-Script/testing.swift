//
//  testing.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2023-01-18.
//

/// File is used for testing code
/// FIle is currently unused in production

import Foundation

func test_filepath_string(){
    do {
//            var item = try self.fm.contentsOfDirectory(atPath: self.dir)
        var item = try self.fm.subpathsOfDirectory(atPath: self.dir)
        print(item)
    }
    catch {print("did not work")}
}

func test(){
    let array = [1,2,3,4]
    for (index, item) in array.enumerated(){
        print(index, item)
    }
}

func old_main(){
    /*
     
     // Trying to get folder paths here
     //let fileman = FileManager.default
     //let documentsURL = fileman.urls(for: ".documentDirectory", in: .userDomainMask)[0]
     //do {
     //    let fileURLs = try fileman.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
     //    print(fileURLs)
     //    // process files
     //} catch {
     //    print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
     //}
     //exit(0)


     // This is the path to my iCloud Drive to one of my documents
     var dir = ""
     dir = "/Users"

     /**Using Foundation.URL to see if files exist at the particular file URL.**/
     // This generates a Foundation.URL variable using the 'dir' variable I just used.
     var testURL = URL.init(fileURLWithPath: dir);
     print("Type is: ", type(of: testURL))

     // Check if the provided directory path is valid.
     var logic = false;

     do{
         try logic = testURL.checkResourceIsReachable()
         NSLog("File: Reachable")
     } catch {
         NSLog("File: Not reachable")
         print("File not reachabe. Force EOF")
         exit(0)
     }
     print("Does Directory URL exist? ", logic)


     // FileManager: See if the given directory/file exists.
     var exist = false;
     let fm = FileManager.default
     exist = fm.fileExists(atPath: dir)
     print("Does the file exist using FileManager?: ", exist)

     var file_names = [URL]()

     // TODO: Need to detect directory in here. Files don't count.
     // TODO: Need to isolate directories from files. Maybe use another function to find all directories and sub-directories instead.
     if(exist){
         do{
         let temp_names = try fm.contentsOfDirectory(at: testURL, includingPropertiesForKeys: [], options: [])
         file_names.append(contentsOf: temp_names)
     //    print(file_names)
     //    print(temp_names)
         } catch {
             print("Not a directory. It is a file.")
         }
     //    print(type(of: file_names))
     }

     // Try to get rid of local copy (not working to a certain degree)
     if(logic && exist){
         try fm.evictUbiquitousItem(at: testURL)
     } else{
         print("That didn't work.")
     }


     // From FinderSync.swift for the iCloud Control
     /*
      
      @IBAction func removeLocal(_ sender: AnyObject?) {
          NSLog("removeLocal")
          
          for target in currentTargets {
              NSLog("Local removal of \(target) requested")
              do {
                  try fm.evictUbiquitousItem(at: target)
                  NSLog("Removal of \(target) succeeded")
              } catch {
                  NSLog("Removal of \(target) failed with error \(error)")
              }
          }
      }
      
      var currentTargets: [URL] {
          var targets = FIFinderSyncController.default().selectedItemURLs() ?? []
          
          if let targetedUrl = FIFinderSyncController.default().targetedURL(), targets.count == 0 {
              targets.append(targetedUrl)
          }
          
          return targets
      }
      */


     // Going into file system (by the way, this works but because this script is so long it got ignored LOL)
     // From: https://developer.apple.com/documentation/foundation/filemanager/2765464-enumerator

     /*
     let directoryURL = Bundle.main.bundleURL
     let localFileManager = FileManager()
      
     let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
     let directoryEnumerator = localFileManager.enumerator(at: directoryURL, includingPropertiesForKeys: Array(resourceKeys), options: .skipsHiddenFiles)!
      
     var fileURLs: [URL] = []
     for case let fileURL as URL in directoryEnumerator {
         guard let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
             let isDirectory = resourceValues.isDirectory,
             let name = resourceValues.name
             else {
                 continue
         }
         
         if isDirectory {
             if name == "_extras" {
                 directoryEnumerator.skipDescendants()
             }
         } else {
             fileURLs.append(fileURL)
         }
     }
      
     print(fileURLs)
     */

     
     */
}


/**Get all the filenames for iCloud eviction*/
/*
    func get_all_filenames(){

        if(self.dir_exist){
            do{
                let temp_names = try fm.contentsOfDirectory(atPath: self.dir)
                print("This is a directory")
                print(temp_names)
            } catch {
                print("Not a directory. It is a file")
                let temp_names = fm.contents(atPath: self.dir)
                print(temp_names)
            }
        }

        // TODO: Need to detect directory in here. Files don't count.
        // TODO: Need to isolate directories from files. Maybe use another function to find all directories and sub-directories instead.
        if(self.dir_exist){
            do{
            let temp_names = try fm.contentsOfDirectory(at: testURL, includingPropertiesForKeys: [], options: [])
            file_names.append(contentsOf: temp_names)
        //    print(file_names)
        //    print(temp_names)
            } catch {
                print("Not a directory. It is a file.")
            }
        //    print(type(of: file_names))
        }
    }
*/

/*
    func evict_files(){
        // Try to get rid of local copy (not working to a certain degree)
        if(self.url_check && self.dir_exist){
            for (index, item) in self.file_names.enumerated(){
                try fm.evictUbiquitousItem(at: item)
                else {
                    print("That didn't work.")
                }
            }
        }
    }
*/

/*
func verify_directory(){
    /**Using Foundation.URL to see if files exist at the particular file URL.**/
    
    // TODO: Verify URL later. Step 2 should be getting all the filepaths, and step 3 make them into URLs, step 4 verify the URLs, step 5 evict the URLs.
    // Generate Foundation URL variable based on given directory (self.dir). Needed to identify location of file.
    var dirURL:URL = URL.init(fileURLWithPath: self.dir)
    print("02 VERIFY DIRECTORY: Variable type is: ", type(of: dirURL))
    
    // Using dirURL, check if the directory path/URL is valid
    do{
        try self.url_check = dirURL.checkResourceIsReachable()
        print("02 VERIFY DIRECTORY: File URL is reachable")
    } catch {
        print("02 VERIFY DIRECTORY: File URL is not reachable")
        print("File URL not reachable. Force EOF")
        exit(0)
    }
    
    // TODO: Keep the following. I need the getting filenames code working first.
    // FileManager: See if given directory/file exists
    //        let fm = FileManager.default
    self.dir_exist = self.fm.fileExists(atPath: self.dir)
    print("02 VERIFY DIRECTORY: FileManager: ", self.dir_exist)
    
    //        file_names.append(dirURL)
    //        print(file_names[0])
}
*/
