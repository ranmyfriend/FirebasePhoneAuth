//
//  Country.swift
//
//  Created by Ranjith Kumar on 9/2/17
//  Copyright (c) . All rights reserved.
//

import Foundation

fileprivate let baseScalar: UInt32 = 127397

struct Country: Decodable {
    let e164cc: String
    let iso2cc: String
    let e164sc: Int
    let geographic: Bool
    let level: Int
    let name: String
    let example: String
    let displayName: String
    let fullExampleWithPlusSign: String?
    let displayNameNoE164Cc: String
    let e164Key: String
}

extension Country {
    enum CodingKeys: String, CodingKey {
        case e164cc = "e164_cc"
        case iso2cc = "iso2_cc"
        case e164sc = "e164_sc"
        case geographic
        case level
        case name
        case example
        case displayName = "display_name"
        case fullExampleWithPlusSign = "full_example_with_plus_sign"
        case displayNameNoE164Cc = "display_name_no_e164_cc"
        case e164Key = "e164_key"
    }
}


extension Country {
    var flag: String {
        return iso2cc.unicodeScalars.compactMap {
            String(UnicodeScalar(baseScalar + $0.value) ?? UnicodeScalar(0))
        }.joined()
    }
}


