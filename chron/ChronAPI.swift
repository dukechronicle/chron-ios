import Foundation

protocol ChronAPIDelegate {
    func didReceiveChronAPIResults(results: Array<String>)
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
            let res: Array<String> = newsIds.map({ (json: JSON) -> String in
                return json.stringValue
            })
            self.delegate?.didReceiveChronAPIResults(res)
        })
        task.resume()
    }
}