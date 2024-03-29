//
//  LiveVideoController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/5/21.
//

import Foundation

protocol LiveVideoModelDelegate {
    
    func liveVideosFetched(_ liveVideos: [LiveVideo])
}

class LiveVideoModel {
    
    var delegate: LiveVideoModelDelegate?
    
    func getLiveVideos() {
        
        let url = URL(string: Constants.API_LIVE_URL)
        guard url != nil else {return}
        
        // Get a URLSession object
        let session = URLSession.shared
        
        // Get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check for errors
            if error != nil || data == nil {
                
                return
            }
            
            do {
                
                // Parse the data into video objects
                let decoder = JSONDecoder()
                
                // Ex. iso8601 format = 2020-05-29T17:32:50Z
                decoder.dateDecodingStrategy = .iso8601
                
                // Specify the type of data you want to decode the data into
                let liveResponse = try decoder.decode(LiveResponse.self, from: data!)
                
                if liveResponse.items != nil {
                    
                    DispatchQueue.main.async {
                        
                        self.delegate?.liveVideosFetched(liveResponse.items!)
                    }
                }
                
                dump(liveResponse)
            }
            
            catch {
                
            }
        }
        
        dataTask.resume()
    }
}
