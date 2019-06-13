//
//  XYZColor.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLInterpolation

// -------------------------------------------------------------------------- //
// MARK: XYZColor - Definition
// -------------------------------------------------------------------------- //

public struct XYZColor<Representation:ColorComponentRepresentation> {
  
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
  public var x: Representation {
    get {
      return self._storage[XYZColorComponent.x]
    }
    set {
      self._storage[XYZColorComponent.x] = newValue
    }
  }
  
  @inlinable
  public var y: Representation {
    get {
      return self._storage[XYZColorComponent.y]
    }
    set {
      self._storage[XYZColorComponent.y] = newValue
    }
  }

  @inlinable
  public var z: Representation {
    get {
      return self._storage[XYZColorComponent.z]
    }
    set {
      self._storage[XYZColorComponent.z] = newValue
    }
  }
  
  @usableFromInline
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = storage
  }
  
  @inlinable
  public init(
    x: Representation,
    y: Representation,
    z: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(x.isFiniteNonNegative)
    pedantic_assert(y.isFiniteNonNegative)
    pedantic_assert(z.isFiniteNonNegative)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = Storage(
      x: x,
      y: y,
      z: z
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColor - Validatable
// -------------------------------------------------------------------------- //

extension XYZColor : Validatable {
  
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
// MARK: XYZColor - Equatable
// -------------------------------------------------------------------------- //

extension XYZColor : Equatable {
  
  @inlinable
  public static func ==(
    lhs: XYZColor<Representation>,
    rhs: XYZColor<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs._storage == rhs._storage
  }
  
  @inlinable
  public static func !=(
    lhs: XYZColor<Representation>,
    rhs: XYZColor<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs._storage != rhs.storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: XYZColor - Hashable
// -------------------------------------------------------------------------- //

extension XYZColor : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._storage.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColor - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension XYZColor : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "xyz: (\(self.x), \(self.y), \(self.z))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColor - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension XYZColor : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "XYZColor<\(String(reflecting: Representation.self))>(x: (\(self.x), y: \(self.y), z: \(self.z))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColor - Codable
// -------------------------------------------------------------------------- //

extension XYZColor : Codable where Representation:Codable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColor - ExpressibleByArrayLiteral
// -------------------------------------------------------------------------- //

extension XYZColor : ExpressibleByArrayLiteral {
  
  public typealias ArrayLiteralElement = Representation
  
  @inlinable
  public init(arrayLiteral elements: ArrayLiteralElement...) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    guard
      elements.count == 3,
      elements.allSatisfy({$0.isFiniteNonNegative}) else {
      fatalError("Tried to construct a literal `XYZColor<\(String(reflecting: Representation.self))>` with \(elements.count) elements (instead of 2): \(elements.description)!")
    }
    self.init(
      x: elements[0],
      y: elements[1],
      z: elements[2]
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColor - Blendable
// -------------------------------------------------------------------------- //

extension XYZColor : Blendable {
  
  public typealias BlendingWeight = Representation
  
  @inlinable
  public init(
    byBlending first: XYZColor<Representation>,
    weight firstWeight: Representation,
    with other: XYZColor<Representation>,
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
