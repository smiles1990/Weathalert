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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let temp = appDelegate.profile.profileLocations[0].forecasts![0].tempHigh else { return }
        let tempString = String(temp)
        
        tempLabel.text = tempString+"°C"
        iconImageView.image = UIImage(named: appDelegate.profile.profileLocations[0].forecasts![0].icon+".png")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (appDelegate.profile.profileLocations[0].forecasts?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! WAForecastCell
        
        let forecastObject = appDelegate.profile.profileLocations[0].forecasts![indexPath.item]
        cell.cellImage.image = UIImage(named: forecastObject.icon+".png")
        cell.dayLabel.text = String(forecastObject.time)
        
        cell.layer.cornerRadius = (cell.frame.width / 8)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath) 
        return cell
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
