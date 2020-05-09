//
//  SIMD3+sRGBColorComponent.swift
//

import Foundation
import simd

internal extension SIMD3 {
  
  @inlinable
  subscript(component: sRGBColorComponent) -> Scalar {
    get {
      return self[component.rawValue]
    }
    set {
      self[component.rawValue] = newValue
    }
  }
  
}
