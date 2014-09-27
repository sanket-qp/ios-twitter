//
//  LoginViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/25/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var webView: UIWebView!
    var requestToken: String!
    var secret: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginNeeded" , name: "loginRequired", object: nil)

    }
    
    func loginNeeded() {
    
        
        println("login needed")

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLogin(sender: AnyObject) {
        
        println("On login");
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        // get a request token
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "POST", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            
            println("\(requestToken)")
            self.requestToken = requestToken.token
            self.secret = requestToken.secret
            self.performSegueWithIdentifier("webViewSegue", sender: self)
            
            /*
            
            TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/acess_token", method: "POST", requestToken: requestToken, success: { (authToken:
                BDBOAuthToken!) -> Void in
                
                println("\(authToken)")
                
                }, failure: { (error: NSError!) -> Void in
                
                    println("error getting auth token : \(error)")
            }) */
            

            }) { (error: NSError!) -> Void in

            println(error)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "webViewSegue" {
        
            let vc = segue.destinationViewController as webViewController
            vc.destination = "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken)"
            println("prepare for segue")
        }
    }
}
