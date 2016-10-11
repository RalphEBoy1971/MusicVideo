//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 8/31/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    var filterSearch = [Videos]()
    
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChange() {
        print("The preferred Font has changed ...")
    }
    
    func didLoadData(_ videos:[Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
//        for item in videos {
//            print("name = \(item.vName)")
//        }
        
        for (index, item) in videos.enumerated() {
            print("\(index) name = \(item.vName) - \(item.vGenre)")
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
        
        title = ("The iTunes Top \(limit) Music Videos")
        
        // Setup the Search Controller
        resultSearchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        
        resultSearchController.dimsBackgroundDuringPresentation = false
        
        resultSearchController.searchBar.placeholder = "Search for Artist, Name, or Rank"
        
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        
        // add the search bar to your tableview
        tableView.tableHeaderView = resultSearchController.searchBar
        
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
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            // move back to Main Queue
            DispatchQueue.main.async {
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cencel", style: .default) {
                action -> () in
                print("Cancel")
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
                action -> () in
                print("delete")
            }
            
            let okAction = UIAlertAction(title: "ok", style: .default) { action -> Void in
                print("Ok")
                
                //do something if you want
                //alert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true, completion: nil)
            }
            
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                runAPI()
            }
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        
        if resultSearchController.isActive {
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search")
        } else {
            runAPI()
        }
        
    }
    
    
    func getAPICount() {
        
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            limit = theValue
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDte = formatter.string(from: Date())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
        
        
    }
    
    func runAPI() {
        
        getAPICount()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if resultSearchController.isActive {
            return filterSearch.count
        }
        return videos.count
    }
    
    fileprivate struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier, for: indexPath) as! MusicVideoTableViewCell
        
        if resultSearchController.isActive {
            cell.video = filterSearch[(indexPath as NSIndexPath).row]
        } else {
            cell.video = videos[(indexPath as NSIndexPath).row]
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboard.segueIdentifier
        {
            if let indexpath = tableView.indexPathForSelectedRow {
                
                let video: Videos
                
                if resultSearchController.isActive {
                    video = filterSearch[(indexpath as NSIndexPath).row]
                } else {
                    video = videos[(indexpath as NSIndexPath).row]
                }
                let dvc = segue.destination as! MusicVideoDetailVC
                dvc.videos = video
                
            }
            
            
        }
    }
 
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        searchController.searchBar.text!.lowercaseString
//        filterSearch(searchController.searchBar.text!)
//    }
    
    func filterSearch(_ searchText: String) {
        filterSearch = videos.filter { Videos in
            return Videos.vArtist.lowercased().contains(searchText.lowercased()) || Videos.vName.lowercased().contains(searchText.lowercased()) || "\(Videos.vRank)".lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

//extension MusicVideoTVC: UISearchResultsUpdating {
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        searchController.searchBar.text!.lowercaseString
//        filterSearch(searchController.searchBar.text!)
//    }
//}



