//
//  run_terminal_cmd.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2023-04-07.
//

/// Purpose of this file is to run skipped URL files using Terminal's `brctl evict` command.

import Foundation


//TODO: The following has yet to be tested and is directly copied from ChatGPT Mar 23 Version.
func run_terminal_cmd(filepath: String){
    
    let task = Process()
    task.launchPath = "/bin/ls"
    task.arguments = ["-l"]
    
    let pipe = Pipe()
    task.standardOutput = pipe
    
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        print(output)
    }
}
