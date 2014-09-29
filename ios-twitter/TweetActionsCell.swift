//
//  TweetActionsCell.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TweetActionsCell: UITableViewCell {

    
    var tweet: Tweet! {
        
        willSet(tweet) {
            
            populate(tweet)
        }
    }
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    func populate(tweet: Tweet) {
    
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onTweet(sender: AnyObject) {
        
        
    }
  
}
