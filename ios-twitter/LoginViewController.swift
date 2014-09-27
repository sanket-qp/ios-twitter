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
    
    func loginFailed() {
    
        println("Login Failed")
        // show an error bar here
        let notification = CWStatusBarNotification()
        notification.notificationLabelBackgroundColor = .orangeColor()
        notification.displayNotificationWithMessage("Error Connecting Twitter", forDuration: 10)
        dismissViewControllerAnimated(true, completion: nil)
    }

    func authRequired() {
    
        self.performSegueWithIdentifier("webViewSegue", sender: self)
    }
    
    func loginSuccess() {
        
        NSNotificationCenter.defaultCenter().postNotificationName("loginSuccess", object: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        println("On login");
        TwitterClient.sharedInstance.loginWithCompletion({(requestToken, error) -> () in
            
            self.requestToken = requestToken?.token
            self.secret = requestToken?.secret
            self.authRequired()
            
        }, completion: { (user, error) -> () in

            if (user != nil) {
            
                println("user : \(user!.name))")
                self.loginSuccess()

            } else if (error != nil) {
            
                self.loginFailed()
            
            } else {
            
                self.loginNeeded()
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "webViewSegue" {
        
            let webViewNavigationController = segue.destinationViewController as UINavigationController
            let vc = webViewNavigationController.viewControllers[0] as webViewController
            vc.destination = "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken)"
            println("prepare for segue")
        }
    }
}
