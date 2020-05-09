//
//  PureSpectralColor.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import SwiftUI

@frozen
public struct PureSpectralColor<Representation:ColorComponentRepresentation> {
  
  public typealias Wavelength = VisibleWavelength<Representation>
  
  @usableFromInline
  internal typealias Storage = SIMD3<Representation>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  public var wavelength: VisibleWavelength<Representation> {
    get {
      return VisibleWavelength<Representation>(wavelengthInPM: self.storage[0])
    }
    set {
      self.storage[0] = newValue.wavelengthInPM
    }
  }
  
  @inlinable
  public var saturation: Representation {
    get {
      return self.storage[1]
    }
    set {
      self.storage[1] = newValue
    }
  }

  @inlinable
  public var brightness: Representation {
    get {
      return self.storage[2]
    }
    set {
      self.storage[2] = newValue
    }
  }
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  public init(
    wavelength: Wavelength,
    saturation: Representation,
    brightness: Representation) {
    self.init(
      storage: Storage(
        wavelength.wavelengthInPM,
        saturation,
        brightness
      )
    )
  }
  
  @inlinable
  public init(wavelength: Wavelength) {
    self.init(
      wavelength: wavelength,
      saturation: 1,
      brightness: 1
    )
  }
  
}

extension PureSpectralColor : Equatable {
  
  @inlinable
  public static func ==(
    lhs: PureSpectralColor<Representation>,
    rhs: PureSpectralColor<Representation>) -> Bool {
    return lhs.storage == rhs.storage
  }
  
}

extension PureSpectralColor : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.storage.hash(into: &hasher)
  }
  
}

extension PureSpectralColor : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "\(self.wavelength.description) @ saturation \(self.saturation), brightness \(self.brightness)"
    }
  }
  
}

extension PureSpectralColor : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "PureSpectralColor<\(String(reflecting: Representation.self))>(storage: \(String(reflecting: self.storage)))"
    }
  }
  
}

extension PureSpectralColor : Codable {
  
  // synthesized ok
  
}

extension PureSpectralColor : AdditiveArithmetic {
  
  @inlinable
  public static var zero: PureSpectralColor<Representation> {
    get {
      return PureSpectralColor<Representation>(
        storage: .zero
      )
    }
  }
  
  @inlinable
  public static func +(
    lhs: PureSpectralColor<Representation>,
    rhs: PureSpectralColor<Representation>) -> PureSpectralColor<Representation> {
    return PureSpectralColor<Representation>(
      storage: lhs.storage + rhs.storage
    )
  }

  @inlinable
  public static func +=(
    lhs: inout PureSpectralColor<Representation>,
    rhs: PureSpectralColor<Representation>) {
    lhs.storage += rhs.storage
  }

  @inlinable
  public static func -(
    lhs: PureSpectralColor<Representation>,
    rhs: PureSpectralColor<Representation>) -> PureSpectralColor<Representation> {
    return PureSpectralColor<Representation>(
      storage: lhs.storage - rhs.storage
    )
  }

  @inlinable
  public static func -=(
    lhs: inout PureSpectralColor<Representation>,
    rhs: PureSpectralColor<Representation>) {
    lhs.storage -= rhs.storage
  }

}

extension PureSpectralColor : VectorArithmetic {
  
  @inlinable
  public var magnitudeSquared: Double {
    get {
      return Double(
        (self.storage * self.storage).sum()
      )
    }
  }
  
  @inlinable
  public mutating func scale(by factor: Double) {
    self.storage *= Representation(factor)
  }

}
