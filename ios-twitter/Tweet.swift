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
    var retweetCount: Int!
    var favoriteCount: Int!
    var reTweeted: Bool?
    var favorited: Bool?
    
    init(dict: NSDictionary) {
    
        id = dict["id"] as? Int
        user = User(dict: dict["user"] as NSDictionary)
        text = dict["text"] as? String
        createdAtString = dict["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        retweetCount = dict["retweet_count"] as? Int ?? 0
        favoriteCount = dict["favorite_count"] as? Int ?? 0
        reTweeted = dict["retweeted"] as? Bool
        favorited = dict["favorited"] as? Bool
    }
    
    class func createTweetArray(dicts: [NSDictionary]) -> [Tweet] {
    
        return dicts.map({(tweet: NSDictionary) -> Tweet in
            
            Tweet(dict: tweet)
        
        })
    }
    
    class func createTweet() {
    
        
    }
    
    
    func favorite(completion: (tweet: Tweet?, error: NSError?) -> ()) {
        
        let isFavorite = self.favorited!
        println(self.favorited)
        println(isFavorite)
        // if it's already favorite then we'll have to unfavorite it
        TwitterClient.sharedInstance.favoriteActions(!isFavorite, tweet: self, completion: completion)
    }
    func reTweet(completion: (tweet: Tweet?, error: NSError?) -> ()) {
    
        TwitterClient.sharedInstance.reTweet(self, completion)
    }
}