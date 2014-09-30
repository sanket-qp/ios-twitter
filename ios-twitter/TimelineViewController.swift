//
//  TimelineViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/25/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.backItem?.title = "Logout"
        let composeImage = UIImage(named: "ic_action_compose")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem?.image = composeImage
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetCreated:" , name: "tweetCreated", object: nil)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshData:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, belowSubview: tableView)
        populate()
    }

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func loadTimeline(tweets: [Tweet]) {
    
        self.tweets = tweets
        self.tableView.reloadData()
    }
    
    func refreshData(sender: AnyObject) {
    
        populate(refreshing: true)
    }
    
    func populate(refreshing: Bool = false) {
    
        User.currentUser?.getHomeTimeline(nil, completion: { (tweets, error) -> () in
            
            if (refreshing) {
                
                self.refreshControl.endRefreshing()
            }
            
            if (tweets != nil) {
                
                self.loadTimeline(tweets!)
            }
            
            if (error != nil) {
                
                println(error)
                ViewHelpers.showErrorBar("Error Fetching Tweets", forDuration: 10)
            }
        })
        
    }
    
    func tweetCreated(sender: AnyObject) {
    
        if let newTweet = sender.object as? Tweet {
        
            tweets.insert(newTweet, atIndex: 0)
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        
        User.currentUser?.logout()
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogout", object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "tweetViewSegue" {
        
            if let tweetCell = sender as? TimelineCell {
                
                let vc = segue.destinationViewController as TweetViewController
                vc.tweet = tweetCell.tweet
            }
        }
    }

    /*
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }*/
}
