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
    var author : String = ""
    var podDescription : String = ""
    var pubDate : String = ""



    func beginParsing() {
        guard let url = URL(string: "https://wtfpod.libsyn.com/rss") else {
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
                
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if self.element == "itunes:author" {
            print("self.textNode: \(self.textNode)")
            self.author = self.textNode
        }
        if self.element == "item" {
            if self.element == "description" {
                self.podDescription = self.textNode
            }
            
        }
        if self.element == "pubDate" {
            self.pubDate = self.textNode
        }
        self.textNode = ""
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        if self.element == "title" {
//            self.textNode += string
//        }
//        if self.element == "description" {
//            self.textNode += string
//        }
//        if self.element == "pubDate" {
//            self.textNode += string
//        }
//        if self.element == "author" {
//            self.textNode += string
//        }
        self.textNode += string
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("author: \(self.author)")
        print("podDescription: \(self.podDescription)")
        print("pubDate: \(self.pubDate)")
        
        
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if let podDescription = String(data: CDATABlock, encoding: .utf8) {
            self.podDescription = podDescription
        }
    }
}


