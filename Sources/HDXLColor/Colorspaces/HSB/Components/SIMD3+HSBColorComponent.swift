//
//  SIMD3+HSBColorComponent.swift
//

import Foundation
import simd

internal extension SIMD3 {
  
  @inlinable
  subscript(component: HSBColorComponent) -> Scalar {
    get {
      return self[component.rawValue]
    }
    set {
      self[component.rawValue] = newValue
    }
  }
  
}
