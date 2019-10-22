//
//  MapController.swift
//  TwitterTestApp
//
//  Created by CtanLI on 2019-10-20.
//  Copyright © 2019 twitterTestApp. All rights reserved.
//

import UIKit
import MapKit
import TwitterKit

class MapController: UIViewController, TWTRTimelineDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Tweets", comment: "The map Viewcontrollers title name")
        self.navigationItem.setHidesBackButton(true, animated:true)
        fetchTweetsByCordinates()
        alert(message: "Twitter search api not returning geo location info.", title: "Unable to populate the map with tweet based on location.")
    }
    
    func fetchTweetsByCordinates() {
         let client = TWTRAPIClient()
         let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
         let params = ["q": "@blogTO", "result_type": "recent", "include_entities": "false", "count": "20"]
         var clientError : NSError?
         
         let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
         client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
             if connectionError != nil {
                 print("Error: \(String(describing: connectionError))")
             }
             do {
                 let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                 let statuses = json!["statuses"] as? [Any]
                let status = statuses![0]
                print(status)

             } catch let jsonError as NSError {
                 print("json error: \(jsonError.localizedDescription)")
             }
         }
    }
}
