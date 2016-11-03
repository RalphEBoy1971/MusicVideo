//
//  JsonDataExtrator.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 11/3/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import Foundation
class JsonDataExtractor {
    static func extractVideoDataFromJson(videoDataObject: AnyObject) -> [Video] {
        
        guard let videoData = videoDataObject as? JSONDictionary else {
            return [Video]()
        }
        
        var videos = [Video]()
        
        if let feeds = videoData["feed"] as? JSONDictionary, let entries = feeds["entry"] as? JSONArray {
            
            for (index, data) in entries.enumerated() {
                
                var vName = "", vRights = "", vPrice = "", vImageUrl = "", vArtist = "", vVideoUrl = "", vImid = "", vGenre = "", vLinkToiTunes = "", vReleaseDte = ""
                
                // Video Name
                if let imName = data["im:name"] as? JSONDictionary,
                    let label = imName["label"] as? String {
                    vName = label
                }
                
                // The Video Image
                if let imImage = data["im:image"] as? JSONArray,
                    let image = imImage[2] as? JSONDictionary,
                    let label = image["label"] as? String {
                    vImageUrl = label.replacingOccurrences(of: "100x100", with: "600x600")
                }
                
                // Video Url
                if let link = data["link"] as? JSONArray,
                    let vUrl = link[1] as? JSONDictionary,
                    let attributes = vUrl["attributes"] as? JSONDictionary,
                    let href = attributes["href"] as? String {
                    vVideoUrl = href
                }
                
                // Video Rights
                if let rightsDict = data["rights"] as? JSONDictionary,
                    let label = rightsDict["label"] as? String {
                    vRights = label
                }
                
                // Video Price
                if let imPrice = data["im:price"] as? JSONDictionary,
                    let label = imPrice["label"] as? String {
                    vPrice = label
                }
                
                // Video Artist
                if let imArtist = data["im:artist"] as? JSONDictionary,
                    let label = imArtist["label"] as? String {
                    vArtist = label
                }
                
                // Video ImID
                if let id = data["id"] as? JSONDictionary,
                    let attributes = id["attributes"] as? JSONDictionary,
                    let Imid = attributes["im:id"] as? String {
                    vImid = Imid
                }
                
                // Video Genre
                if let category = data["category"] as? JSONDictionary,
                    let attributes = category["attributes"] as? JSONDictionary,
                    let term = attributes["label"] as? String {
                    vGenre = term
                }
                
                // Video Link To iTunes
                if let id = data["id"] as? JSONDictionary,
                    let label = id["label"] as? String {
                    vLinkToiTunes = label
                }
                
                // Video Release Date
                if let imReleaseData = data["im:releaseDate"] as? JSONDictionary,
                    let attributes = imReleaseData["attributes"] as? JSONDictionary,
                    let label = attributes["label"] as? String {
                    vReleaseDte = label
                }
                
                let currentVideo = Video(vRank: index + 1, vName: vName, vRights: vRights, vPrice: vPrice, vImageUrl: vImageUrl, vArtist: vArtist, vVideoUrl: vVideoUrl, vImid: vImid, vGenre: vGenre, vLinkToiTunes: vLinkToiTunes, vReleaseDte: vReleaseDte)
                
                videos.append(currentVideo)
                
            }
        }
        return videos
    }
}
