//
//  PropertyListItemConvertible.swift
//  Property List Protocols
//
//  Created by Ben Leggiero on 2019-09-25.
//  Copyright © 2019 Ben Leggiero BH-1-PS
//

import Foundation



/// Anything which can be converted into a property list item
public protocol PropertyListItemConvertible {
    /// Converts this value into a property list item
    func propertyListItemValue() -> PropertyListItem
}



/// Anything which can be converted into a root property list item
public protocol RootPropertyListItemConvertible {
    
    /// Converts this value into a property list item which can appear at the root of a property list
    ///
    /// - Parameter keyFormatter: _optional_ The formatter to use when converting arbitarary keys to property list keys
    func rootPropertyListItemValue() -> RootPropertyListItem
    
    
    /// Converts this value into a property list item which can appear at the root of a property list
    ///
    /// - Parameter keyFormatter: _optional_ The formatter to use when converting arbitarary keys to property list keys
    func rootPropertyListItemValue(using keyFormatter: PropertyListKeyFormatter) -> RootPropertyListItem
    
    
    
    /// The kind of function which formats a property list key while a Swift dictionary is being converted into a root
    /// property list item
    typealias PropertyListKeyFormatter = (PropertyListKeyConvertible) -> PropertyListKey
}



public extension RootPropertyListItemConvertible {
    func rootPropertyListItemValue() -> RootPropertyListItem {
        rootPropertyListItemValue { convertible in
            convertible.propertyListKeyValue().nsStringValue
        }
    }
}



// MARK: - Synthesis

public extension RootPropertyListItemConvertible {
    
    func propertyListItemValue() -> PropertyListItem {
        rootPropertyListItemValue()
    }
    
    
    func propertyListItemValue(using keyFormatter: PropertyListKeyFormatter) -> PropertyListItem {
        rootPropertyListItemValue(using: keyFormatter)
    }
}



// MARK: - Autoconformance

public extension BinaryInteger where Self: PropertyListItemConvertible {
    func propertyListItemValue() -> PropertyListItem { NSNumber(integerLiteral: .init(self)) }
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



extension Bool: PropertyListItemConvertible {
    public func propertyListItemValue() -> PropertyListItem { self as NSNumber }
}



public extension BinaryFloatingPoint where Self: PropertyListItemConvertible {
    func propertyListItemValue() -> PropertyListItem { NSNumber(floatLiteral: .init(self)) }
}
extension Float32: PropertyListItemConvertible {}
extension Float64: PropertyListItemConvertible {}
extension Float80: PropertyListItemConvertible {}
extension CGFloat: PropertyListItemConvertible {}



public extension StringProtocol where Self: PropertyListItemConvertible {
    func propertyListItemValue() -> PropertyListItem { self.description as NSString }
}
extension String: PropertyListItemConvertible {}



extension Data: PropertyListItemConvertible {
    public func propertyListItemValue() -> PropertyListItem { self as NSData }
}



extension Date: PropertyListItemConvertible {
    public func propertyListItemValue() -> PropertyListItem { self as NSDate }
}



extension Array: PropertyListItemConvertible where Element: PropertyListItemConvertible {
    public func propertyListItemValue() -> PropertyListItem { map { $0.propertyListItemValue() } as NSArray }
}



extension Dictionary: RootPropertyListItemConvertible
where Key: PropertyListKeyConvertible,
    Value: PropertyListItemConvertible
{
    /// Converts this Swift dictionary into a root property list item value.
    ///
    /// Keys are converted using `propertyListKeyValueFormatter` and values are simply their `.propertyListItemValue`.
    /// You may change the value of `propertyListKeyValueFormatter` to modify this behavior, but be aware that this is
    /// a static value, so it's best to change it once at startup and never again.
    public func rootPropertyListItemValue(using formatter: PropertyListKeyFormatter) -> RootPropertyListItem {
        
        [NSString : PropertyListItem](uniqueKeysWithValues:
            map {
                (formatter($0).nsStringValue,
                 $1.propertyListItemValue())
            }
        )
            as NSDictionary
    }
}
