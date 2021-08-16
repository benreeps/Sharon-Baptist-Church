//
//  DateManager.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/23/21.
//

import Foundation
import UIKit

struct DateManager {
    
    static let videoDateFormatter: DateFormatter = {
        
        let df = DateFormatter() 
        df.dateFormat = Constants.DATE_FORMAT_STRING
        
        return df
    }()
}
