//
//  WAHomeVC.swift
//  Weathalert
//
//  Created by Scott Browne on 25/01/2018.
//  Copyright © 2018 Smiles Dev. All rights reserved.
//

import Foundation
import UIKit

class WAHomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = ((collectionView.bounds.width-30)/2)
        let itemHeight = ((collectionView.bounds.width-30)/2)
        layout.itemSize = CGSize(width: itemWidth, height:itemHeight)
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let items = appDelegate.profile.profileLocations.count
        return (items + 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath) as! WALocationCell
        
        if indexPath.item < (appDelegate.profile.profileLocations.count) {
            
            cell.locNameLabel.text = appDelegate.profile.profileLocations[indexPath.item].locName
            
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as! WALocationCell
        }
        
        cell.layer.cornerRadius = (cell.frame.width / 8)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == appDelegate.profile.profileLocations.count {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "MapView") as! WAMapView
            self.present(secondViewController, animated: true, completion: nil)
        }
        
        collectionView.reloadData()
    }
    
}
