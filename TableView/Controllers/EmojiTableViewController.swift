//
//  EmojiTableViewController.swift
//  TableView
//
//  Created by Gianluca Orpello on 18/03/21.
//

import UIKit

class EmojiTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var emoji: [Emoji] = [] {
        didSet {
            Emoji.saveToFile(emoji)
        }
    }
    
    @IBOutlet weak var emojiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiTableView.dataSource = self
        emojiTableView.delegate = self
        
        if let savedEmoji = Emoji.readFromFile() {
            emoji = savedEmoji
        } else {
            emoji = Emoji.sampleEmojis
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emojiTableView.reloadData()
    }
    
    @IBAction func editTableView(_ sender: UIBarButtonItem) {
        let isEditing = emojiTableView.isEditing
        emojiTableView.setEditing(!isEditing, animated: true)
    }
    
    // Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emoji.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as? EmojiTableViewCell {
            
            let currentEmoji = emoji[indexPath.row]
            cell.currentEmoji = currentEmoji
            cell.showsReorderControl = true
            
            return cell
            
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath)
        }
        
    }
    
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            emoji.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        } else if editingStyle == .insert {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedEmoji = emoji.remove(at: sourceIndexPath.row)
        emoji.insert(movedEmoji, at: destinationIndexPath.row)
        
    }
    

}
