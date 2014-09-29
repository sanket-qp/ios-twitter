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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.backItem?.title = "Logout"
        //let composeImage = UIImage(named: "ic_action_compose.png")
        //self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        //self.navigationItem.rightBarButtonItem?.image = composeImage
        User.currentUser?.getHomeTimeline(nil, completion: { (tweets, error) -> () in
            
            if (tweets != nil) {

                self.loadTimeline(tweets!)
            }
            
            if (error != nil) {
            
                println("\(error)")
            }
        })
    }

    func loadTimeline(tweets: [Tweet]) {
    
        println("loading timeline")
        self.tweets = tweets
        self.tableView.reloadData()
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
        println(indexPath.row)
        return cell
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
    

}
