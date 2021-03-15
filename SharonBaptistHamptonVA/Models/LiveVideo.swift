//
//  LiveVideo.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/5/21.
//

import Foundation

struct LiveVideo: Decodable {
    
    var videoId = ""
    var title = ""
    var published = Date()
    var lifeCycleStatus = ""
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case status
        case videoId = "id"
        
        case published = "publishedAt"
        case title
        case lifeCycleStatus
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        let statusContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .status)
        
        self.lifeCycleStatus = try statusContainer.decode(String.self, forKey: .lifeCycleStatus)
        
        self.videoId = try container.decode(String.self, forKey: .videoId)
        
    }
    
}
