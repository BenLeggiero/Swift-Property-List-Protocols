//
//  PropertyListKeyConvertible.swift
//  Property List Protocols
//
//  Created by Ben Leggiero on 2019-09-28
//  Copyright © 2019 Ben Leggiero BH-1-PS
//

import Foundation



/// Anything which can be converted into a property list key
public protocol PropertyListKeyConvertible {
    var propertyListKeyValue: PropertyListKey { get }
}



// MARK: - Autoconformance



public extension StringProtocol where Self: PropertyListKeyConvertible {
    var propertyListKeyValue: PropertyListKey { self.description as NSString }
}
extension String: PropertyListKeyConvertible {}
