//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//

import UIKit

class ViewController: UIViewController {
    
    let boutTime: Facts
    
    required init?(coder aDecoder: NSCoder) {
        do {
            //convert plist to ditionary
            let dictionary = try PlistConverter.dictionary(fromFile: "Data", ofType: "plist")
            let list = try FactListUnarchiver.factList(fromDictionary: dictionary)
            self.boutTime = BoutTime(factList: list)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(boutTime.factList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

