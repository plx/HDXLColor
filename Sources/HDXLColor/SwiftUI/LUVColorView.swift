//
//  LUVColorView.swift
//

import Foundation
import simd
import SwiftUI
import HDXLCommonUtilities
import HDXLSIMDSupport

@frozen
public struct LUVColorView : View, Hashable, IndirectColor, Animatable {
  
  @usableFromInline
  internal var color: LUVColor<Double>
  
  @inlinable
  public init(color: LUVColor<Double>) {
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
    lhs: LUVColorView,
    rhs: LUVColorView) -> Bool {
    return lhs.color == rhs.color
  }
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.color.hash(into: &hasher)
  }
  
  public typealias AnimatableData = LUVColor<Double>
  
  @inlinable
  public var animatableData: LUVColor<Double> {
    get {
      return self.color
    }
    set {
      self.color = newValue
    }
  }

}

