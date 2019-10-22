//
//  TweetController.swift
//  TwitterTestApp
//
//  Created by CtanLI on 2019-10-20.
//  Copyright © 2019 twitterTestApp. All rights reserved.
//

import UIKit
import TwitterKit

class TweetController: TWTRTimelineViewController, TWTRTimelineDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  NSLocalizedString("Search", comment: "The Search Viewcontrollers title name")
        searchBar.delegate = self
        self.timelineDelegate = self
        self.showTweetActions = true
        self.view.backgroundColor = .white
    }
    
    func timelineDidBeginLoading(_ timeline: TWTRTimelineViewController) {
        print("Began loading Tweets.")
    }
    
    func timeline(_ timeline: TWTRTimelineViewController, didFinishLoadingTweets tweets: [Any]?, error: Error?) {
        if error != nil {
            print("Encountered error \(error!)")
        } else {
            print("Finished loading \(tweets!.count)")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: searchBar.text ?? "", apiClient: TWTRAPIClient())
        self.searchBar.endEditing(true)
    }
}
