//
//  XMLParser.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 11.11.2024.
//

import Foundation

protocol RSSNewsParserProtocol {
    func parse(data: Data) -> [NewsRestModel]
}

extension RSSNewsParser {
    enum Constants {
        static let maxItems = 30
    }
}

final class RSSNewsParser: NSObject, XMLParserDelegate, RSSNewsParserProtocol {
    private var items: [NewsRestModel] = []
    private var currentItem: NewsRestModel?
    private var currentElement = ""
    private var currentValue: String = ""
    private var data: Data?

    func parse(data: Data) -> [NewsRestModel] {
        self.data = data
        parse()
        return items
    }

    func parse() {
        guard let data else { return }
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            currentElement = elementName
            if elementName == "item" {
                currentItem = NewsRestModel(id: UUID(), descriptionNews: "", source: "", title: "", link: "", pubDate: "", imageURL: nil, isRead: false)
            }

        if elementName == "media:content" || elementName == "media:thumbnail" || elementName == "enclosure" || elementName == "image" {
                if let url = attributeDict["url"] {
                    currentItem?.imageURL = url
                }
            }
        }

        func parser(_ parser: XMLParser, foundCharacters string: String) {
            currentValue += string
        }

        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

            if elementName == "title" {
                currentItem?.title = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)
            } else if elementName == "link" {
                currentItem?.link = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)
            } else if elementName == "description" {
                currentItem?.descriptionNews = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)
            } else if elementName == "pubDate" {
                currentItem?.pubDate = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)
            } else if elementName == "item", let newItem = currentItem {
                items.append(newItem)
                self.currentItem = nil
                if items.count >= Constants.maxItems {
                    parser.abortParsing()
                }
            }

            currentValue = ""
        }
}
