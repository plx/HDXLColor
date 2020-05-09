//
//  SIMD3+LCHConversionSupport.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

internal extension SIMD3 where Scalar:ColorComponentRepresentation {
  
  @inlinable
  func convertedFromLUVToLCH() -> SIMD3<Scalar> {
    let uComponent:Scalar = self[LUVColorComponent.u]
    let vComponent:Scalar = self[LUVColorComponent.v]
    let convertedC:Scalar = hypotenuseLength(
      uComponent,
      vComponent
    )
    let unscaledVUArctangent:Scalar = arctangent2(
      y: vComponent,
      x: uComponent
    )
    let scaledVUArctangent:Scalar = unscaledVUArctangent._divided(by: Scalar.pi)
    let two:Scalar = 2.0
    let convertedH:Scalar = positiveModulus(
      of: scaledVUArctangent,
      by: two
    )
    return SIMD3<Scalar>(
      self[LUVColorComponent.l],
      convertedC,
      convertedH
    )
  }
  
  @inlinable
  mutating func inPlaceConvertFromLUVToLCH() {
    self = self.convertedFromLUVToLCH()
  }
  
  @inlinable
  func convertedFromLCHToLUV() -> SIMD3<Scalar> {
    let weights: (Scalar, Scalar) = sineCosinePi(of: self[LCHColorComponent.h])
    let uWeight:Scalar = weights.0
    let vWeight:Scalar = weights.1
    let cComponent:Scalar = self[LCHColorComponent.c]
    let convertedU:Scalar = cComponent._multiplied(by: uWeight)
    let convertedV:Scalar = cComponent._multiplied(by: vWeight)
//    let convertedU:Scalar = cComponent * uWeight
//    let convertedV:Scalar = cComponent * vWeight
    return SIMD3<Scalar>(
      self[LCHColorComponent.l],
      convertedU,
      convertedV
    )
  }
  
  @inlinable
  mutating func inPlaceConvertFromLCHToLUV() {
    self = self.convertedFromLCHToLUV()
  }
  
}

//internal extension SIMD3 where Scalar:ColorComponentRepresentation {
//
//  @inlinable
//  func convertedFromLUVToLCH() -> SIMD3<Scalar> {
//    let uComponent:Scalar = self[LUVColorComponent.u]
//    let vComponent:Scalar = self[LUVColorComponent.v]
//    let convertedC:Scalar = hypotenuseLength(
//      uComponent,
//      vComponent
//    )
//    let unscaledVUArctangent:Scalar = arctangent2(
//      y: vComponent,
//      x: uComponent
//    )
//    let scaledVUArctangent:Scalar = unscaledVUArctangent/Scalar.pi
//    let two:Scalar = 2.0
//    let convertedH:Scalar = positiveModulus(
//      of: scaledVUArctangent,
//      by: two
//    )
//    return SIMD3<Scalar>(
//      self[LUVColorComponent.l],
//      convertedC,
//      convertedH
//    )
//  }
//
//  @inlinable
//  mutating func inPlaceConvertFromLUVToLCH() {
//    self = self.convertedFromLUVToLCH()
//  }
//
//  @inlinable
//  func convertedFromLCHToLUV() -> SIMD3<Scalar> {
//    let weights: (Scalar, Scalar) = sineCosinePi(of: self[LCHColorComponent.h])
//    let uWeight:Scalar = weights.0
//    let vWeight:Scalar = weights.1
//    let cComponent:Scalar = self[LCHColorComponent.c]
//    let convertedU:Scalar = cComponent._multiplied(by: uWeight)
//    let convertedV:Scalar = cComponent._multiplied(by: vWeight)
////    let convertedU:Scalar = cComponent * uWeight
////    let convertedV:Scalar = cComponent * vWeight
//    return SIMD3<Scalar>(
//      self[LCHColorComponent.l],
//      convertedU,
//      convertedV
//    )
//  }
//
//  @inlinable
//  mutating func inPlaceConvertFromLCHToLUV() {
//    self = self.convertedFromLCHToLUV()
//  }
//
//}
