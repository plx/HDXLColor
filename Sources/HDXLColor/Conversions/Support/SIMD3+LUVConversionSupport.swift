//
//  SIMD3+LUVConversionSupport.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

internal extension ColorComponentRepresentation {
  
  @inlinable
  static var referenceU: Self {
    get {
      return 0.19783000664283
    }
  }
  
  @inlinable
  static var referenceV: Self {
    get {
      return 0.46831999493879
    }
  }
  
}

internal extension SIMD3 where Scalar:ColorComponentRepresentation {
  
  @inlinable
  func convertedFromXYZToLUV() -> SIMD3<Scalar> {
    guard !self.isNonPositive else {
      return SIMD3<Scalar>()
    }
    // compiler can't type-check this in reasonable time if i write it
    // without breaking it down to this level:
    let fifteenY:Scalar = self.y._multiplied(by: 15.0)
    let threeZ:Scalar = self.z._multiplied(by: 3.0)
    let fifteenYPlusThreeZ:Scalar = fifteenY._adding(threeZ)
    let denominatorTerm:Scalar = (
      self.x
      +
      fifteenYPlusThreeZ
    )
    let denominator:Scalar = denominatorTerm._inverted()
    
    let varU:Scalar = self
      .x
      ._multiplied(by: 4.0)
      ._multiplied(by: denominator)
    let varV:Scalar = self
      .y
      ._multiplied(by: 9.0)
      ._multiplied(by: denominator)

    let lStar:Scalar = Scalar.prepareLForLUV(
      byConvertingYFromXYZ: self.y
    )
    let thirteenLStar:Scalar = lStar._multiplied(by: 13.0)
    
    let localU:Scalar = thirteenLStar._multiplied(
      by: varU._subtracting(Scalar.referenceU)
    )
    let localV:Scalar = thirteenLStar._multiplied(
      by: varV._subtracting(Scalar.referenceV)
    )
    
    return SIMD3<Scalar>(
      lStar,
      localU,
      localV
    )
  }

  @inlinable
  mutating func inPlaceConvertFromXYZToLUV() {
    self = self.convertedFromXYZToLUV()
    // ^ too complicated to see doing much better 
  }
  
  @inlinable
  func convertedFromLUVToXYZ() -> SIMD3<Scalar> {
    let lComponent = self[LUVColorComponent.l]
    guard lComponent > 0.0 else {
      return SIMD3<Scalar>()
    }
    let one: Scalar = 1.0
    let three: Scalar = 3.0
    let four: Scalar = 4.0
    let five: Scalar = 5.0
    let nine: Scalar = 9.0
    let thirteen: Scalar = 13.0
    let fiftyTwo: Scalar = 52.0
    
    let convertedY:Scalar = Scalar.prepareYForXYZ(
      byConvertingLFromLUV: lComponent
    )
    
    let uComponent:Scalar = self[LUVColorComponent.u]
    let vComponent:Scalar = self[LUVColorComponent.v]
    
    let thirteenL:Scalar = thirteen._multiplied(by: lComponent)
    let thirteenLReferenceU:Scalar = thirteenL._multiplied(by: Scalar.referenceU)
    let thirteenLReferenceV:Scalar = thirteenL._multiplied(by: Scalar.referenceV)
    
    let uPlusThirteenReferenceU:Scalar = uComponent._adding(thirteenLReferenceU)
    let vPlusThirteenReferenceV:Scalar = vComponent._adding(thirteenLReferenceV)
    
    let uPlusThirteenReferenceUDividedByVPlusThirteenReferenceV:Scalar = uPlusThirteenReferenceU._divided(
      by: vPlusThirteenReferenceV
    )
    
    let nineFourths:Scalar = nine._divided(by: four)
    let nineFourthsY:Scalar = nineFourths._multiplied(by: convertedY)
    
    let convertedX:Scalar = nineFourthsY._multiplied(
      by: uPlusThirteenReferenceUDividedByVPlusThirteenReferenceV
    )
    
    let oneThirdX:Scalar = convertedX._divided(by: three)
    
    let fiftyTwoL:Scalar = fiftyTwo._multiplied(by: lComponent)
    let fiftyTwoLDividedByUPlusThirteenReferenceU: Scalar = fiftyTwoL._divided(
      by: uPlusThirteenReferenceU
    )
    let fiftyTwoLDividedByUPlusThirteenReferenceUMinusOne: Scalar = fiftyTwoLDividedByUPlusThirteenReferenceU._subtracting(one)
    
    let oneThirdXFiftyTwoLDividedByUPlusThirteenReferenceUMinusOne: Scalar = oneThirdX._multiplied(
      by: fiftyTwoLDividedByUPlusThirteenReferenceUMinusOne
    )
    
    let fiveY:Scalar = five._multiplied(by: convertedY)
    
    let convertedZ:Scalar = oneThirdXFiftyTwoLDividedByUPlusThirteenReferenceUMinusOne._subtracting(fiveY)
    
    return SIMD3<Scalar>(
      convertedX,
      convertedY,
      convertedZ
    )
  }

  @inlinable
  mutating func inPlaceConvertFromLUVToXYZ() {
    self = self.convertedFromLUVToXYZ()
  }
  
}

//
//internal extension SIMD3 where Scalar:ColorComponentRepresentation {
//
//  @inlinable
//  func convertedFromXYZToLUV() -> SIMD3<Scalar> {
//    guard !self.isNonPositive else {
//      return SIMD3<Scalar>()
//    }
//    // compiler can't type-check this in reasonable time if i write it
//    // without breaking it down to this level:
//    let fifteenY:Scalar = self.y * 15.0
//    let threeZ:Scalar = self.z * 3.0
//    let fifteenYPlusThreeZ:Scalar = fifteenY + threeZ
//    let denominatorTerm:Scalar = (
//      self.x
//      +
//      fifteenYPlusThreeZ
//    )
//    let denominator:Scalar = 1.0/denominatorTerm
//
//    let varU:Scalar = 4.0 * self.x * denominator
//    let varV:Scalar = 9.0 * self.y * denominator
//
//    let lStar:Scalar = Scalar.prepareLForLUV(
//      byConvertingYFromXYZ: self.y
//    )
//    let thirteenLStar:Scalar = 13.0 * lStar
//
//    let localU:Scalar = thirteenLStar * (varU - Scalar.referenceU)
//    let localV:Scalar = thirteenLStar * (varV - Scalar.referenceV)
//
//    return SIMD3<Scalar>(
//      lStar,
//      localU,
//      localV
//    )
//  }
//
//  @inlinable
//  mutating func inPlaceConvertFromXYZToLUV() {
//    self = self.convertedFromXYZToLUV()
//    // ^ too complicated to see doing much better
//  }
//
//  @inlinable
//  func convertedFromLUVToXYZ() -> SIMD3<Scalar> {
//    let lComponent = self[LUVColorComponent.l]
//    guard lComponent > 0.0 else {
//      return SIMD3<Scalar>()
//    }
//    let one: Scalar = 1.0
//    let three: Scalar = 3.0
//    let four: Scalar = 4.0
//    let five: Scalar = 5.0
//    let nine: Scalar = 9.0
//    let thirteen: Scalar = 13.0
//    let fiftyTwo: Scalar = 52.0
//
//    let convertedY:Scalar = Scalar.prepareYForXYZ(
//      byConvertingLFromLUV: lComponent
//    )
//
//    let uComponent:Scalar = self[LUVColorComponent.u]
//    let vComponent:Scalar = self[LUVColorComponent.v]
//
//    let thirteenL:Scalar = thirteen * lComponent
//    let thirteenLReferenceU:Scalar = thirteenL * Scalar.referenceU
//    let thirteenLReferenceV:Scalar = thirteenL * Scalar.referenceV
//
//    let uPlusThirteenReferenceU:Scalar = uComponent + thirteenLReferenceU
//    let vPlusThirteenReferenceV:Scalar = vComponent + thirteenLReferenceV
//
//    let uPlusThirteenReferenceUDividedByVPlusThirteenReferenceV:Scalar = (uPlusThirteenReferenceU/vPlusThirteenReferenceV)
//
//    let nineFourths:Scalar = nine/four
//    let nineFourthsY:Scalar = nineFourths * convertedY
//
//    let convertedX:Scalar = nineFourthsY * uPlusThirteenReferenceUDividedByVPlusThirteenReferenceV
//
//    let oneThirdX:Scalar = convertedX / three
//
//    let fiftyTwoL:Scalar = fiftyTwo * lComponent
//    let fiftyTwoLDividedByUPlusThirteenReferenceU: Scalar = fiftyTwoL / uPlusThirteenReferenceU
//    let fiftyTwoLDividedByUPlusThirteenReferenceUMinusOne: Scalar = fiftyTwoLDividedByUPlusThirteenReferenceU - one
//
//    let oneThirdXFiftyTwoLDividedByUPlusThirteenReferenceUMinusOne: Scalar = oneThirdX * fiftyTwoLDividedByUPlusThirteenReferenceUMinusOne
//    let fiveY:Scalar = five * convertedY
//
//    let convertedZ:Scalar = oneThirdXFiftyTwoLDividedByUPlusThirteenReferenceUMinusOne - fiveY
//
//    return SIMD3<Scalar>(
//      convertedX,
//      convertedY,
//      convertedZ
//    )
//
////    HDXLCParameterAssert(HDXLLUVColorIsValid(luv));
////    return ((luv.l <= 0.0)
////            ?(kHDXLXYZColorZero)
////            :({
////
////      const CGFloat convertedY = HDXLLUVXYZConvertLToY(luv.l);
////      const CGFloat convertedX = ((9.0/4.0)
////                                  *
////                                  convertedY
////                                  *
////                                  ((luv.u + (13.0 * luv.l * kHDXLReferenceU))
////                                   /
////                                   (luv.v + (13.0 * luv.l * kHDXLReferenceV))));
////      const CGFloat convertedZ = ((convertedX/3.0)
////                                  *
////                                  (((52.0 * luv.l)
////                                    /
////                                    (luv.u + 13.0 * luv.l * kHDXLReferenceU))
////                                   -
////                                   1.0)) - (5.0 * convertedY);
////
////      HDXLXYZColorMake(HDXLForgivinglyClipBetween(convertedX,
////                                                  kHDXLXYZColorMinimumX,
////                                                  kHDXLXYZColorMaximumX),
////                       HDXLForgivinglyClipBetween(convertedY,
////                                                  kHDXLXYZColorMinimumY,
////                                                  kHDXLXYZColorMaximumY),
////                       HDXLForgivinglyClipBetween(convertedZ,
////                                                  kHDXLXYZColorMinimumZ,
////                                                  kHDXLXYZColorMaximumZ));
////
//  }
//
//  @inlinable
//  mutating func inPlaceConvertFromLUVToXYZ() {
//    self = self.convertedFromLUVToXYZ()
//  }
//
//}
