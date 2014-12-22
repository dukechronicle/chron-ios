//
//  ArticleViewController.swift
//  chron
//
//  Created by Michael Lai on 12/22/14.
//  Copyright (c) 2014 Duke Chronicle. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIWebViewDelegate {

    var article: Article!

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyWebView: UIWebView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if article != nil {
            self.titleTextView.text = article!.title
            self.bodyWebView.loadHTMLString(article!.body, baseURL: nil)
        }
        self.bodyWebView.scrollView.scrollEnabled = false
    }

    override func viewDidAppear(animated: Bool) {
        println("\(titleTextView.frame.size.width) \(titleTextView.frame.size.height)")
        var titleFrame = titleTextView.frame
        titleFrame.size.height = 1
        titleTextView.frame = titleFrame
        let fittingSize = titleTextView.sizeThatFits(CGSizeMake(titleFrame.size.width, 0))
        titleFrame.size = fittingSize
        titleTextView.frame = titleFrame
        println("\(titleTextView.frame.size.width) \(titleTextView.frame.size.height)")
        
        // Adjust scroll frame size, this happens after WebView's size has changed
        let scrollViewHeight = bodyWebView.frame.height + titleTextView.frame.height
        var scrollFrame = scrollView.frame
        scrollFrame.size.height = scrollViewHeight
        scrollView.frame = scrollFrame
        scrollView.contentSize = CGSize(width: scrollFrame.width, height:scrollFrame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        // Adjust WebView's size to match content
        var frame = bodyWebView.frame
        frame.size.height = 1
        bodyWebView.frame = frame
        let fittingSize = bodyWebView.sizeThatFits(CGSizeZero)
        frame.size = fittingSize
        bodyWebView.frame = frame
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
