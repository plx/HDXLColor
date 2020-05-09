//
//  VisibleWavelength.swift
//

import Foundation
import HDXLCommonUtilities

/// This struct exists to get a more-predictable representation of visible
/// wavelengths (by predictable I mean well-behaved vis-a-vis hashing). In general
/// this is, internally, a bog-standard fixed-point representation.
///
/// For now I'm just storing things scaled by 1000--so 390 is 390000, etc.--but that
/// is just to get the rest of this up-and-running. When I hit 0.1.x on this package
/// I'll want to, instead, use something like an 11.20 representation (one bit for negative),
/// or some similar binary decomposition.
///
/// Well, more-precisely, the best lookup table I found has .1-nm buckets from
/// 390nm through 830nm (inclusive). When I finalize this I'll probably represent
/// these wavelengths scaled so that the integral portion indicates that .1-nm bucket,
/// and the fractional portion indicates internal position...SOMEDAY.
@frozen
public struct VisibleWavelength<Representation:ColorComponentRepresentation> {
  
  public static var shortestVisibleWavelengthInNM: Representation {
    get {
      return 390
    }
  }
  public static var longestVisibleWavelengthInNM: Representation {
    get {
      return 830
    }
  }
  
  public static var rangeOfVisibleWavelengthsInNM: ClosedRange<Representation> {
    get {
      return Self.shortestVisibleWavelengthInNM...Self.longestVisibleWavelengthInNM
    }
  }
  
  @usableFromInline
  internal var wavelengthInPM: Representation
  
  @inlinable
  public var wavelengthInNM: Representation {
    get {
      return self.wavelengthInPM._divided(by: 1000)
    }
    set {
      self.wavelengthInPM = newValue._multiplied(by: 1000)
    }
  }
      
  @inlinable
  internal init(wavelengthInPM: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.wavelengthInPM = wavelengthInPM
  }
  
  @inlinable
  public init<R:BinaryInteger>(wavelengthInNM: R) {
    self.init(
      wavelengthInPM: Representation(wavelengthInNM)
    )
  }
  
  @inlinable
  public init(wavelengthInNM: Representation) {
    self.init(
      wavelengthInPM: wavelengthInNM._multiplied(by: 1000)
    )
  }

}

extension VisibleWavelength : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.wavelengthInPM.isFinite
    }
  }
  
}

extension VisibleWavelength : RealizableValue {
  
  @inlinable
  public var isRealizableValue: Bool {
    get {
      guard
        self.isValid,
        Self.rangeOfVisibleWavelengthsInNM.contains(self.wavelengthInNM) else {
          return false
      }
      return true
    }
  }
  
}

extension VisibleWavelength : Equatable {
  
  @inlinable
  public static func ==(
    lhs: VisibleWavelength,
    rhs: VisibleWavelength) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.wavelengthInPM == rhs.wavelengthInPM
  }
  
}

extension VisibleWavelength : Comparable {
  
  @inlinable
  public static func <(
    lhs: VisibleWavelength,
    rhs: VisibleWavelength) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.wavelengthInPM < rhs.wavelengthInPM
  }

  @inlinable
  public static func >(
    lhs: VisibleWavelength,
    rhs: VisibleWavelength) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.wavelengthInPM > rhs.wavelengthInPM
  }

  @inlinable
  public static func <=(
    lhs: VisibleWavelength,
    rhs: VisibleWavelength) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.wavelengthInPM <= rhs.wavelengthInPM
  }

  @inlinable
  public static func >=(
    lhs: VisibleWavelength,
    rhs: VisibleWavelength) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.wavelengthInPM >= rhs.wavelengthInPM
  }

  
}

extension VisibleWavelength : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.wavelengthInPM.hash(into: &hasher)
  }
  
}

extension VisibleWavelength : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "\(self.wavelengthInNM) nm"
    }
  }
    
}

extension VisibleWavelength : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "VisibleWavelength(wavelengthInPM: \(self.wavelengthInPM))"
    }
  }
  
}

extension VisibleWavelength : Codable {
  
  // synthesized ok
  
}
