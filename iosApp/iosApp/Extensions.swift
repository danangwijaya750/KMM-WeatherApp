//
//  Extensions.swift
//  iosApp
//
//  Created by Danang Wijaya on 14/01/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
extension Int {
        func dateFromMilliseconds(format:String) -> Date {
            let date : NSDate! = NSDate(timeIntervalSince1970:Double(self) / 1000.0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = TimeZone.current
            let timeStamp = dateFormatter.string(from: date as Date)
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return ( formatter.date( from: timeStamp ) )!
        }
    }
