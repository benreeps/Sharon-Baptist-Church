//
//  Model.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/16/21.
//

import Foundation

class Model {
    
    func getVideos() {
        
        let url = URL(string: Constants.API_URL)
        guard url != nil else {return}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil || data == nil {
                return
            }
        }
        dataTask.resume() 
    }
    
}
