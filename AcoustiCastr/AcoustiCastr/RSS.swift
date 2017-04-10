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
        if self.element == "title" {
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.element == "title" {
            self.textNode += string
        }
        print(self.textNode)
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("For nothing")
    }
}
