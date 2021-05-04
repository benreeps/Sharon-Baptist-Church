//
//  MinistriesViewController.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/12/21.
//

import UIKit

class MinistriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ministries: [Ministry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

            tableView.delegate = self
            tableView.dataSource = self
          
            ministries = self.createMinistryArray()
        
        
        
    }
    
    func createMinistryArray() -> [Ministry] {
        
        var tempMenistries: [Ministry] = []
        
        let ministry1 = Ministry(title: "Grace Giving Missions",image: UIImage(named: "GraceGivingMissions")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/grace_giving_missions.html")!)
        let ministry2 = Ministry(title: "Adult Ministries", image: UIImage(named: "AdultMinistries")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/adult-ministries.html")!)
        let ministry3 = Ministry(title: "Outreach Ministry", image: UIImage(named: "OutreachMinistry")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/outreach-ministry.html")!)
        let ministry4 = Ministry(title: "Women's Ministries", image: UIImage(named: "WomensMinistries")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/womens-ministries.html")!)
        let ministry5 = Ministry(title: "Youth Ministries", image: UIImage(named: "YouthMinistries")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/youth-ministries.html")!)
        let ministry6 = Ministry(title: "Nursing Home Ministry", image: UIImage(named: "NursingHomeMinistry")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/nursing-home-ministry.html")!)
        let ministry7 = Ministry(title: "Children's Ministry", image: UIImage(named: "ChildrensMinistry")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/childrens-ministry.html")!)
        let ministry8 = Ministry(title: "Nursery Care", image: UIImage(named: "NurseryCare")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/nursery-care.html")!)
        let ministry9 = Ministry(title: "Bus Ministry", image: UIImage(named: "BusMinistry")!, url: NSURL(string: "https://www.sharonbaptisthamptonva.com/bus-ministry.html")!)
        
        tempMenistries.append(ministry1)
        tempMenistries.append(ministry2)
        tempMenistries.append(ministry3)
        tempMenistries.append(ministry4)
        tempMenistries.append(ministry5)
        tempMenistries.append(ministry6)
        tempMenistries.append(ministry7)
        tempMenistries.append(ministry8)
        tempMenistries.append(ministry9)
        
        return tempMenistries
        
    }
    
}

// MARK: - Table view data source

extension MinistriesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ministries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ministry = ministries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MinistryTableViewCell") as! MinistriesTableViewCell
        
        cell.setMinistry(ministry: ministry)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ministry = ministries[indexPath.row]
        let url = ministry.url
        UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)}
    } 
}

