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
    var podDescription : String = ""
    var pubDate : String = ""
    var duration : String = ""
    var audioLink : String = ""
    var title : String = ""

    var episodes = [Episode]()

    func beginParsing(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        guard let parserInst = XMLParser(contentsOf: url) else {
            return
        }
        self.parser = parserInst
        self.parser.delegate = self
        self.parser.parse()
    }
}

extension RSS: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.element = elementName
        if self.element == "enclosure" {
            if let link = attributeDict["url"] {
                self.audioLink = link
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if self.element == "item" {
            if self.element == "description" {
                self.podDescription = self.textNode
            }
            
        }
        if self.element == "pubDate" {
            self.pubDate = self.textNode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        if self.element == "itunes:duration" {
            self.duration = self.textNode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        if self.element == "title" {
            self.title = self.textNode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        let episode = Episode(title: self.title, description: self.podDescription, podcastAudio: self.audioLink, duration: self.duration, pubDate: self.pubDate)
        self.episodes.append(episode)
        
        self.textNode = ""
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {

        self.textNode += string
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("podDescription: \(self.podDescription)")
        print("pubDate: \(self.pubDate)")
        print("podcastLink: \(self.audioLink)")
        print("duration: \(self.duration)")
        print("title: \(self.title)")
        
        
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if let podDescription = String(data: CDATABlock, encoding: .utf8) {
            self.podDescription = podDescription
        }
    }
}


