//
//  LiveResponse.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 3/9/21.
//

import Foundation

struct LiveResponse: Decodable {
    
    var items: [LiveVideo]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([LiveVideo].self, forKey: .items)
    }
}
