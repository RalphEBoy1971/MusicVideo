//
//  ViewController.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 5/19/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos:[Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        
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
        case NOACCESS : view.backgroundColor = UIColor.redColor()
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
        displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        displayLabel.text = "Reachable with Cellular"
        default:return
        }
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

