//
//  Tweet.swift
//  ios-twitter
//
//  Created by sanket patel on 9/26/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation
class Tweet {

    var id: Int?
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int?
    var favoriteCount: Int?
    
    init(dict: NSDictionary) {
    
        id = dict["id"] as Int
        user = User(dict: dict["user"] as NSDictionary)
        text = dict["text"] as? String
        createdAtString = dict["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        retweetCount = dict["retweet_count"] as? Int
        favoriteCount = dict["favorite_count"] as? Int
    }
    
    class func createTweetArray(dicts: [NSDictionary]) -> [Tweet] {
    
        return dicts.map({(tweet: NSDictionary) -> Tweet in
            
            Tweet(dict: tweet)
        
        })
    }
    
    class func createTweet() {
    
        
    }
    
    func favorite(completion: (tweet: Tweet?, error: NSError?) -> ()) {
        
        /*
        let params = ["id": self.id]
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json", parameters: params, constructingBodyWithBlock: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            let tweet = Tweet(dict: response as NSDictionary)
            completion(tweet: tweet, error: nil)
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                completion(tweet: nil, error: error)
        }*/

        completion(tweet: nil, error: NSError())
    }
}