import Foundation

struct Article {
    var title: String
    var teaser: String
    var body: String
    var publishedAt: String
    var section: String
    var slug: String
    var imageURL: String
    static func jsonToArticle(articleJSON: Dictionary<String, JSON>) -> Article {
        return Article(
            title: articleJSON["title"]!.stringValue,
            teaser: articleJSON["teaser"]!.stringValue,
            body: articleJSON["body"]!.stringValue,
            publishedAt: articleJSON["published_at"]!.stringValue,
            section: "section",
            slug: articleJSON["slug"]!.stringValue,
            imageURL: "imageurl"
        )
    }
}
protocol ChronAPIDelegate {
    func didReceiveChronAPIResults(results: Array<Article>)
}

class ChronAPI {
    var baseUrl: String {
        return "https://api.dukechronicle.com"
    }
    var delegate: ChronAPIDelegate?
    init() {
    }
    func getQduke() {
        let url = NSURL(string: "\(baseUrl)/qduke")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            let json = JSON(data: data)
            let newsIds: Array<JSON> = json["layout"]["news"].arrayValue
            let articles: Dictionary<String, JSON> = json["articles"].dictionaryValue
            let res: Array<Article> = newsIds.map({ (json: JSON) -> Article in
                return Article.jsonToArticle(articles[json.stringValue]!.dictionaryValue)
            })
            self.delegate?.didReceiveChronAPIResults(res)
        })
        task.resume()
    }
}