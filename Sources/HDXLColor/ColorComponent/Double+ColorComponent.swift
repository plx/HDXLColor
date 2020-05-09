//
//  Double+ColorComponent.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

extension Double : ColorComponentRepresentation {
  
  @inlinable
  public static func extractSquareLength(from vector: SIMD3<Double>) -> Double {
    return simd_length_squared(vector)
  }

}
