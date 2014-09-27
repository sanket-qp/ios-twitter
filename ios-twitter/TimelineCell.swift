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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
