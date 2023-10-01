//
//  Date+.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 7/5/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import Foundation

extension String {
    func getTimeFromDate(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: date) else { return "" }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm a"
        let time = timeFormatter.string(from: date)
        return time
        
    }
}
