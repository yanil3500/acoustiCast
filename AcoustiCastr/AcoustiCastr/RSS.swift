//
//  RSS.swift
//  AcoustiCastr
//
//  Created by David Porter on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class RSS: XMLParser {
    var parser: XMLParser? = nil
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
        self.parser?.delegate = self
        self.parser?.parse()
    }
}

extension RSS: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.element = elementName
        if self.element == "enclosure" {
            if let link = attributeDict["url"] {
                print("url \(link)")
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "author" {
            print("self.textNode: \(self.textNode)")
            self.author = self.textNode
        }
        if elementName == "description" {
            self.podDescription = self.textNode
        }
        if elementName == "pubDate" {
            self.pubDate = self.textNode
        }
        self.textNode = ""
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.element == "title" {
            self.textNode += string
        }
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("For nothing")
    }
}

