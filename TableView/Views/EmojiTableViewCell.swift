//
//  EmojiTableViewCell.swift
//  TableView
//
//  Created by Gianluca Orpello on 18/03/21.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    var currentEmoji: Emoji?{
        didSet{
            if let emoji = currentEmoji {
                emojiLabel.text = emoji.symbol
                emojiNameLabel.text = emoji.name
                descriptionLabel.text = emoji.description
            }
        }
    }
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var emojiNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

}
