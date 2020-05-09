//
//  PureSpectralColorMultilobeApproximationView.swift
//

import Foundation
import simd
import SwiftUI
import HDXLCommonUtilities
import HDXLSIMDSupport

@frozen
public struct PureSpectralColorMultilobeApproximationView : View, Hashable, IndirectColor, Animatable {
  
  @usableFromInline
  internal var color: PureSpectralColor<Double>
  
  @inlinable
  public init(color: PureSpectralColor<Double>) {
    self.color = color
  }
  
  @inlinable
  public var body: Color {
    get {
      return Color(fromMultilobeApproximationOf: self.color)
    }
  }
  
  @inlinable
  public static func ==(
    lhs: PureSpectralColorMultilobeApproximationView,
    rhs: PureSpectralColorMultilobeApproximationView) -> Bool {
    return lhs.color == rhs.color
  }
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.color.hash(into: &hasher)
  }
  
  public typealias AnimatableData = PureSpectralColor<Double>
  
  @inlinable
  public var animatableData: PureSpectralColor<Double> {
    get {
      return self.color
    }
    set {
      self.color = newValue
    }
  }

}

