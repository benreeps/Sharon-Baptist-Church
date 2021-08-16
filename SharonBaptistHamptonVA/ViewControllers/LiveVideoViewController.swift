//
//  LiveStreamViewController.swift
//  SharonBaptistChurch
//
//  Created by Benjamin Reeps on 3/4/21.
//

import Foundation
import UIKit

class LiveVideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LiveVideoModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let liveVideoModel = LiveVideoModel()
    var liveVideos = [LiveVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set itself as the data source and the delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        liveVideoModel.delegate = self
        liveVideoModel.getLiveVideos()
        
    }
    
    //MARK:- Model Delegate Methods
    
    func liveVideosFetched(_ liveVideos: [LiveVideo]) {
        DispatchQueue.main.async {
            
            self.liveVideos = liveVideos
            self.tableView.reloadData()
        }
    }
    
    //MARK:- TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        liveVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.LIVEVIDEOCELL_ID, for: indexPath) as! LiveVideoTableViewCell
        let liveVideo = self.liveVideos[indexPath.row]
        cell.setCell(liveVideo)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Confirm that a video was selected
        guard tableView.indexPathForSelectedRow != nil else {return}
        
        // Get a reference to the video that was tapped on
        let selectedVideo = liveVideos[tableView.indexPathForSelectedRow!.row]
        
        // Get a reference to the detail view controller
        let liveDetailVC = segue.destination as! LiveDetailViewController
        
        // Set the video property of the detail view controller
        liveDetailVC.liveVideo = selectedVideo
    }
}

