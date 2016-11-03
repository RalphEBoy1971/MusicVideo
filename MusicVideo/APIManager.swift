//
//  APIManager.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 5/19/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import Foundation

class APIManager {
    
    
    func loadData(_ urlString:String, completion: @escaping ([Video]) -> Void) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        //let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url) {
            (data, response, error) -> Void in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                let videos = self.parseJson(data: data as NSData?)
                
                let priority = DispatchQueue.GlobalQueuePriority.default
                DispatchQueue.global(priority: priority).async {
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                }
            }
        }
            task.resume()
    }
    
    func  parseJson(data: NSData?) -> [Video] {
        
        do {
            
            if let json = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject? {
                
                return JsonDataExtractor.extractVideoDataFromJson(videoDataObject: json)
                
            }
        }
            
        catch {
            print("Failed to parse data: \(error)")
        }
        
        return [Video]()
    }
    
}
