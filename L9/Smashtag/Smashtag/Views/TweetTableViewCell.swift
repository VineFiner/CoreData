//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by vine on 2019/9/1.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit
import GitHub

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreateLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Repository? {
        didSet {
            updateUI()
        }
    }
    private func updateUI() {
        tweetTextLabel.text = tweet?.name
        tweetUserLabel.text = tweet?.owner.login

        tweetProfileImageView.image = ImageService.shared.fetchImage(imageString: tweet?.owner.avatar_url)

        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24 * 60 * 60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreateLabel.text = formatter.string(from: created)
        } else {
            tweetCreateLabel.text = nil
        }
    }
}
