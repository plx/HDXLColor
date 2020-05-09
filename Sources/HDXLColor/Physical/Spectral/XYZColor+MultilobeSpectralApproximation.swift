//
//  XYZColor+MultilobeSpectralApproximation.swift
//

import Foundation
import HDXLCommonUtilities

public extension XYZColor {
  
  @inlinable
  init(multilobeApproximationForWavelength wavelengthInNM: Representation) {
    self.init(
      x: Representation(
        xyzMultilobeNormalizedXForWavelength: wavelengthInNM
      ),
      y: Representation(
        xyzMultilobeNormalizedYForWavelength: wavelengthInNM
      ),
      z: Representation(
        xyzMultilobeNormalizedZForWavelength: wavelengthInNM
      )
    )
  }
  
  @inlinable
  init(multilobeApproximationForWavelength wavelength: VisibleWavelength<Representation>) {
    self.init(
      multilobeApproximationForWavelength: wavelength.wavelengthInNM
    )
  }
  
}

public extension XYZColor {
  
  @inlinable
  init(multilobeApproximationForSparseSpectralBlend blend: SparseSpectralBlend<Representation>) {
    self.init(
      weightedColors: blend.storage.lazy.map() {
        (wavelength,weight) -> (Representation,XYZColor<Representation>)
        in
        (
          Representation(weight),
          XYZColor<Representation>(
            multilobeApproximationForWavelength: wavelength.wavelengthInNM
          )
        )
      }
    )
  }
  
}
