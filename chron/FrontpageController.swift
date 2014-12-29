import UIKit

class FrontpageController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChronAPIDelegate {

    var items: Array<Article>?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        let api = ChronAPI()
        api.delegate = self
        api.getQduke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveChronAPIResults(results: Array<Article>) {
        self.items = results
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        });
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (items != nil) {
            return self.items!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("ArticlePreviewTableCell") as? ArticlePreviewTableCell
        if cell == nil {
            let nib = NSBundle.mainBundle().loadNibNamed("ArticlePreviewTableCell", owner: self, options: nil)
            cell = nib[0] as? ArticlePreviewTableCell
        }
        cell!.titleLabel?.text = self.items?[indexPath.row].title
        cell!.infoLabel?.text = self.items?[indexPath.row].teaser
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let articleView = self.storyboard?.instantiateViewControllerWithIdentifier("articleShow") as ArticleViewController
        articleView.article = self.items?[indexPath.row]
        self.navigationController?.pushViewController(articleView, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}

