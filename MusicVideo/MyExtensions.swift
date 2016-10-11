//
//  MyExtensions.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 9/7/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import UIKit

extension MusicVideoTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.text!.lowercased()
        filterSearch(searchController.searchBar.text!)
    }
}
