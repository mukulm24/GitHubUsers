//
//  Logger.swift
//  GitHubUsers
//
//  Created by Mukul More on 06/06/18.
//  Copyright © 2018 mukulmore. All rights reserved.
//

import Foundation

class Logger {
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ss"
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    enum LogEvent: String {
        case error = "[‼️]"
        case info = "[ℹ️]"
        case debug = "[💬]"
        case verbose = "[🔬]"
        case warning = "[⚠️]"
        case severe = "[🔥]"
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    class func log(message: String,
                   event: LogEvent,
                   fileName: String = #file,
                   line: Int = #line,
                   column: Int = #column,
                   funcName: String = #function) {
        
        #if DEBUG
            print("\(Date().toString()) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)")
        #endif
    }
    
}


