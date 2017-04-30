//
//  TopPodcasts.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/30/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

typealias TopPodcastsCompletionHandler = ([Podcast]) -> Void


class TopPodcasts: XMLParser{
    static let shared = TopPodcasts()
    var url : URL?
    var parser = XMLParser()
    internal var element : String?
    internal var title : String = ""
    internal var summary : String = ""
    internal var podcastName : String = ""
    internal var podcastArt : String = ""
    internal var genre : String?
    internal var dictionary = [String:String]()
    var topPodcasts = [Podcast]()
    
    private func beginParsing(){
        guard let urlFrom = URL(string: "https://itunes.apple.com/us/rss/toppodcasts/limit=100/explicit=true/xml") else { fatalError("Failed to create a valid URL")}
        self.url = urlFrom
        self.parser = XMLParser(contentsOf: urlFrom)!
        self.parser.delegate = self as XMLParserDelegate
        self.parser.parse()
        self.element = ""
    }
    
    func getTopEpisodes(){
        self.beginParsing()
    }
    
}

extension TopPodcasts: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        self.element = elementName
        
        if self.element == "entry" {
            self.title = ""
            self.summary = ""
            self.podcastName = ""
            self.podcastArt = ""
        }
        
        if self.element == "category" {
            guard let genre = attributeDict["label"] else { print("Failed to get genre names."); return }
            self.genre = genre
        }
        if self.element == "im:image"{
            if attributeDict["height"] == "170"{
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.element == "title" {
            self.title += string
        } else if self.element == "im:image"{
            self.podcastArt += string
        } else if self.element == "im:name"{
            self.podcastName += string
        } else if self.element == "summary"{
            self.summary += string
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if self.element == "entry"{
            self.dictionary["artistName"] = self.podcastName
            self.dictionary["collectionName"] = self.title
            self.dictionary["primaryGenreName"] = self.genre
            self.dictionary["feedUrl"] = nil
            self.dictionary["artworkUrl600"] = self.podcastArt
            self.dictionary["summary"] = self.summary
            let podcast = Podcast(json: self.dictionary)
            print("Title: \(podcast.collectionName)")
            print("Name: \(podcast.artistName)")
            print("Genre: \(podcast.genre)")
            print("Summary: \(String(describing: podcast.podcastSummary))")
            print("Podcast Art URL: \(podcast.podcastArtUrl)")
            
            
            self.topPodcasts.append(podcast)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {

    }
    
}

































