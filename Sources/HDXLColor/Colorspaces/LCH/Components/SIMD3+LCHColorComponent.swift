//
//  SIMD3+LCHColorComponent.swift
//

import Foundation
import simd

internal extension SIMD3 {
  
  @inlinable
  subscript(component: LCHColorComponent) -> Scalar {
    get {
      return self[component.rawValue]
    }
    set {
      self[component.rawValue] = newValue
    }
  }
  
}
