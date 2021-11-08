//
//  StringExtensions.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 03.11.2021.
//

import Foundation

extension String {
    func decodeFromHTML() -> String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)
        
        return attr?.string ?? self
    }
}
