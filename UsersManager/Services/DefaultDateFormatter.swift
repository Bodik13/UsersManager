//
//  DateFormatter.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/15/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import Foundation

struct DefaultDateFormatter {
    
    static let LocalDayWithHours: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone.autoupdatingCurrent
        df.locale = Locale.autoupdatingCurrent
        return df
    }()
    
}
