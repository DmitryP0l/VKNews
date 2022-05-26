//
//  GalleryCollectionView.swift
//  VKNews
//
//  Created by lion on 25.05.22.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView  {
    
    var photos = [FeedCellPhotoAttachementViewModel]()
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func set(photos: [FeedCellPhotoAttachementViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        cell.set(imageURL: photos[indexPath.row].photoUrlString)
        return cell
    }
}

extension GalleryCollectionView: RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
    
   
    
}
