//
//  DateTime.swift
//  ios
//
//  Created by Matthew on 8/18/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class DateTime {
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.timeZone = NSTimeZone(name: "America/New_York")! as TimeZone
    }
    
    func currentDate() -> Date {
        return self.toFormatDate(string: self.currentDateString())
    }
    
    func currentDateString() -> String {
        return dateFormatter.string(from: Date())
    }
    
    func toFormatDate(string: String) -> Date {
        return dateFormatter.date(from: string)!
    }
}
