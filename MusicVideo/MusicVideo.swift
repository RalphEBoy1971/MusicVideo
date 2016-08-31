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
    
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
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
            vName = name["label"] as? String {
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
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else
        {
            _vImageUrl = ""
        }
        
        // Video Url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = ""
        }
        
        // Video Rights
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
                self._vRights = vRights
        }
        else
        {
            _vRights = ""
        }
        
        // Video Price
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
                self._vPrice = vPrice
        }
        else
        {
            _vPrice = ""
        }
        
        // Video Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
                self._vArtist = vArtist
        }
        else
        {
            _vArtist = ""
        }
        
        // Video ImID
        if let imid = data["id"] as? JSONDictionary,
            imid2 = imid["attributes"] as? JSONDictionary,
            vImid = imid2["im:id"] as? String {
                self._vImid = vImid
        }
        else
        {
            _vImid = ""
        }
        
        // Video Genre
        if let genre = data["link"] as? JSONDictionary,
            genre2 = genre["attributes"] as? JSONDictionary,
            vGenre = genre2["label"] as? String {
                self._vGenre = vGenre
        }
        else
        {
            _vGenre = ""
        }

        // Video Link To iTunes
        if let linkToiTunes = data["id"] as? JSONDictionary,
            vLinkToiTunes = linkToiTunes["label"] as? String {
                self._vLinkToiTunes = vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes = ""
        }
        
        // Video Release Date
        if let releaseDte = data["im:releaseDate"] as? JSONDictionary,
            releaseDte2 = releaseDte["attributes"] as? JSONDictionary,
            vReleaseDte = releaseDte2["label"] as? String {
                self._vReleaseDte = vReleaseDte
        }
        else
        {
            _vReleaseDte = ""
        }
    }
    
}
