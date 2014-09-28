//
//  CreateTweetViewController.swift
//  ios-twitter
//
//  Created by sanket patel on 9/27/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onCancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)

    }
}
