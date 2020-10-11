//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Milana Stetsenko on 10/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetCell: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var fafButton: UIButton!
    
    
    var favourite:Bool = false
    var tweetId:Int = -1

    
    @IBAction func favourTweet(_ sender: Any) {
        let tobeFavourited = !favourite
        if (tobeFavourited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId , success:{
                self.setFavourite(true)
            }, failure:{(error) in
                print("favourite did not succeed:\(error)")
            })
        }else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (error) in
                print("unfavorite did not succeed:\(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
         }, failure: { (error) in
            print("error in retweeting: \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setFavourite(_ isFavourtied:Bool){
        favourite = isFavourtied
        if (favourite){
            fafButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }else{
            fafButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
