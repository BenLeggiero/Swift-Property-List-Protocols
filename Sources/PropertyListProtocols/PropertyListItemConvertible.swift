//
//  PropertyListItemConvertible.swift
//  Property List Protocols
//
//  Created by Ben Leggiero on 2019-09-25
//  Copyright © 2019 Ben Leggiero BH-1-PS
//

import Foundation



/// Anything which can be converted into a property list item
public protocol PropertyListItemConvertible {
    var propertyListItemValue: PropertyListItem { get }
}



/// Anything which can be converted into a root property list item
public protocol RootPropertyListItemConvertible {
    var rootPropertyListItemValue: RootPropertyListItem { get }
}



// MARK: - Synthesis

public extension RootPropertyListItemConvertible {
    var propertyListItemValue: PropertyListItem { rootPropertyListItemValue }
}



// MARK: - Autoconformance

public extension BinaryInteger where Self: PropertyListItemConvertible {
    var propertyListItemValue: PropertyListItem { NSNumber(integerLiteral: .init(self)) }
}
extension UInt: PropertyListItemConvertible {}
extension UInt8: PropertyListItemConvertible {}
extension UInt16: PropertyListItemConvertible {}
extension UInt32: PropertyListItemConvertible {}
extension UInt64: PropertyListItemConvertible {}
extension Int: PropertyListItemConvertible {}
extension Int8: PropertyListItemConvertible {}
extension Int16: PropertyListItemConvertible {}
extension Int32: PropertyListItemConvertible {}
extension Int64: PropertyListItemConvertible {}



public extension BinaryFloatingPoint where Self: PropertyListItemConvertible {
    var propertyListItemValue: PropertyListItem { NSNumber(floatLiteral: .init(self)) }
}
extension Float32: PropertyListItemConvertible {}
extension Float64: PropertyListItemConvertible {}
extension Float80: PropertyListItemConvertible {}
extension CGFloat: PropertyListItemConvertible {}



public extension StringProtocol where Self: PropertyListItemConvertible {
    var propertyListItemValue: PropertyListItem { self.description as NSString }
}
extension String: PropertyListItemConvertible {}



extension Array: PropertyListItemConvertible where Element: PropertyListItemConvertible {
    public var propertyListItemValue: PropertyListItem {
        return map { $0.propertyListItemValue } as NSArray
    }
}

extension Dictionary: RootPropertyListItemConvertible where Key == String, Value: PropertyListItemConvertible {
    public var rootPropertyListItemValue: RootPropertyListItem {
        return Dictionary<Key, PropertyListItem>(uniqueKeysWithValues: map { ($0, $1.propertyListItemValue) } ) as NSDictionary
    }
}
