//
//  ViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/17/21.
//

import Foundation
import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlaylistModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let playlistModel = PlaylistModel()
    var videos = [Video]()
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set itself as the data source and the delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set itself as the delegate of the model
        playlistModel.delegate = self
        
        playlistModel.getVideos()
    }

    //MARK:- Model Delegate Methods
    
    func videosFetched(_ videos: [Video]) {
        DispatchQueue.main.async {
            
            // Set the returned videos to our video property
            self.videos = videos
            
            // Refresh the tableview
            self.tableView.reloadData()
        }
    }
    
    //MARK:- TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        let video = self.videos[indexPath.row]
        cell.setCell(video)
        
        return cell 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Confirm that a video was selected
        guard tableView.indexPathForSelectedRow != nil else {return}
        
        // Get a reference to the video that was tapped on
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Set the video property of the detail view controller
        detailVC.video = selectedVideo 
    }
    
}
