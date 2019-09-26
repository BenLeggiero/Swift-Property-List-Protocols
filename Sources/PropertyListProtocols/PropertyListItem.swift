//
//  PropertyListItem.swift
//  Property List Protocols
//
//  Created by Ben Leggiero on 2019-09-25
//  Copyright © 2019 Ben Leggiero BH-1-PS
//

import Foundation



/// A marker protocol applied to items which can be put into a property list
///
/// - Attention: Don't make types conform to this! Instead, conform to `PropertyListItemConvertible`
public protocol PropertyListItem: PropertyListItemConvertible {
    
}



/// A marker protocol applied to items which can be used as the root of a property list
///
/// - Attention: Don't make types conform to this! Instead, conform to `PropertyListItemConvertible`
public protocol RootPropertyListItem: PropertyListItem {}



// MARK: - Synthesis

public extension PropertyListItem {
    var propertyListItemValue: PropertyListItem { self }
}



// MARK: - Autoconformance

extension NSNumber: PropertyListItem {}
extension NSString: PropertyListItem {}
extension NSDate: PropertyListItem {}
extension NSData: PropertyListItem {}
extension NSArray: PropertyListItem {}
extension NSDictionary: RootPropertyListItem {}

extension CFNumber: PropertyListItem {}
extension CFBoolean: PropertyListItem {}
extension CFString: PropertyListItem {}
extension CFDate: PropertyListItem {}
extension CFData: PropertyListItem {}
extension CFArray: PropertyListItem {}
extension CFDictionary: RootPropertyListItem {}
