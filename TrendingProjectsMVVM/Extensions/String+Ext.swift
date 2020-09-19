//
//  String+Ext.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/19/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

extension String {
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.plain],
            documentAttributes: nil) else { return nil }
        return html
    }
}
