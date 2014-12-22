//
//  ArticleViewController.swift
//  chron
//
//  Created by Michael Lai on 12/22/14.
//  Copyright (c) 2014 Duke Chronicle. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet var titleTextView: UITextView!
    var article: Article!
    
    @IBOutlet weak var bodyWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if article != nil {
            self.titleTextView.text = article!.title
            self.bodyWebView.loadHTMLString(article!.body, baseURL: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
