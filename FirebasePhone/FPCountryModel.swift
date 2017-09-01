//
//  FPCountryModel.swift
//
//  Created by Ranjith Kumar on 9/1/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class FPCountryModel {
    fileprivate let base: UInt32 = 127397

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kFPCountryModelNameKey: String = "name"
  private let kFPCountryModelE164CcKey: String = "e164_cc"
  private let kFPCountryModelGeographicKey: String = "geographic"
  private let kFPCountryModelDisplayNameKey: String = "display_name"
  private let kFPCountryModelE164ScKey: String = "e164_sc"
  private let kFPCountryModelIso2CcKey: String = "iso2_cc"
  private let kFPCountryModelE164KeyKey: String = "e164_key"
  private let kFPCountryModelLevelKey: String = "level"
  private let kFPCountryModelExampleKey: String = "example"
  private let kFPCountryModelDisplayNameNoE164CcKey: String = "display_name_no_e164_cc"
  private let kFPCountryModelFullExampleWithPlusSignKey: String = "full_example_with_plus_sign"

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
  convenience public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    name = json[kFPCountryModelNameKey].string
    e164Cc = json[kFPCountryModelE164CcKey].string
    geographic = json[kFPCountryModelGeographicKey].boolValue
    displayName = json[kFPCountryModelDisplayNameKey].string
    e164Sc = json[kFPCountryModelE164ScKey].int
    iso2Cc = json[kFPCountryModelIso2CcKey].string
    e164Key = json[kFPCountryModelE164KeyKey].string
    level = json[kFPCountryModelLevelKey].int
    example = json[kFPCountryModelExampleKey].string
    displayNameNoE164Cc = json[kFPCountryModelDisplayNameNoE164CcKey].string
    fullExampleWithPlusSign = json[kFPCountryModelFullExampleWithPlusSignKey].string
    flag = iso2Cc?.unicodeScalars.flatMap { String.init(UnicodeScalar(base + $0.value)!) }.joined()
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[kFPCountryModelNameKey] = value }
    if let value = e164Cc { dictionary[kFPCountryModelE164CcKey] = value }
    dictionary[kFPCountryModelGeographicKey] = geographic
    if let value = displayName { dictionary[kFPCountryModelDisplayNameKey] = value }
    if let value = e164Sc { dictionary[kFPCountryModelE164ScKey] = value }
    if let value = iso2Cc { dictionary[kFPCountryModelIso2CcKey] = value }
    if let value = e164Key { dictionary[kFPCountryModelE164KeyKey] = value }
    if let value = level { dictionary[kFPCountryModelLevelKey] = value }
    if let value = example { dictionary[kFPCountryModelExampleKey] = value }
    if let value = displayNameNoE164Cc { dictionary[kFPCountryModelDisplayNameNoE164CcKey] = value }
    if let value = fullExampleWithPlusSign { dictionary[kFPCountryModelFullExampleWithPlusSignKey] = value }
    return dictionary
  }

}
