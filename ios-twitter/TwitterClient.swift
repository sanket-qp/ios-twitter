//
//  TwitterClient.swift
//  ios-twitter
//
//  Created by sanket patel on 9/26/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation

//let consumerKey = "PUtQayEW0xzCIpcECIEOeKp8z"
//let consumerSecret = "RnH1TB0megM9etmDeSXMDLt1Pa4D17tPVJgm17RL2pQ11Lxu3f"
let consumerKey = "6fPexPfhGUchE22T5PlQcdwo5"
let consumerSecret = "tya8y40IloTGdBe6ZUiGPE83XtOMgGP7UeR9wCb4HwEgsauh6l"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        
        struct Static {
            
            static var instance: TwitterClient?
        }
        
        if Static.instance == nil {
        
            Static.instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
        }
        
        return Static.instance!
    }
    

    func loginWithCompletion(next: (requestToken: BDBOAuthToken?, error: NSError?) -> (), completion: (user: User?, error: NSError?) -> ()) {
    
        loginCompletion = completion
        requestSerializer.removeAccessToken()
        
        // get a request token
        fetchRequestTokenWithPath("oauth/request_token", method: "POST", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            
                next(requestToken: requestToken, error: nil)
            
            }) { (error: NSError!) -> Void in

                println("error getting token : \(error)")
                self.loginCompletion?(user: nil, error: error)
            }
    }
    
    func openURL(url: NSURL) {
        
        // check for error 
        let query = url.query
        let stringMatch = query?.rangeOfString("denied", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)
        
        if stringMatch != nil {
        
            self.loginCompletion?(user: nil, error: NSError(domain: "Invalid Auth Token", code: 1, userInfo: nil))
            
        } else {
        
            TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            
                println("got access token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
                // get the user
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                        println("got user")
                        var user = User(dict: response as NSDictionary)
                        User.currentUser = user
                        println("\(User.currentUser!.name)")
                        self.loginCompletion?(user: user, error: nil)
                    
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    
                        println("error getting user")
                        self.loginCompletion?(user: nil, error: error)
                    })
            
                }) { (error: NSError!) -> Void in
            
                    println("error getting token : \(error)")
                    self.loginCompletion?(user: nil, error: error)
            }
        }
    }
}