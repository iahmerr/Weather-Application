//
//  Int+Extension.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 22/01/2022.
//

import Foundation

// MARK: - Int Extension
extension Int {
    var dayDateMonth: String {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "dd-MMM, HH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
    
    var dateOnly: String {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "dd-MMM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
    
    func hourMinuteAmPm(_ offset: Int = 0) -> String {
        let dateFormatter = DateFormatter ()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Because API provider use GMT 00:00 as default TimeZone.
        // Or dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.advanced(by: offset))))
    }
}

