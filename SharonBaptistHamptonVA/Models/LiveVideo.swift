//
//  LiveVideo.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/5/21.
//

import Foundation

struct LiveVideo: Decodable {
    
    var streamId = ""
    var title = ""
    var published = Date()
    var lifeCycleStatus = ""
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case status
        case contentDetails
        
        case published = "publishedAt"
        case title
        case streamId = "boundStreamId"
        case lifeCycleStatus
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        
        let statusContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .status)
        
        self.lifeCycleStatus = try statusContainer.decode(String.self, forKey: .lifeCycleStatus)
        
        let contentDetailsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .contentDetails)
        
        self.streamId = try contentDetailsContainer.decode(String.self, forKey: .streamId)
        
    }
    
}
