//
//  ColorProvider.swift
//

import Foundation
import SwiftUI

public protocol ColorProvider {
  
  func toSwiftUIColor() -> Color 
  
}
