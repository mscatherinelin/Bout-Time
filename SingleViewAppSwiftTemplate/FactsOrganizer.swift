//
//  FactsOrganizer.swift
//  Bout Time
//
//  Created by Catherine Lin on 1/5/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit
import GameKit

//enum for all the countries involved in the olympics
enum CountrySelection: String {
    case London
    case Vancouver
    case Athens
    case Stockholm
    case Antwerp
    case Berlin
    case Chamonix
    case LakePlacid
    case LosAngeles
    case Calgary
    case Amsterdam
    case Montreal
    case Sapporo
    case Munich
    case Moscow
    case Sarajevo
    case Barcelona
    case Lillehammer
    case Atlanta
    case Nagano
    case Sydney
    case Turin
    case Beijing
    case Sochi
    case Rio
    
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
    let selection: [CountrySelection] = [.Athens, .London, .Vancouver, .Stockholm, .Berlin, .Antwerp, .Chamonix, .Amsterdam, .LakePlacid, .LosAngeles, .Calgary, .Montreal, .Sapporo, .Munich, .Moscow, .Sarajevo, .Barcelona, .Lillehammer, .Atlanta, .Nagano, .Sydney, .Turin, .Beijing, .Sochi, .Rio]
    let factList: [CountrySelection : OlympicEvent]
    
    required init(factList: [CountrySelection: OlympicEvent]){
        self.factList = factList
    }
    
    //generate random event
    func randomEvent() throws -> Dictionary<CountrySelection, OlympicEvent> {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: factList.count)
        let countrySelection = selection[randomNumber]
        guard let event = factList[countrySelection] else {
            throw FactListError.invalidSelection
        }
        return [countrySelection: event]
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





















