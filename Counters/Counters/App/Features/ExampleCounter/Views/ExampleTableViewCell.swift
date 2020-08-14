//
//  ExampleTableViewCell.swift
//  Counters
//
//  Created by Bryan Bolivar on 14/08/20.
//

import UIKit
protocol ExampleViewDelegate {
    func didSelectTitle(title: String)
}

class ExampleTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    var delegate: ExampleViewDelegate?

    var model: ExampleViewModel.Category? {
        didSet {
            sectionTitleLabel.text = model?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        sectionTitleLabel.configureAsCellSectionTitle()
    }
}

extension ExampleTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.values.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCollectionViewCell", for: indexPath) as! ExampleCollectionViewCell
        cell.titleLabel.text = model?.values[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTitle(title: model?.values[indexPath.row] ?? "")
    }
}
