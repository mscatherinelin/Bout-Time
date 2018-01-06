//
//  FactsOrganizer.swift
//  Bout Time
//
//  Created by Catherine Lin on 1/5/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit

//enum for all the countries involved in the olympics
enum CountrySelection: String {
    case LA
    case Paris
    case Tokyo
    case Pyeongchang
    case Rio
    case Sochi
    case London
    case Vancouver
    case Beijing
    case Turin
    case Athens
    case SaltLakeCity
    case Sydney
    case Nagano
    case Atlanta
    case Lillehammer
    case Barcelona
    case Seoul
    case Sarajevo
    case Moscow
    case Calgary
    case LosAngeles
    case Capetown
    case Albertville
    case LakePlacid
}

protocol OlympicEvent {
    var year: Int { get }
}

protocol Facts {
    //selection of countries
    var selection: [CountrySelection] { get }
    var factList: [CountrySelection: OlympicEvent] { get }
    init(factList: [CountrySelection: OlympicEvent])
    
}
struct Event: OlympicEvent {
    let year: Int
}

class BoutTime: Facts {
    let selection: [CountrySelection] = [.Albertville, .Athens, .Atlanta, .Barcelona, .Beijing, .Calgary, .Capetown, .LA, .Lillehammer, .London, .LosAngeles, .Moscow, .Nagano, .Pyeongchang, .Paris, .Rio, .SaltLakeCity, .Sarajevo, .Seoul, .Sochi, .Sydney, .Tokyo, .Vancouver, .Turin, .LakePlacid]
    let factList: [CountrySelection : OlympicEvent]
    
    required init(factList: [CountrySelection: OlympicEvent]){
        self.factList = factList
    }
}

enum FactListError: Error {
    case invalidResource
    case conversionFailure
    case invalidSelection
}
class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw FactListError.invalidResource
        }
        
        //retrive contents of file and convert into a dictionary
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            throw FactListError.conversionFailure
        }
        return dictionary
    }
}

class FactListUnarchiver {
    static func factList(fromDictionary dictionary: [String: AnyObject]) throws -> [CountrySelection: OlympicEvent] {
        var list: [CountrySelection: OlympicEvent] = [:]
        
        for (key, value) in dictionary {
            //convert the value (AnyObject) into an integer
            if let date = value as? Int {
                let event = Event(year: date)
                //convert the string key to one of the country selection enums
                guard let selection = CountrySelection(rawValue: key) else {
                    throw FactListError.invalidSelection
                }
                list.updateValue(event, forKey: selection)
            }
        }
        
        return list
    }
}





















