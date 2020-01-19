//
//  DictyViewController.swift
//  Dicty
//
//  Created by Егор Бедов on 17/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

class DictyViewController: UIViewController {
    let dicty: Dicty
    
    init(dicty: Dicty) {
        self.dicty = dicty
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
