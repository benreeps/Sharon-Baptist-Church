//
//  Model.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/16/21.
//

import Foundation
import UIKit

protocol PlaylistModelDelegate {
    
    func videosFetched(_ videos: [Video])
}

class PlaylistModel {
    
    var delegate: PlaylistModelDelegate?
    
    func getVideos() {
        
        let url = URL(string: Constants.API_URL)
        
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
                let response = try decoder.decode(Response.self, from: data!)
                print("\(response)")
                if response.items != nil {
                    
                    DispatchQueue.main.async {
                        
                        self.delegate?.videosFetched(response.items!)
                    }
                }
                
                dump(response)
            }
            
            catch {
                
                print("decoding error")
                
            }
        }
        
        dataTask.resume() 
    }
}
