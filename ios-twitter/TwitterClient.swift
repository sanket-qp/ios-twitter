//
//  TwitterClient.swift
//  ios-twitter
//
//  Created by sanket patel on 9/26/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation
let consumerKey = "PUtQayEW0xzCIpcECIEOeKp8z"
let consumerSecret = "RnH1TB0megM9etmDeSXMDLt1Pa4D17tPVJgm17RL2pQ11Lxu3f"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    class var sharedInstance: TwitterClient {
    
        struct Static {
            
            static var instance: TwitterClient?
        }
        
        if Static.instance == nil {
        
            Static.instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
        }
        
        return Static.instance!
    }
    
    func getMyTimeline() {
    
        
        
    }
}