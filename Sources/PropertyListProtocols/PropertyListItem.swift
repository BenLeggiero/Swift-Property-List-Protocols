//
//  PropertyListItem.swift
//  Property List Protocols
//
//  Created by Ben Leggiero on 2019-09-25
//  Copyright © 2019 Ben Leggiero BH-1-PS
//

import Foundation



/// A marker protocol applied to items which can be put into a property list
public protocol PropertyListItem: PropertyListItemConvertible {}



// MARK: - Synthesis

public extension PropertyListItem {
    var propertyListItemValue: PropertyListItem { self }
}



// MARK: - Autoconformance

extension NSNumber: PropertyListItem {}
extension NSString: PropertyListItem {}
extension NSArray: PropertyListItem {}
extension NSDictionary: PropertyListItem {}

extension CFNumber: PropertyListItem {}
extension CFString: PropertyListItem {}
extension CFArray: PropertyListItem {}
extension CFDictionary: PropertyListItem {}
