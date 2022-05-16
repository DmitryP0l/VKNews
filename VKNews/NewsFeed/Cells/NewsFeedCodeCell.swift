//
//  NewsFeedCodeCell.swift
//  VKNews
//
//  Created by lion on 8.05.22.
//

import Foundation
import UIKit

final class NewsFeedCodeCell: UITableViewCell {
    static let identifier = "NewsFeedCodeCell"
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(cardView)
        cardView.backgroundColor = .cyan
    }
    
    private func setupConstraints() {
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
