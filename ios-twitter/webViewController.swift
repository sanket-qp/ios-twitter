//
//  webViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/26/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class webViewController: UIViewController {

    var destination: String! = nil
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccess:" , name: "loginSuccess", object: nil)

        if destination != nil {
        
            let url = NSURL(string: destination)
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginSuccess(sender: AnyObject) {
        
        self.performSegueWithIdentifier("timelineSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("preparing for timeline segue")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
