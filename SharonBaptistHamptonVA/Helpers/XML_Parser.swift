//
//  XML_Parser.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 4/20/21.
//

import Foundation
import UIKit

struct RSSItem {
    var title: String
    var description: String
    var audioUrl: String
}

// Download xml from server
// Parse xml to foundation objects
// Call back

class FeedParser: NSObject, XMLParserDelegate {
    
    private var rssItems: [RSSItem] = []
    private var currentElement = ""
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription: String = "" {
        didSet{
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentAudioUrl = ""
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?) {
        
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            
            // Parse xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            print(self.currentAudioUrl)
        }
        
        task.resume()
    }
    
    // MARK:- XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        switch elementName {
        case "item":
                currentTitle = ""
                currentDescription = ""
        case "enclosure":
            if let urlString = attributeDict["url"] {
                print(urlString)
                currentAudioUrl = "" 
                currentAudioUrl += urlString
            } else {
                print("enclosure without url attribute")
            }
        default: break
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, audioUrl: currentAudioUrl)
            self.rssItems.append(rssItem)
            
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
