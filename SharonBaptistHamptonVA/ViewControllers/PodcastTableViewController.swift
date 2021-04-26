//
//  PodcastTableViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/20/21.
//

import UIKit

class PodcastTableViewController: UITableViewController {

    private var rssItems: [RSSItem]? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

       fetchData()
    }
    
    private func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://anchor.fm/s/ada7c94/podcast/rss") { (rssItems) in
            self.rssItems = rssItems
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rssItems = rssItems else {
            return 0
        }
        
      
        return rssItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastCell", for: indexPath) as! PodcastTableViewCell
        
        if let item = rssItems?[indexPath.item] {
            cell.item = item 
        }
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PodcastDetailSegue" {
            let podcastDetailViewController = segue.destination as! PodcastDetailViewController
            
            let index = rssItems?[tableView.indexPathForSelectedRow!.row]
         //   let allRssItems = [rssItems]
            podcastDetailViewController.rssItem = index
         //   podcastDetailViewController.rssItems = [allRssItems]
        }
    }

}
