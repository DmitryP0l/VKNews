//
//  InsetableTextField.swift
//  VKNews
//
//  Created by lion on 26.05.22.
//

import Foundation
import UIKit


class InsetableTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        placeholder = "search"
        font = UIFont.systemFont(ofSize: 14)
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        let image = UIImage(systemName: "magnifyingglass")
        leftView = UIImageView(image: image)
        leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
}
