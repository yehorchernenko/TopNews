//
//  PopUpViewWithDescription.swift
//  Top News
//
//  Created by Egor on 16.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

class PopUpViewWithDescription: UIView {
    
    var delegate: PoPUpDelegate?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func hidePopUpView(_ sender: Any) {
        delegate?.closePopUpWithDescription()
    }
}
