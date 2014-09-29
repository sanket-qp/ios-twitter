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
        
            nameLabel.text = tweet.user?.name
            screenNameLabel.text = tweet.user?.screenName
            tweetTextLabel.text = tweet.text
            if let profileImageUrl = tweet?.user?.profileImageUrl {
                
                profileImage.setImageWithURL(NSURL(string: profileImageUrl))
                
            }
        }
    }
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onFavorite(sender: AnyObject) {
        
        isFavorite = !isFavorite
        var image: UIImage!
        if (isFavorite) {
            
            image = UIImage(named: "favorite_on.png")
        
        } else {
            
            image = UIImage(named: "favorite_default.png")
        }
        
        favoriteButton.setImage(image, forState: UIControlState.Normal)
        
        tweet.favorite { (tweet, error) -> () in
            
            if (tweet != nil) {
            
            } else if (error != nil) {
            
                image = UIImage(named: "favorite_default.png")
                self.favoriteButton.setImage(image, forState: UIControlState.Normal)
                ViewHelpers.showErrorBar("Error favoriting tweet, please try again", forDuration: 10)
                
            }
            
        }
        
    }
}
