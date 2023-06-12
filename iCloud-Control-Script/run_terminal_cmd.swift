//
//  run_terminal_cmd.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2023-04-07.
//

/// Purpose of this file is to run skipped URL files using Terminal's `brctl evict` command.
/// FIle is currently unused in production

import Foundation

func run_terminal_cmd(filepath: String){
    
    let task = Process()
    task.launchPath = "/bin/zsh"  // new macOS versions use zsh as default shell environment
    task.arguments = ["-c", "brctl evict \(filepath)"]
    
    let pipe = Pipe()
    task.standardOutput = pipe
    
    task.launch() // launch the terminal at the launchPath with arguments as written above
    
    // Print out terminal output with help of Pipe().
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        print(output)
    }
}
