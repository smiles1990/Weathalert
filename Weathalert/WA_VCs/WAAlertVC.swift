//
//  WAAlertVC.swift
//  Weathalert
//
//  Created by Scott Browne on 13/02/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import Foundation
import UIKit

class WAAlertVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var weatherCollView: UICollectionView!
    @IBOutlet weak var dayCollView: UICollectionView!
    @IBOutlet weak var daysNoticeLabel: UILabel!
    @IBOutlet weak var daysNoticeStepper: UIStepper!
    
    var isNew = Bool()
    let daysArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let weatherTypes = ["clear-day", "clear-night", "cloudy", "fog",
                        "partly-cloudy-day", "partly-cloudy-night", "rain",
                        "sleet", "snow", "thunderstorm", "tornado", "wind"]
    

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedWeather = [String]()
    var selectedDays = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var alertsArray = appDelegate.profile.profileLocations[appDelegate.currLocNum].alerts
        
        if isNew == false {
            let currentAlert = alertsArray?[appDelegate.currAlertNum]
            selectedWeather = (currentAlert?.weatherOfNote)!
            selectedDays = (currentAlert?.daysOfInterest)!
            daysNoticeStepper.value = Double((currentAlert?.daysNotice)!)
            daysNoticeLabel.text = String((currentAlert?.daysNotice)!)
        }
        
        weatherCollView.reloadData()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let alert = WAAlert(weatherOfNote: selectedWeather, daysOfInterest: selectedDays, daysNotice: Int(daysNoticeStepper.value))
        
        if isNew == true {
            if appDelegate.profile.profileLocations[appDelegate.currLocNum].alerts?.count == nil {
                appDelegate.profile.profileLocations[appDelegate.currLocNum].alerts = [alert]
            } else {
                appDelegate.profile.profileLocations[appDelegate.currLocNum].alerts?.append(alert)
            }
            
        } else if isNew == false {
            appDelegate.profile.profileLocations[appDelegate.currLocNum].alerts?.remove(at: appDelegate.currAlertNum)
            appDelegate.profile.profileLocations[appDelegate.currLocNum].alerts?.insert(alert, at: appDelegate.currAlertNum)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func daysNoticeChanged(_ sender: Any) {
    
        daysNoticeLabel.text = String(Int(daysNoticeStepper.value))
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == weatherCollView { count = weatherTypes.count }
        if collectionView == dayCollView { count = 7 }
        return count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == weatherCollView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherTypeCell", for: indexPath) as! WAAlertViewCell
            cell.cellImage.image = UIImage(named: weatherTypes[indexPath.item]+".png")
            if selectedWeather.contains(weatherTypes[indexPath.item]) != true {
                    cell.alpha = 0.4
            }
            
            return cell
            
        } else { //if collectionView == dayCollView
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! WAAlertViewCell
            cell.layer.cornerRadius = 10
            cell.dayLabel.text = daysArray[indexPath.item]
            if selectedDays.contains(indexPath.item) != true {
                cell.alpha = 0.4
            }
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == weatherCollView {
            
            if selectedWeather.contains(weatherTypes[indexPath.item]) == false {
                selectedWeather.append(weatherTypes[indexPath.item])
                collectionView.cellForItem(at: indexPath)?.alpha = 1.0
            } else {
                let index = selectedWeather.index(of: weatherTypes[indexPath.item])
                selectedWeather.remove(at: index!)
                collectionView.cellForItem(at: indexPath)?.alpha = 0.4
            }
            
        } else {
            
            if selectedDays.contains(indexPath.item) == false {
                selectedDays.append(indexPath.item)
                collectionView.cellForItem(at: indexPath)?.alpha = 1.0
            } else {
                let index = selectedDays.index(of: indexPath.item)
                selectedDays.remove(at: index!)
                collectionView.cellForItem(at: indexPath)?.alpha = 0.4
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
