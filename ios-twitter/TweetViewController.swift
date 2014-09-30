//
//  TweetViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/26/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var tweet: Tweet! {
        
        willSet(tweet) {
            
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = .whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    /*
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        tableView.reloadData()
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // we just have 3 cells
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch (indexPath.row) {
        
        case 0:
            return detailsCell()
        
        case 1:
            return statsCell()
            
        case 2:
            return actionsCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func detailsCell() -> TweetDetailCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailsCell") as TweetDetailCell
        cell.tweet = tweet
        return cell
    }
    
    func statsCell() -> TweetStatsCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetStatsCell") as TweetStatsCell
        cell.tweet = tweet
        return cell
    }
    
    func actionsCell() -> TweetActionsCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetActionsCell") as TweetActionsCell
        cell.tweet = tweet
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    @IBAction func onCompose(sender: AnyObject) {
        
        performSegueWithIdentifier("createTweetSegue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "createTweetSegue" {
        
            let navController = segue.destinationViewController as UINavigationController
            let vc = navController.viewControllers[0] as CreateTweetViewController
            if let replyTo = tweet.user?.screenName {
            
                vc.replyTo = replyTo
            }
        }
    }
}
