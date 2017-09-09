//
//  MainTableViewCell.swift
//  Top News
//
//  Created by Egor on 06.09.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {


    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var delegate: MainViewCellProtocoll?
    
    @IBAction func seeDescriptionButton(_ sender: UIButton) {
        if let indexPath = self.indexPath{
            delegate?.seeDescription(at: indexPath.row)
        }
    }

    @IBAction func toReadLaterOrDelete(_ sender: UIButton) {
        if let indexPath = self.indexPath{
            delegate?.toReadLaterOrDelete(at: indexPath.row)
        }
    }

}

extension UITableViewCell {
    
    var indexPath: IndexPath? {
        return (superview?.superview as? UITableView)?.indexPath(for: self)
    }
}
