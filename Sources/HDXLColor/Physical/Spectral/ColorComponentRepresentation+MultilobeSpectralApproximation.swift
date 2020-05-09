//
//  ColorComponentRepresentation+MultilobeSpectralApproximation.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: ColorComponentRepresentation - Multilobe XYZ For Wavelength
// -------------------------------------------------------------------------- //

internal extension ColorComponentRepresentation {
  
  @inlinable
  init(xyzMultilobeNormalizedXForWavelength wavelengthInNM: Self) {
    self.init(_adding:
      wavelengthInNM
        .multilobeXParameterD1
        .weightedGaussian(weight: 0.362),
      wavelengthInNM
        .multilobeXParameterD2
        .weightedGaussian(weight: 1.056),
      wavelengthInNM
        .multilobeXParameterD3
        .weightedGaussian(weight: -0.065)
    )
  }

  @inlinable
  init(xyzMultilobeNormalizedYForWavelength wavelengthInNM: Self) {
    self.init(_adding:
      wavelengthInNM
        .multilobeYParameterD1
        .weightedGaussian(weight: 0.821),
      wavelengthInNM
        .multilobeYParameterD2
        .weightedGaussian(weight: 0.286)
    )
  }

  @inlinable
  init(xyzMultilobeNormalizedZForWavelength wavelengthInNM: Self) {
    self.init(_adding:
      wavelengthInNM
        .multilobeZParameterD1
        .weightedGaussian(weight: 1.217),
      wavelengthInNM
        .multilobeZParameterD2
        .weightedGaussian(weight: 0.681)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ColorComponentRepresentation - Multilobe X Parameters
// -------------------------------------------------------------------------- //

internal extension ColorComponentRepresentation {
  
  @inlinable
  var multilobeXParameterD1: Self {
    get {
      return self.calculateMultilobeDParameter(
        thresholdShift: 442.0,
        undershootFactor: 0.0624,
        overshootFactor: 0.0374
      )
    }
  }

  @inlinable
  var multilobeXParameterD2: Self {
    get {
      return self.calculateMultilobeDParameter(
        thresholdShift: 599.8,
        undershootFactor: 0.0264,
        overshootFactor: 0.0323
      )
    }
  }

  @inlinable
  var multilobeXParameterD3: Self {
    get {
      return self.calculateMultilobeDParameter(
        thresholdShift: 501.1,
        undershootFactor: 0.0490,
        overshootFactor: 0.0382
      )
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: ColorComponentRepresentation - Multilobe Y Parameters
// -------------------------------------------------------------------------- //

internal extension ColorComponentRepresentation {
  
  @inlinable
  var multilobeYParameterD1: Self {
    get {
      return self.calculateMultilobeDParameter(
        thresholdShift: 568.8,
        undershootFactor: 0.0213,
        overshootFactor: 0.0247
      )
    }
  }

  @inlinable
  var multilobeYParameterD2: Self {
    get {
      return self.calculateMultilobeDParameter(
        thresholdShift: 530.9,
        undershootFactor: 0.0613,
        overshootFactor: 0.0322
      )
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: ColorComponentRepresentation - Multilobe Z Parameters
// -------------------------------------------------------------------------- //

internal extension ColorComponentRepresentation {
  
  @inlinable
  var multilobeZParameterD1: Self {
    get {
      return self.calculateMultilobeDParameter(
        thresholdShift: 437.0,
        undershootFactor: 0.0845,
        overshootFactor: 0.0278
      )
    }
  }

  @inlinable
  var multilobeZParameterD2: Self {
    get {
      return self.calculateMultilobeDParameter(
        thresholdShift: 459.0,
        undershootFactor: 0.0385,
        overshootFactor: 0.0725
      )
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: ColorComponentRepresentation - Supporting Functions
// -------------------------------------------------------------------------- //

internal extension ColorComponentRepresentation {
  
  @inlinable
  func weightedGaussian(weight: Self) -> Self {
    return weight._multiplied(
      by: .exp(
        self
          ._squared()
          ._multiplied(by: -0.5)
        )
    )
  }
  
  
  @inlinable
  func thresholdedSelection(
    cutoff: Self,
    undershootValue undershoot: Self,
    overshootValue overshoot: Self) -> Self {
    switch self < cutoff {
    case true:
      return undershoot
    case false:
      return overshoot
    }
  }
  
  @inlinable
  func calculateMultilobeDParameter(
    thresholdShift threshold: Self,
    undershootFactor undershoot: Self,
    overshootFactor overshoot: Self) -> Self {
    return self
      ._subtracting(threshold)
      ._multiplied(
        by: self.thresholdedSelection(
          cutoff: threshold,
          undershootValue: undershoot,
          overshootValue: overshoot
        )
      )
  }

}
