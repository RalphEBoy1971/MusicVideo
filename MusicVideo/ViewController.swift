//
//  ViewController.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 5/19/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [Videos]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }
    
    func didLoadData(_ videos:[Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerated() {
            print("\(index) name = \(item.vName)")
        }
        
        tableView.reloadData()
        
//        for i in 0..<videos.count {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }
        
//        for var i = 0; i < videos.count; i++ {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }

    }
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.red
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.green
        displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellow
        displayLabel.text = "Reachable with Cellular"
        default:return
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let video = videos[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = ("\((indexPath as NSIndexPath).row + 1)")
        
        cell.detailTextLabel?.text = video.vName
        
        return cell
        
    }
    
}

