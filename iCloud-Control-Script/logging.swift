//
//  logging.swift
//  iCloud-Control-Script
//
//  Created by Tom Sung on 2023-04-07.
//


import Foundation

func DLog(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName):\(line) \(function) - \(message)")
    #endif
}
