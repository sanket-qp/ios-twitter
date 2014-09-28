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
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
