//
//  SourceCollectionViewController.swift
//  Top News
//
//  Created by Egor on 09.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellWithImage"

class SourceCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        SourceOfAPI.loadAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SourceOfAPI.APIStorage.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SourceCollectionViewCell
        cell.imageView.image = UIImage(named: SourceOfAPI.APIStorage[indexPath.row].image)
        cell.check.isHidden = !SourceOfAPI.APIStorage[indexPath.row].state
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SourceOfAPI.APIStorage[indexPath.row].state = !SourceOfAPI.APIStorage[indexPath.row].state
        (collectionView.cellForItem(at: indexPath) as! SourceCollectionViewCell).check.isHidden  = ((collectionView.cellForItem(at: indexPath) as! SourceCollectionViewCell).check.isHidden) ? false : true
        SourceOfAPI.saveAPI()
        
        
    }

    //MARK: - Setting normal size for image
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = UIScreen.main.bounds.width/3 - 3

        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(3.0)
    }

    
}
