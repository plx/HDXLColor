//
//  SIMD3+HSBConversionSupport.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport
import Numerics

internal extension SIMD3 where Scalar:ColorComponentRepresentation {
  
  @inlinable
  func extractHSBHueAssumingLinearRGBContents() -> Scalar {
    let minimumComponent = self.min()
    let maximumComponent = self.max()
    let componentDelta = maximumComponent._subtracting( minimumComponent)
    let preHue: Scalar
    if self[0] >= maximumComponent {
      preHue = (self[1]._subtracting(self[2]))._quasiDivided(
        by: componentDelta
      )
    } else if self[1] >= maximumComponent {
      preHue = (self[2]._subtracting(self[0]))._quasiDivided(
        by: componentDelta
      )._adding(2)
    } else /* if self[2] >= maximumComponent */ {
      preHue = (self[0]._subtracting(self[1]))._quasiDivided(
        by: componentDelta
      )._adding(4)
    }
    let fixedPreHue = preHue > 0 ? preHue : preHue._adding(6)
    return fixedPreHue._divided(by: 3)
  }
  
  @inlinable
  func convertedFromHSBToLinearRGB() -> SIMD3<Scalar> {
    let brightness:Scalar = self[2]
    let saturation:Scalar = self[1]
    guard saturation > 0 else {
      return SIMD3<Scalar>(
        brightness,
        brightness,
        brightness
      )
    }

    let one: Scalar = 1
    let two:Scalar = 2
    let three:Scalar = 3
    let six: Scalar = 6

    let chromaC:Scalar = brightness._multiplied(by: saturation)
    
    let hueInPiUnits:Scalar = self[0]

    let hPrime:Scalar = positiveModulus(
      of: hueInPiUnits._multiplied(by: three),
      by: six
    )
    // todo: normalize/modulus if out of bounds
    let hPrimeModulo2:Scalar = positiveModulus(
      of: hPrime,
      by: two
    )
    
    let conversionX:Scalar = chromaC._multiplied(
      by: (
        one._subtracting(
          abs(
            one._subtracting(hPrimeModulo2)
          )
        )
      )
    )
    
    let conversionLittleM:Scalar = brightness._subtracting(chromaC)
    
    let hueSector: Int = Int(hPrime.rounded(.down))
    assert((0...5).contains(hueSector))
    
    let cPlusM:Scalar = chromaC._adding(conversionLittleM)
    let xPlusM:Scalar = conversionX._adding(conversionLittleM)
    let m: Scalar = conversionLittleM
    
    
    let r: Scalar
    let g: Scalar
    let b: Scalar
    switch hueSector {
    case 0:
      r = cPlusM
      g = xPlusM
      b = m
    case 1:
      r = xPlusM
      g = cPlusM
      b = m
    case 2:
      r = m
      g = cPlusM
      b = xPlusM
    case 3:
      r = m
      g = xPlusM
      b = cPlusM
    case 4:
      r = xPlusM
      g = m
      b = cPlusM
    default:
      r = cPlusM
      g = m
      b = xPlusM
    }
    return SIMD3<Scalar>(r,g,b)
  }
  
  @inlinable
  mutating func inPlaceConvertFromHSBToLinearRGB() {
    self = self.convertedFromHSBToLinearRGB()
  }
  
  @inlinable
  func convertedFromLinearRGBToHSB() -> SIMD3<Scalar> {
    let minimumComponent = self.min()
    let maximumComponent = self.max()
    let componentDelta = maximumComponent._subtracting( minimumComponent)
    let saturation = (maximumComponent._subtracting(minimumComponent))._quasiDivided(
      by: maximumComponent
    )
    let brightness = maximumComponent
    let preHue: Scalar
    if self[0] >= maximumComponent {
      preHue = (self[1]._subtracting(self[2]))._quasiDivided(
        by: componentDelta
      )
    } else if self[1] >= maximumComponent {
      preHue = (self[2]._subtracting(self[0]))._quasiDivided(
        by: componentDelta
      )._adding(2)
    } else /* if self[2] >= maximumComponent */ {
      preHue = (self[0]._subtracting(self[1]))._quasiDivided(
        by: componentDelta
      )._adding(4)
    }
    let fixedPreHue = preHue > 0 ? preHue : preHue._adding(6)
    return SIMD3<Scalar>(
      fixedPreHue._divided(by: 3),
      saturation,
      brightness
    )
  }
  
  @inlinable
  mutating func inPlaceConvertFromLinearRGBToHSB() {
    self = self.convertedFromLinearRGBToHSB()
  }
    
}
