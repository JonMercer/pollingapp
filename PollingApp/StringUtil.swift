//
//  CleanTextUtil.swift
//  PollingApp
//
//  Created by Sherry Yuan on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class StringUtil {
  
  static func cleanNameText(name: String) -> String {
    let strippedString = String(
      name.characters.filter {okayNameCharacters.contains($0)})
    let trimmedString = strippedString.stringByTrimmingCharactersInSet(
      NSCharacterSet.whitespaceCharacterSet())
    return trimmedString
  }
  
  static func cleanText(name: String) -> String {
    var strippedString = name.stringByReplacingOccurrencesOfString("\(charactersToAvoid[0])", withString: "")
    for index in 0...(charactersToAvoid.count - 1) {
      strippedString = strippedString.stringByReplacingOccurrencesOfString("\(charactersToAvoid[index])", withString: "")
    }
    let trimmedString = strippedString.stringByTrimmingCharactersInSet(
      NSCharacterSet.whitespaceCharacterSet())
    return trimmedString
  }
}