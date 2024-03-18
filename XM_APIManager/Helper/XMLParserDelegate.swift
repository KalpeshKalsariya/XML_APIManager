//
//  XMLParserDelegate.swift
//  XM_APIManager
//
//  Created by  Kalpesh on 18/03/24.
//

import Foundation
import UIKit

// Parsing delegate method
class XMLParserDelegateKK: NSObject, XMLParserDelegate {
    var currentElement: String = ""
    var parsedData: [String: String] = [:]

    // Called when the parser encounters a new element
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // Implement your logic to handle different XML elements here
        print("Element found: \(elementName)")
        currentElement = elementName
    }

    // Called when the parser encounters characters within an element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // Implement your logic to handle character data here
        print("Found characters: \(string)")
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if !value.isEmpty {
            parsedData[currentElement] = value
        }
    }

    // Called when the parser finishes parsing
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Parsing finished")
    }

    // Called when the parser encounters an error
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Error parsing XML: \(parseError.localizedDescription)")
    }
}

