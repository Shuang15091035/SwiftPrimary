//
//  MyCollectionController.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/18.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit


class MyCollectionController: UIViewController{

    var collectionView: UICollectionView?
    var avaliableData: Array<String>? = ["test","thing","good"]
    var reuseIdentifier: String {
        get {
            return "CollectionViewCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollection()
    }
    
    func setupCollection( ) {
        
        
        let viewLayout = UICollectionViewFlowLayout()
        let marge: CGFloat = 20.0
        viewLayout.minimumLineSpacing = marge
        let collectionWidth = self.view.frame.width - 40
        let collectionHeight = self.view.frame.height - 60
        viewLayout.itemSize = .init(width: collectionWidth, height:collectionHeight )
//        viewLayout.sectionInset = UIEdgeInsetsMake(marge, marge, marge, marge)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        collectionView?.frame = .init(x: 0, y: 0, width: collectionWidth, height: collectionHeight)
        collectionView?.center = self.view.center
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        
        collectionView?.register(UINib.init(nibName: self.reuseIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyCollectionController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:self.reuseIdentifier, for: indexPath) as! CollectionViewCell;
        cell.modelData = indexPath.row < 3 ? (avaliableData![indexPath.row]) : ""
        
        cell.backgroundColor = .white
        
        return cell;
    }
}

extension MyCollectionController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
