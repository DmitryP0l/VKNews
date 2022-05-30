//
//  GradientView.swift
//  VKNews
//
//  Created by lion on 30.05.22.
//

import Foundation
import UIKit

class GradientView: UIView {
    
     private let gradientLayer = CAGradientLayer()
    
//    @IBInspectable private let firstColor: UIColor? {
//        didSet {
//           setupGradientColors() //повторить у остальных
//        }
//    }
//    @IBInspectable private let secondColor: UIColor?
//    @IBInspectable private let thirdColor:UIColor?
    
    private let firstColor: UIColor = #colorLiteral(red: 1, green: 0.5529411765, blue: 0.5529411765, alpha: 1)
    private let secondColor: UIColor = #colorLiteral(red: 1, green: 0.8156862745, blue: 0.5529411765, alpha: 1)
    private let thirdColor:UIColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        //setupGradientColors()
    }
    
    
//    для работы с цветом через интерфейс билдер
//    private func setupGradientColors() {
//        if let firstColor = firstColor, let secondColor = secondColor,let thirdColor = thirdColor {
//            gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
//        }
//    }
}
