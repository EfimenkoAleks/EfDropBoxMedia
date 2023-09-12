//
//  DateExtension.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import Foundation

extension Date {
    
    static func convertDateToString(date: Date) -> String {
        
        let dateFormatterRezult = DateFormatter()
        dateFormatterRezult.locale = Locale(identifier: "en_GB")
        dateFormatterRezult.dateFormat = "MMM d yyyy, HH:mm"
        
        return dateFormatterRezult.string(from: date)
    }
}
