//
//  CountryData+CoreDataProperties.swift
//  
//
//  Created by HTS Macbook Air on 07/04/23.
//
//

import Foundation
import CoreData


extension CountryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryData> {
        return NSFetchRequest<CountryData>(entityName: "CountryData")
    }

    @NSManaged public var sendingCountry: String?
    @NSManaged public var payingCountry: String?
    @NSManaged public var amountToSend: String?
    @NSManaged public var amountToReceiver: String?
    @NSManaged public var purpose: String?

}
