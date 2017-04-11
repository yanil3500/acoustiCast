//
//  RSS.swift
//  AcoustiCastr
//
//  Created by David Porter on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class RSS: XMLParser {
    var parser = XMLParser()
    var element : String = ""
    var textNode : String = ""
    var audiolink : String = ""
    var episodeDictionary : [String : String] = [:]
    var episodes = [Episode]()

    func beginParsing(url: String) {
        print("begin parsing: \(url)")
        guard let url = URL(string: url) else {
            return
        }
        guard let parserInst = XMLParser(contentsOf: url) else {
            return
        }
        self.episodeDictionary = [String : String]()
        self.parser = parserInst
        self.parser.delegate = self
        self.parser.parse()
    }
}

extension RSS: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.element = elementName
        
        if elementName == "item" {
            
        }
        
        if elementName == "enclosure" {
            guard let url = attributeDict["url"] else { print("Failed to unwrap url."); return }
            self.episodeDictionary["audiolink"] = url
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
        let episode = Episode(episode: self.episodeDictionary)
        }
        
        if elementName == "title" {
            self.episodeDictionary["title"] = self.textNode
        }
        
        if elementName == "itunes:summary" {
            self.episodeDictionary["summary"] = self.textNode
        }
        
        if elementName == "itunes:duration" {
            self.episodeDictionary["duration"] = self.textNode
        }
        if elementName == "pubDate" {
            self.episodeDictionary["pubDate"] = self.textNode
        }
        
        
        
        self.textNode = ""
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if self.element == "title" {
            self.textNode += data
        } else if self.element == "itunes:summary" {
            self.textNode += data
        } else if self.element == "itunes:duration" {
            self.textNode += data
        } else if self.element == "pubDate" {
            self.textNode += data
        }


    }
    
    func parserDidEndDocument(_ parser: XMLParser) {

    }
    

}


