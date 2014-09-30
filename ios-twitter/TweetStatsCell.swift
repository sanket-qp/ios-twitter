//
//  TweetStatsCell.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TweetStatsCell: UITableViewCell {

    
    var tweet: Tweet! {
        
        willSet(tweet) {
            
            populate(tweet)
        }
    }
    
    @IBOutlet weak var numOfRetweetsLabel: UILabel!
    @IBOutlet weak var numOfFavouritesLabel: UILabel!
    
    func populate(tweet: Tweet) {
        
        numOfRetweetsLabel.text = "\(tweet.retweetCount)"
        numOfFavouritesLabel.text = "\(tweet.favoriteCount)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetFavorited:" , name: "tweetFavorited", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetUnFavorited:" , name: "tweetUnFavorited", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetRetweeted:" , name: "tweetRetweeted", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetUnRetweeted:" , name: "tweetUnRetweeted", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetNotChanged:" , name: "tweetNotChanged", object: nil)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func tweetFavorited(sender: AnyObject) {
        
        //println("favoriting handler 2 : \(sender)")
        
        if let modifiedTweet = sender.object as? Tweet {
            
            println("favoriting : \(modifiedTweet.text)")
            
            if modifiedTweet.id == tweet.id {
                
                var cnt = tweet.favoriteCount!
                cnt += 1
                numOfFavouritesLabel.text = "\(cnt)"
            }
        }
    }
    
    
    func tweetUnFavorited(sender: AnyObject) {
        
        
        if let modifiedTweet = sender.object as? Tweet {
            
            //println("un-favoriting : \(modifiedTweet.text)")
            
            if modifiedTweet.id == tweet.id {
                
                println("un-favoriting : \(tweet.text)")
                var cnt = tweet.favoriteCount!
                if (cnt > 0) {
                    
                    cnt -= 1
                }
                
                numOfFavouritesLabel.text = "\(cnt)"
            }
        }
    }
    
    
    func tweetRetweeted(sender: AnyObject) {
        
        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
            }
        }
    }
    
    
    func tweetUnRetweeted(sender: AnyObject) {
        
        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
            }
        }
    }
    
    func tweetNotChanged(sender: AnyObject) {
        
        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                populate(tweet)
            }
        }
    }
}
