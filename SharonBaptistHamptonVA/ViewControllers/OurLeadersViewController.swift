//
//  OurLeadersTableViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/8/21.
//

import UIKit

class OurLeadersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var leaders: [Leader] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        leaders = createLeaderArray()
    }
    
    func createLeaderArray() -> [Leader] {
        
        var tempLeaders: [Leader] = []
        
        let leader1 = Leader(title: "Senior Pastor", name: "David Carroll", description: "A native of PA., he was born and raised in a rural community just outside of Harrisburg. Following his graduation from high school he enlisted in the USAF. At the age of twenty-six he received Christ as his personal Savior at a small mission church in Steeple Aston, England while serving in the United States Air Force. It was there that he surrendered to preach the gospel of Jesus Christ. After obtaining his Th. B. he was ordained into the gospel ministry. He has served in churches in South Carolina, West Virginia, Pennsylvania and currently serves as the Senior Pastor here at Sharon Baptist Church where he has been for the last 10 years. He is married to Diana (Randolph) Carroll his wife of 34 years. They have two grown boys whose families are actively serving the Lord. He also has 6 grandchildren whom he loves to spend time with. Pastor Dave and Diana encourage you to visit Sharon Baptist Church A Place To Belong.", image: UIImage(named: "PastorDavid")!, spouseImage: UIImage(named: "PastorWife")!, leaderSpouseName: "David & Diana Carroll")
        
        let leader2 = Leader(title: "Associate Pastor", name: "James Grandinetti", description: "James and Shannon have been with Sharon Baptist Church since 2015. James was saved at the age of 13 in a small church in Lilburn, GA. James spent 14 years in the US Army and was called into full-time ministry in 2013. James has completed Bible courses with West Coast Baptist College and hold a Masters in Ministry (M.Min.) through The Crown College of the Bible (Crown Seminary)  in Powell, TN. James and Shannon head up the Outreach Ministries of Sharon Baptist Church; with a heart to see God's people engaged in Personal Evangelism.", image: UIImage(named: "PastorJames")!, spouseImage: UIImage(named: "JamesShannon")!, leaderSpouseName: "James & Shannon Grandinetti")
        
        tempLeaders.append(leader1)
        tempLeaders.append(leader2)
        
        return tempLeaders
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaderDetailSegue" {
            let ourLeadersDetailViewController = segue.destination as! OurLeadersDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            ourLeadersDetailViewController.leader = leaders[index]
        }
    }
}

// MARK: - Table view data source

extension OurLeadersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leader = leaders[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderTableViewCell") as! OurLeadersTableViewCell
        
        cell.setLeader(leader: leader)
        
        return cell
    }
    
    
}


