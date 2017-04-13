//
//  RSS.swift
//  AcoustiCastr
//
//  Created by David Porter on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit


typealias RSSCompletionHandler = ([Episode]?) -> Void

class RSS: XMLParser {
    private var parser = XMLParser()
    internal var element : String = ""
    internal var textNode : String = ""
    internal var episodeDictionary = [String : String]()
    internal var episodes = [Episode]()
    var rssFeed = ""
    
    static let shared = RSS()
    var descriptionCount = 0
    private func beginParsing() {
        print("Inside of beginParsing: \(self.rssFeed)")
        guard let url = URL(string: rssFeed) else {
            print("This does not work.")
            return; }
        self.episodeDictionary = [String : String]()
        guard let parser = XMLParser(contentsOf: url) else {
            print("Inside of parser:")
            return;}
        self.episodes = [Episode]()
        self.parser = parser
        self.parser.delegate = self
        self.parser.parse()
    }
    
    
    func getEpisodes(completion: @escaping RSSCompletionHandler){
        self.beginParsing()
        func returnToMain(results: [Episode]?){
            OperationQueue.main.addOperation {
                completion(results)
            }
        }
        returnToMain(results: self.episodes)
    }
    
}
//MARK: RSS conforms to XMLParserDelegate
extension RSS: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.element = elementName
        if elementName == "enclosure" {
            guard let url = attributeDict["url"] else { print("Failed to unwrap url."); return }
            self.episodeDictionary["audiolink"] = url
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "description" {
            if self.descriptionCount == 0 {
            self.episodeDictionary["podDescription"] = self.textNode
            }
        }
        if elementName == "item" {
        let episode = Episode(episode: self.episodeDictionary)
            self.episodes.append(episode)
        }
        
        if elementName == "title" {
            self.episodeDictionary["title"] = self.textNode
        }
        
        if elementName == "itunes:subtitle" {
            self.episodeDictionary["summary"] = self.textNode
        }
        
        if elementName == "itunes:duration" {
            self.episodeDictionary["duration"] = self.textNode
        }
        if elementName == "pubDate" {
            self.episodeDictionary["pubDate"] = self.textNode
        }

        print("Number of description: \(self.descriptionCount)")
        
        self.textNode = ""
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if self.element == "title" {
            self.textNode += data
        } else if self.element == "itunes:subtitle" {
            self.textNode += data
        } else if self.element == "itunes:duration" {
            self.textNode += data
        } else if self.element == "pubDate" {
            self.textNode += data
        } else if self.element == "description"{
            if self.descriptionCount == 0 {
            self.textNode += data
            }
        self.descriptionCount += 1
        }


    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if let data = String(data: CDATABlock, encoding: .utf8)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines){
            if self.element == "itunes:subtitle"{
                self.textNode += data
            } else if self.element == "description"{
                self.textNode += data
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser){
    }
    

}


