//
//  WALocationVC.swift
//  Weathalert
//
//  Created by Scott Browne on 09/02/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import Foundation
import UIKit

class WALocationVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var currentLoc: WALocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let temp = currentLoc.forecasts![0].tempHigh else { return }
        let tempString = String(temp)
        tempLabel.text = tempString+"°F"
        
        iconImageView.image = UIImage(named: currentLoc.forecasts![0].icon+".png")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (appDelegate.profile.profileLocations[0].forecasts?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! WAForecastCell
        
        let forecastObject = currentLoc.forecasts![indexPath.item]
        cell.cellImage.image = UIImage(named: forecastObject.icon+".png")
        cell.dayLabel.text = appDelegate.getWeekday(timestamp: forecastObject.time)
        
        cell.layer.cornerRadius = (cell.frame.width / 8)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentLoc.alerts?.count == nil {
            return 0
        } else {
            return (currentLoc.alerts?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath) as! WAAlertCell
        cell.alertLabel.text = "Alert "+String(indexPath.row+1)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.currAlertNum = indexPath.row
        performSegue(withIdentifier: "AlertViewSegue", sender: self)
    }

    @IBAction func newAlert(_ sender: Any) {
        appDelegate.currAlertNum = nil
        performSegue(withIdentifier: "AlertViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let alertView = segue.destination as! WAAlertVC
        
        if appDelegate.currAlertNum == nil {
            alertView.isNew = true
        } else {
            alertView.isNew = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
