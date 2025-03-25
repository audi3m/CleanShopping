//
//  PaddedLabel.swift
//  CleanShopping
//
//  Created by J Oh on 3/25/25.
//

import UIKit

final class PaddedLabel: UILabel {
  
  var padding: CGFloat
  
  init(padding: CGFloat = 20) {
    self.padding = padding
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    super.drawText(in: rect.inset(by: insets))
  }
  
  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    let textRect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
    
    return CGRect(
      x: textRect.origin.x - insets.left,
      y: textRect.origin.y - insets.top,
      width: textRect.width + insets.left + insets.right,
      height: textRect.height + insets.top + insets.bottom
    )
  }
}
