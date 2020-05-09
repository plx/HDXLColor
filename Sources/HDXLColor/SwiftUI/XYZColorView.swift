//
//  XYZColorView.swift
//

import Foundation
import simd
import SwiftUI
import HDXLCommonUtilities
import HDXLSIMDSupport

@frozen
public struct XYZColorView : View, Hashable, IndirectColor, Animatable {
  
  @usableFromInline
  internal var color: XYZColor<Double>
  
  @inlinable
  public init(color: XYZColor<Double>) {
    self.color = color
  }
  
  @inlinable
  public var body: Color {
    get {
      return Color(from: self.color)
    }
  }
  
  @inlinable
  public static func ==(
    lhs: XYZColorView,
    rhs: XYZColorView) -> Bool {
    return lhs.color == rhs.color
  }
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.color.hash(into: &hasher)
  }
  
  public typealias AnimatableData = XYZColor<Double>
  
  @inlinable
  public var animatableData: XYZColor<Double> {
    get {
      return self.color
    }
    set {
      self.color = newValue
    }
  }

}

