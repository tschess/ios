//
//  DateTime.swift
//  ios
//
//  Created by Matthew on 8/18/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class DateTime {
    
    let formatter: DateFormatter
    
    init() {
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        self.formatter.timeZone = NSTimeZone(name: "America/New_York")! as TimeZone
    }
    
    func currentDate() -> Date {
        return self.toFormatDate(string: self.currentDateString())
    }
    
    func currentDateString() -> String {
        return formatter.string(from: Date())
    }
    
    func toFormatDate(string: String) -> Date {
        return formatter.date(from: string)!
    }
}
