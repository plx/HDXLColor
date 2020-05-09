//
//  LCHColorView.swift
//

import Foundation
import simd
import SwiftUI
import HDXLCommonUtilities
import HDXLSIMDSupport

@frozen
public struct LCHColorView : View, Hashable, IndirectColor, Animatable {
  
  @usableFromInline
  internal var color: LCHColor<Double>
  
  @inlinable
  public init(color: LCHColor<Double>) {
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
    lhs: LCHColorView,
    rhs: LCHColorView) -> Bool {
    return lhs.color == rhs.color
  }
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.color.hash(into: &hasher)
  }
  
  public typealias AnimatableData = LCHColor<Double>
  
  @inlinable
  public var animatableData: LCHColor<Double> {
    get {
      return self.color
    }
    set {
      self.color = newValue
    }
  }

}

