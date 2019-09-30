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
    
    /// Converts this value into a property list item
    func propertyListKeyValue() -> PropertyListKey
}



// MARK: - Autoconformance



public extension StringProtocol where Self: PropertyListKeyConvertible {
    func propertyListKeyValue() -> PropertyListKey { self.description as NSString }
}
extension String: PropertyListKeyConvertible {}
