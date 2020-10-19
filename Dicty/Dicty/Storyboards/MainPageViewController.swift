//
//  MainPageViewController.swift
//  Dicty
//
//  Created by Егор Бедов on 25/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
  @IBOutlet weak var personalDictysCV: UICollectionView!
  
  var personalDictys = [Dicty]()
  var commonDictys = [Dicty]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    personalDictys = Dicty.tempPersonalDictys
    commonDictys = Dicty.tempCommonDictys
    
    personalDictysCV.backgroundColor = UIColor.clear
  }
}

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    
    // continue
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView.tag == 1 {
      return personalDictys.count
    } else {
      return commonDictys.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPageDictyCell", for: indexPath) as? MainPageDictyCell else {
      return .init()
    }
    
    if collectionView.tag == 1 {
      cell.customizeCell(icon: personalDictys[indexPath.row].icon, title: personalDictys[indexPath.row].title)
    } else {
      cell.customizeCell(icon: commonDictys[indexPath.row].icon, title: commonDictys[indexPath.row].title)
    }
    
    return cell
  }
  
  
}
