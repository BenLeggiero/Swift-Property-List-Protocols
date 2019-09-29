//
//  PropertyListKey.swift
//  Property List Protocols
//
//  Created by Ben Leggiero on 2019-09-28
//  Copyright © 2019 Ben Leggiero BH-1-PS
//

import Foundation



/// A marker protocol applied to items which can be used as keys in a property list
///
/// - Attention: Don't make types conform to this! Instead, conform to `PropertyListKeyConvertible`
public protocol PropertyListKey: class, PropertyListKeyConvertible {
}



// MARK: - Synthesis

public extension PropertyListKey {
    var propertyListKeyValue: PropertyListKey { self }
}



// MARK: - Autoconformance

extension NSString: PropertyListKey {}
extension CFString: PropertyListKey {}
