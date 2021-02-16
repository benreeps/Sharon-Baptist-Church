//
//  Constants.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/12/21.
//

import Foundation

struct Constants {
    
    static var API_KEY = "AIzaSyCBTSFagdYePVn49O4Z9po6zk3rKuXoSC8"
    static var PLAYLIST_ID = "PL9qOK5nqpTFvl6SNaZVxjXcflLe0nAJPm"
    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    
}
