//

//  TimelineCell.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {

    var tweet: Tweet! {
    
        willSet(tweet) {
        
            populate(tweet)
        }
    }
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var numOfFavoritesLabel: UILabel!
    @IBOutlet weak var numOfRetweetsLabel: UILabel!
    
    var isFavorite: Bool = false
    var isRetweeted: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetFavorited:" , name: "tweetFavorited", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetUnFavorited:" , name: "tweetUnFavorited", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetRetweeted:" , name: "tweetRetweeted", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetUnRetweeted:" , name: "tweetUnRetweeted", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetNotChanged:" , name: "tweetNotChanged", object: nil)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func tweetFavorited(sender: AnyObject) {
        
        if let modifiedTweet = sender.object as? Tweet {
        
            if modifiedTweet.id == tweet.id {
            
                println("favoriting : \(tweet.text)")
                
                var cnt = tweet.favoriteCount!
                cnt += 1
                numOfFavoritesLabel.text = "\(cnt)"
                toggle(true, button: favoriteButton, named: "favorite_on")
            }
        }
    }
    
    
    func tweetUnFavorited(sender: AnyObject) {
        

        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                println("un-favoriting : \(tweet.text)")
                toggle(false, button: favoriteButton, named: "favorite_default")
                
                var cnt = tweet.favoriteCount!
                if (cnt > 0) {
                    
                    cnt -= 1
                }
                
                numOfFavoritesLabel.text = "\(cnt)"
            }
        }
    }
    
    
    func tweetRetweeted(sender: AnyObject) {
        
        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                toggle(true, button: retweetButton, named: "retweet_on")
                var cnt = tweet.retweetCount!
                cnt += 1
                numOfRetweetsLabel.text = "\(cnt)"
            }
        }
        
    }
    
    
    func tweetUnRetweeted(sender: AnyObject) {
        
        if let modifiedTweet = sender as? Tweet {
            
            if modifiedTweet.id == tweet.id {
                
                toggle(false, button: favoriteButton, named: "retweet_default")
                
                var cnt = tweet.retweetCount!
                if (cnt > 0) {
                    
                    cnt -= 1
                }
                
                numOfRetweetsLabel.text = "\(cnt)"
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
    
    func populate(tweet: Tweet) {
    
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = tweet.user?.screenName
        tweetTextLabel.text = tweet.text
        numOfFavoritesLabel.text = "\(tweet.favoriteCount!)"
        numOfRetweetsLabel.text = "\(tweet.retweetCount!)"
        

        isFavorite = tweet.favorited ?? false
        let favoriteImage = isFavorite ? "favorite_on" : "favorite_default"
        toggle(isFavorite, button: favoriteButton, named: favoriteImage)
        
        isRetweeted = tweet.reTweeted ?? false
        let retweetImage = isRetweeted ? "retweet_on" : "retweet_default"
        toggle(isRetweeted, button: retweetButton, named: retweetImage)
        if isRetweeted {
        
            retweetButton.enabled = false
        }
        
        if let profileImageUrl = tweet.user?.profileImageUrl {
            
            profileImage.setImageWithURL(NSURL(string: profileImageUrl))
            
        }
        
        let replyY = replyButton.frame.maxY
        let reTweetFrame = retweetButton.frame
        let newFrame = CGRect(x: reTweetFrame.minX, y: replyY, width: reTweetFrame.width, height: reTweetFrame.height)
        retweetButton.frame = newFrame
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        isFavorite = !isFavorite
        var image: UIImage!
        isFavorite ? toggle(true, button: favoriteButton, named: "favorite_on") : toggle(false, button: favoriteButton, named: "favorite_default")
        
        tweet.favorite { (tweet, error) -> () in
            
            if (tweet != nil) {
                
                self.isFavorite = tweet!.favorited!
                self.tweet = tweet
            
            } else if (error != nil) {
            
                // restore the button state
                self.isFavorite = !self.isFavorite
                self.isFavorite ? self.toggle(true, button: self.favoriteButton, named: "favorite_on") : self.toggle(false, button: self.favoriteButton, named: "favorite_default")
                ViewHelpers.showErrorBar("Error, please try again", forDuration: 10)
            }
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        isRetweeted = !isRetweeted
        isRetweeted ? toggle(true, button: retweetButton, named: "retweet_on") : toggle(false, button: retweetButton, named: "retweet_default")
        
        tweet.reTweet { (tweet, error) -> () in
            
            if (tweet != nil) {
            
                println("retweeted")
                self.tweet = tweet
                
            } else if (error != nil) {
            
                println(error)
            }
        }
    }
    
    func toggle(on: Bool, button: UIButton, named: String) {
    
        let image = UIImage(named: named)
        button.setImage(image, forState: UIControlState.Normal)
    }
}
