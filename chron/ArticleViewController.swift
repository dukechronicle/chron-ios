//
//  ArticleViewController.swift
//  chron
//
//  Created by Michael Lai on 12/22/14.
//  Copyright (c) 2014 Duke Chronicle. All rights reserved.
//

import UIKit

func convertDate(isoString: String) -> NSDate {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
    let posix = NSLocale(localeIdentifier: "en_US_POSIX")
    formatter.locale = posix
    if let res = formatter.dateFromString(isoString) {
        return res
    } else {
        println("can't convert")
        return NSDate()
    }
}

func formatDate(date: NSDate) -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MMMM d, yyyy"
    return formatter.stringFromDate(date)
}

class ArticleViewController: UIViewController, UIWebViewDelegate {

    var article: Article!

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var bodyWebView: UIWebView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if article != nil {
            self.titleTextView.text = article!.title
            self.bodyWebView.loadHTMLString(article!.body, baseURL: nil)
            let publishedAt = convertDate(article.publishedAt)
            self.infoTextView.text = "\(formatDate(publishedAt))"
        }
        self.bodyWebView.scrollView.scrollEnabled = false
    }

    override func viewDidAppear(animated: Bool) {
        var titleFrame = titleTextView.frame
        titleFrame.size.height = 1
        titleTextView.frame = titleFrame
        let fittingSize = titleTextView.sizeThatFits(CGSizeMake(titleFrame.size.width, 0))
        titleFrame.size = fittingSize
        titleTextView.frame = titleFrame
        titleHeightConstraint.constant = titleFrame.size.height
        
        // Adjust scroll frame size, this happens after WebView's size has changed
        let scrollViewHeight = bodyWebView.frame.height + titleTextView.frame.height
        var scrollFrame = scrollView.frame
        scrollFrame.size.height = scrollViewHeight
        scrollView.frame = scrollFrame
        scrollView.contentSize = CGSize(width: scrollFrame.width, height:scrollFrame.height)
        
        scrollView.layoutIfNeeded()
        scrollView.updateConstraintsIfNeeded()
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
        webViewHeightConstraint.constant = frame.size.height
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
