//
//  User.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation
var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
class User {

    var id: String?
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    class var currentUser: User? {
    
        get {
        
            if (_currentUser == nil) {
        
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if (data != nil) {
        
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dict: dictionary)
                }
            }
        
            return _currentUser
        }
    
        set(user) {
            
            _currentUser = user
            
            if _currentUser != nil {
            
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            
            } else {
            
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)

            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
        }
     }
    
    init(dict: NSDictionary) {
    
        dictionary = dict
        id = dict["id_str"] as? String
        name = dict["name"] as? String
        screenName = dict["screen_name"] as? String
        screenName = "@\(screenName!)"
        profileImageUrl = dict["profile_image_url"] as? String
        tagline = dict["description"] as? String
    }
    
    func getHomeTimeline(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
    
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
                var tweets = Tweet.createTweetArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                completion(tweets: nil, error: error)
            }
    }
    
    func getMentionsTimeline(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
    
        let endpoint = "1.1/statuses/user_timeline.json?user_id=\(self.id!)"
        println(endpoint)
        
        TwitterClient.sharedInstance.GET(endpoint, parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
                var tweets = Tweet.createTweetArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                completion(tweets: nil, error: error)
            }
    }
    
    func logout() {
    
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    }
}