import UIKit
import swiftz

class FrontpageController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChronAPIDelegate {

    var items: Array<Article>?
    var images = Dictionary<Int, NSData>()
    
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
        return items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("ArticlePreviewTableCell") as? ArticlePreviewTableCell
        if cell == nil {
            let nib = NSBundle.mainBundle().loadNibNamed("ArticlePreviewTableCell", owner: self, options: nil)
            cell = nib[0] as? ArticlePreviewTableCell
        }
        if let image = self.images[indexPath.row] {
        } else {
            if let imageInfo = self.items?[indexPath.row].image {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                    let imageUrl = NSURL(string: "https:\(imageInfo.thumbnailUrl)")
                    let data = imageUrl >>- { NSData(contentsOfURL : $0) }
                    dispatch_async(dispatch_get_main_queue(), {
                        if let loadedData = data {
                            self.images.updateValue(loadedData, forKey: indexPath.row)
                            cell!.thumbnail?.image = UIImage(data: loadedData)
                            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                        }
                    })
                })
            }
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

