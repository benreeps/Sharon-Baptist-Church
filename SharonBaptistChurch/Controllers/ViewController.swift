//
//  ViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 2/17/21.
//


import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlaylistControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let playlistController = PlaylistController() 
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set itself as the data source and the delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set itself as the delegate of the model
        playlistController.delegate = self
        
        playlistController.getVideos()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath)
        
        let title = self.videos[indexPath.row].title
        cell.textLabel?.text = title
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
