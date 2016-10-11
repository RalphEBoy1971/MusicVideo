//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 5/19/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    
    // Data Encapsulation
    
    fileprivate var _vName:String
    fileprivate var _vImageUrl:String
    fileprivate var _vVideoUrl:String
    fileprivate var _vRights:String
    fileprivate var _vPrice:String
    fileprivate var _vArtist:String
    fileprivate var _vImid:String
    fileprivate var _vGenre:String
    fileprivate var _vLinkToiTunes:String
    fileprivate var _vReleaseDte:String
    
    // This variable gets created from the UI
    var vImageData:Data?
    
    // Make a getter
    
    var vName: String {
        return _vName
    }
    var vImageUrl: String {
        return _vImageUrl
    }
    var vVideoUrl: String {
        return _vVideoUrl
    }
    var vRights: String {
        return _vRights
    }
    var vPrice: String {
        return _vPrice
    }
    var vArtist: String {
        return _vArtist
    }
    var vImid: String {
        return _vImid
    }
    var vGenre: String {
        return _vGenre
    }
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    var vReleaseDte: String {
        return _vReleaseDte
    }
    
    init(data: JSONDictionary) {
        
        // If we do not initialize all properties we will get error message
        // Return from initializer without initializing all stored properties
        
        // Video Name
        if let name = data["im:name"] as? JSONDictionary,
            let vName = name["label"] as? String {
                self._vName = vName
        }
        else
        {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vName = ""
        }
        
        // The Video Image
        if let img = data["im:image"] as? JSONArray,
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
                _vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600")
        }
        else
        {
            _vImageUrl = ""
        }
        
        // Video Url
        if let video = data["link"] as? JSONArray,
            let vUrl = video[1] as? JSONDictionary,
            let vHref = vUrl["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = ""
        }
        
        // Video Rights
        if let rights = data["rights"] as? JSONDictionary,
            let vRights = rights["label"] as? String {
                self._vRights = vRights
        }
        else
        {
            _vRights = ""
        }
        
        // Video Price
        if let price = data["im:price"] as? JSONDictionary,
            let vPrice = price["label"] as? String {
                self._vPrice = vPrice
        }
        else
        {
            _vPrice = ""
        }
        
        // Video Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            let vArtist = artist["label"] as? String {
                self._vArtist = vArtist
        }
        else
        {
            _vArtist = ""
        }
        
        // Video ImID
        if let imid = data["id"] as? JSONDictionary,
            let imid2 = imid["attributes"] as? JSONDictionary,
            let vImid = imid2["im:id"] as? String {
                self._vImid = vImid
        }
        else
        {
            _vImid = ""
        }
        
        // Video Genre
        if let genre = data["category"] as? JSONDictionary,
            let genre2 = genre["attributes"] as? JSONDictionary,
            let vGenre = genre2["label"] as? String {
                self._vGenre = vGenre
        }
        else
        {
            _vGenre = ""
        }

        // Video Link To iTunes
        if let linkToiTunes = data["id"] as? JSONDictionary,
            let vLinkToiTunes = linkToiTunes["label"] as? String {
                self._vLinkToiTunes = vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes = ""
        }
        
        // Video Release Date
        if let releaseDte = data["im:releaseDate"] as? JSONDictionary,
            let releaseDte2 = releaseDte["attributes"] as? JSONDictionary,
            let vReleaseDte = releaseDte2["label"] as? String {
                self._vReleaseDte = vReleaseDte
        }
        else
        {
            _vReleaseDte = ""
        }
    }
    
}
