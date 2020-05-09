//
//  SIMD3+LinearRGBColorComponent.swift
//

import Foundation
import simd

internal extension SIMD3 {
  
  @inlinable
  subscript(component: LinearRGBColorComponent) -> Scalar {
    get {
      return self[component.rawValue]
    }
    set {
      self[component.rawValue] = newValue
    }
  }
  
}
