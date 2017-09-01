//
//  Country.swift
//
//  Created by Ranjith Kumar on 9/2/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

fileprivate let baseScalar: UInt32 = 127397

public struct Country {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kCountryNameKey: String = "name"
  private let kCountryE164CcKey: String = "e164_cc"
  private let kCountryGeographicKey: String = "geographic"
  private let kCountryDisplayNameKey: String = "display_name"
  private let kCountryE164ScKey: String = "e164_sc"
  private let kCountryIso2CcKey: String = "iso2_cc"
  private let kCountryE164KeyKey: String = "e164_key"
  private let kCountryLevelKey: String = "level"
  private let kCountryExampleKey: String = "example"
  private let kCountryDisplayNameNoE164CcKey: String = "display_name_no_e164_cc"
  private let kCountryFullExampleWithPlusSignKey: String = "full_example_with_plus_sign"

  // MARK: Properties
  public var name: String?
  public var e164Cc: String?
  public var geographic: Bool = false
  public var displayName: String?
  public var e164Sc: Int?
  public var iso2Cc: String?
  public var e164Key: String?
  public var level: Int?
  public var example: String?
  public var displayNameNoE164Cc: String?
  public var fullExampleWithPlusSign: String?
    public var flag: String?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    name = json[kCountryNameKey].string
    e164Cc = json[kCountryE164CcKey].string
    geographic = json[kCountryGeographicKey].boolValue
    displayName = json[kCountryDisplayNameKey].string
    e164Sc = json[kCountryE164ScKey].int
    iso2Cc = json[kCountryIso2CcKey].string
    e164Key = json[kCountryE164KeyKey].string
    level = json[kCountryLevelKey].int
    example = json[kCountryExampleKey].string
    displayNameNoE164Cc = json[kCountryDisplayNameNoE164CcKey].string
    fullExampleWithPlusSign = json[kCountryFullExampleWithPlusSignKey].string
    flag = iso2Cc?.unicodeScalars.flatMap { String.init(UnicodeScalar(baseScalar + $0.value)!) }.joined()
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[kCountryNameKey] = value }
    if let value = e164Cc { dictionary[kCountryE164CcKey] = value }
    dictionary[kCountryGeographicKey] = geographic
    if let value = displayName { dictionary[kCountryDisplayNameKey] = value }
    if let value = e164Sc { dictionary[kCountryE164ScKey] = value }
    if let value = iso2Cc { dictionary[kCountryIso2CcKey] = value }
    if let value = e164Key { dictionary[kCountryE164KeyKey] = value }
    if let value = level { dictionary[kCountryLevelKey] = value }
    if let value = example { dictionary[kCountryExampleKey] = value }
    if let value = displayNameNoE164Cc { dictionary[kCountryDisplayNameNoE164CcKey] = value }
    if let value = fullExampleWithPlusSign { dictionary[kCountryFullExampleWithPlusSignKey] = value }
    return dictionary
  }

}
