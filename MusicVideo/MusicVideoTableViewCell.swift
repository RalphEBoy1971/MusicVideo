//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 8/31/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    var video: Videos? {
        didSet {
            updateCell()
        }
    }

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell() {
        
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        musicTitle.text = video?.vName
        rank.text = ("#\(video!.vRank)")
        
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            print("#\(video!.vRank) - Get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        }
        else
        {
            getVideoImage(video!, imageView: musicImage)
            //print("Get images in background thread ...")
        }
        
        
    }
    
    func getVideoImage(_ video: Videos, imageView: UIImageView){
        
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            
            let data = try? Data(contentsOf: URL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
                print("#\(video.vRank) - Get data from iTunes ...")
            }
            
            // move back to Main Queue
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        

    }
    
    
    
}
