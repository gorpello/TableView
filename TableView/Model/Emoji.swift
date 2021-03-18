//
//  Emoji.swift
//  TableView
//
//  Created by Gianluca Orpello on 18/03/21.
//

import Foundation

struct Emoji: Codable {
    
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var archiveURL: URL {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentURL.appendingPathComponent("emojis").appendingPathExtension("plist")
        return archiveURL
    }
    
    static func saveToFile(_ emoji: [Emoji]) {
        let encoder = PropertyListEncoder()
        
        do {
            let encodedEmoji = try encoder.encode(emoji)
            try encodedEmoji.write(to: Emoji.archiveURL)
        } catch {
            print("Eroor saving emoji: \(error)")
        }
        
    }
    
    static func readFromFile() -> [Emoji]? {
        guard let emojiData = try? Data(contentsOf: Emoji.archiveURL) else {
            return nil
        }
        
        do {
            let decoder = PropertyListDecoder()
            let decodedEmojis = try decoder.decode([Emoji].self, from: emojiData)
            return decodedEmojis
        } catch {
            print("Error reading form file: \(error)")
            return nil
        }
    }
    
    
    static var sampleEmojis: [Emoji] {
        return [
            Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
            Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
            Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
            Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
            Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
            Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
            Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
            Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
        ]
    }
}
