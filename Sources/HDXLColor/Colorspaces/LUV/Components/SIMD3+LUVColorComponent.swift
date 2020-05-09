//
//  SIMD3+LUVColorComponent.swift
//

import Foundation
import simd

internal extension SIMD3 {
  
  @inlinable
  subscript(component: LUVColorComponent) -> Scalar {
    get {
      return self[component.rawValue]
    }
    set {
      self[component.rawValue] = newValue
    }
  }
  
}
