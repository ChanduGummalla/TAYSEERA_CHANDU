//
//  CountryModel.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import Foundation

struct CoutryModel:Codable {
    var payload:Payload?
}

struct Payload:Codable {
    var result:[CountryResults]?
}
struct CountryResults:Codable {
    var countryId: Int?
    var countryName: String?
    var countryCode: String?
    var sendingCountryCallingCode: String?
    var flagUrl: String?
    var mobileMinLength: Int?
    var mobileMaxLength: Int?
   var isSelect: Bool?
    var currencies:[Currencies]?
    var payingCountries:[PayingCountries]?
}

struct Currencies: Codable {
    var currencyId: Int?
    var currencyCode: String?
    var exchangeRateUsd: Double?
    var displayOrder: Int?
}

struct PayingCountries: Codable {
    var countryId: Int?
    var countryName: String?
    var countryCode: String?
    var sendingCountryCallingCode: String?
    var flagUrl: String?
    var mobileMinLength: Int?
    var mobileMaxLength: Int?
   var isSelect: Bool?
}
