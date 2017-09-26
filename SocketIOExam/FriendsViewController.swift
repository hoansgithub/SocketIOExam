//
//  ViewController.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/20/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class FriendsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let cellReuseIdentifier = "cellReuseIdentifier"
    private let conversationsViewModel = ConversationsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(ConversationCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        conversationsViewModel.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView?.reloadData()
            }
        }
    }


    //MARK: -Collectionview
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! ConversationCollectionViewCell
        if let conversation = conversationsViewModel.item(at: indexPath) {
            conversationsViewModel.configureCellFor(cell :cell, conversation: conversation)
        }
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conversationsViewModel.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}


