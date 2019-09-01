//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by vine on 2019/8/31.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit
import GitHub

class TweetTableViewController: UITableViewController, UITextFieldDelegate {

//    var someInts = [Int]()
//    var someInts = Array<Int>()
//    var nameOfIntegers = Dictionary<Int, String>()
    private var tweets = [Array<Repository>]() {
        didSet {
            print(tweets)
        }
    }

    var searchText: String? {
        didSet {
            searchTextField.text = searchText
            searchTextField.resignFirstResponder()

            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        }
    }
    private func twitterRequest() -> Request? {
        if let query = searchText, !query.isEmpty {
            return Request(search: query, count: 100)
        }
        return nil
    }
    private var lastTwitterRequest: Request?

    private func searchForTweets() {
        if let request = twitterRequest() {
            lastTwitterRequest = request
            request.fetchRepos { [weak self] (newRepos) in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.tweets.insert(newRepos, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchText = searchTextField.text
        }
        return true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)

        // Configure the cell...
        let tweet = tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }
        return cell
    }

}
