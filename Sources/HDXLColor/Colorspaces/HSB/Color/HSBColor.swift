//
//  HSBColor.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport
import HDXLInterpolation

// -------------------------------------------------------------------------- //
// MARK: HSBColor - Definition
// -------------------------------------------------------------------------- //

public struct HSBColor<Representation:ColorComponentRepresentation> {
  
  public typealias Storage = SIMD3<Representation>
  
  @usableFromInline
  internal var _storage: Storage
  
  @inlinable
  public var storage: Storage {
    get {
      return self._storage
    }
  }
    
  @inlinable
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(storage.isFiniteNonNegative)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = storage
  }
  
  @inlinable
  public init(
    hue: Representation,
    saturation: Representation,
    brightness: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(hue.isFiniteNonNegative)
    pedantic_assert(saturation.isFiniteNonNegative)
    pedantic_assert(brightness.isFiniteNonNegative)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = Storage(
      hue,
      saturation,
      brightness
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - Property Exposure
// -------------------------------------------------------------------------- //

public extension HSBColor {
  
  @inlinable
  var hue: Representation {
    get {
      return self._storage[HSBColorComponent.hue]
    }
    set {
      self._storage[HSBColorComponent.hue] = newValue
    }
  }
  
  @inlinable
  var saturation: Representation {
    get {
      return self._storage[HSBColorComponent.saturation]
    }
    set {
      self._storage[HSBColorComponent.saturation] = newValue
    }
  }

  @inlinable
  var brightness: Representation {
    get {
      return self._storage[HSBColorComponent.brightness]
    }
    set {
      self._storage[HSBColorComponent.brightness] = newValue
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - Validatable
// -------------------------------------------------------------------------- //

extension HSBColor : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        self._storage.isFiniteNonNegative else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - Equatable
// -------------------------------------------------------------------------- //

extension HSBColor : Equatable {
  
  @inlinable
  public static func ==(
    lhs: HSBColor<Representation>,
    rhs: HSBColor<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs._storage == rhs._storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - Hashable
// -------------------------------------------------------------------------- //

extension HSBColor : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._storage.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension HSBColor : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "HSB: (\(self.hue), \(self.saturation), \(self.brightness))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension HSBColor : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "HSBColor<\(String(reflecting: Representation.self))>(hue: (\(self.hue), saturation: \(self.saturation), brightness: \(self.brightness))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - Codable
// -------------------------------------------------------------------------- //

extension HSBColor : Codable where Representation:Codable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - ExpressibleByArrayLiteral
// -------------------------------------------------------------------------- //

extension HSBColor : ExpressibleByArrayLiteral {
  
  public typealias ArrayLiteralElement = Representation
  
  @inlinable
  public init(arrayLiteral elements: ArrayLiteralElement...) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    guard
      elements.count == 3,
      elements.allSatisfy({$0.isFiniteNonNegative}) else {
      fatalError("Tried to construct a literal `HSBColor<\(String(reflecting: Representation.self))>` with \(elements.count) elements (instead of 3): \(elements.description)!")
    }
    self.init(
      hue: elements[0],
      saturation: elements[1],
      brightness: elements[2]
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColor - Blendable
// -------------------------------------------------------------------------- //

extension HSBColor : Blendable {
  
  public typealias BlendingWeight = Representation
  
  @inlinable
  public init(
    byBlending first: HSBColor<Representation>,
    weight firstWeight: Representation,
    with other: HSBColor<Representation>,
    weight otherWeight: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(first.isValid)
    pedantic_assert(firstWeight.isFiniteNonNegative)
    pedantic_assert(other.isValid)
    pedantic_assert(otherWeight.isFiniteNonNegative)
    // /////////////////////////////////////////////////////////////////////////
    self.init(
      storage: (
        (first._storage * firstWeight)
        +
        (other._storage * otherWeight)
      )
    )
  }
  
}
