//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    
    var eventsAlreadyDisplayed: [CountrySelection] = []
    let boutTime: Facts
    @IBOutlet weak var event1: UILabel!
    @IBOutlet weak var event2: UILabel!
    @IBOutlet weak var event3: UILabel!
    @IBOutlet weak var event4: UILabel!
    lazy var events: [UILabel] = [self.event1, self.event2, self.event3, self.event4]
    
    
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
        showEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: dismissAlert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //FIXME: fix dismiss alert
    func dismissAlert(sender: UIAlertAction) -> Void {
        print("Error")
    }
    
    func showEvents() {
        for index in 0...3 {
            do {
                let randomEvent =  try boutTime.randomEvent()
                events[index].text = randomEvent.first?.key.rawValue
                
            } catch {
                showAlert(title: "No event available", message: "There are no events available", style: .alert)
            }
            
            
        }
    }
    
    


}

