# HDXLColor

Core HDXL-project color utilities.

## Status: Pre-Pre-Alpha

This is public for visibility, but not meant for public use.

It's missing most of the intended functionality *and* it takes ~15 minutes to compile for me (on my machine). As such, it's unpleasant to work on, and so now that the de minimis proof-of-concept portions have been completed I'm halting it until/unless I see improvement on the compilation-time front.

## Package Overview

The package has three specific aims:

1. interpolation—and thus animation—via non-RGB color spaces (XYZ/LUV/LCH, etc.)
2. physically-based colors:
  - spectral colors (and blends thereof)
  - blackbody-based colors (e.g. "color for color-temperature")
3. physically-based color effects:
  - refraction-based color shifts (e.g. thin-film, iridescence, pearlescence)
  - atmospheric scattering-based color shifts
  
Item (3) is the motivating goal, item (2) is an intermediate step towards that goal, and item (1) is a foundational prerequisite for (2).
  
This is a port of some old, prototype-level code that was originally written in a mix of C and Objective-C. I've been forced to pick-and-choose what I port, however, because:

- it's not a *direct* port:
  - I'm switching to SIMD backing wherever I can (e.g. SIMD3 instead of a 3-element struct)
  - I'm tweaking the API design (the original isn't Swift-y)
- I'm *doing more* than before:
  - the original code gets a lot of functionality via `CoreGraphics` (and `CGColor`) 
  - the port *will* interoperate with `CoreGraphics`, but will not *require* `CoreGraphics`
  - the port *will* interopeate with SwiftUI, too
- Swift's compiler struggles *heavily* with "generic numerics":
  - re-compiling takes 15-20 minutes (whether incremental or from scratch)
  - the slow-down appears to be in the preliminary type-checking phase, and thus blocks most of Xcode's support functionality (highlighting, superficial type-checks, etc.)
  
The original, C/Objective-C prototype was shelved after seeing that it worked, due to the limits of `Quartz`/`QuartzCore`: *yes*, you can define custom *animatable* properties on `CALayer` subclasses; *no*, you apparently can't typically customize *how* existing properties animate, and in my case I couldn't find a reasonable way to pull off the effects I wanted.

Enter `SwiftUI` and its much-more-flexible approach to animation: *yes*, it appears I can now animate the things I wanted to animate, in the way I wanted to animate them all those years ago; *no* (for now), you can't use generic numerics like this and get a fast-enough visual REPL to make it worth pursuing (at least not yet).

That being said, the possibility remains tantalizing, and I plan to pick this back up once there's some significant progress on the compilation-time issue--hopefully later this summer!

## Roadmap

This has proof-of-concept: you can specify a pure-spectral color (by wavelength), use a "multilobe approximation" to convert that to a color, and then get that color into a `SwiftUI` color (with a specific saturation and brightness, since IMHO that's the easiest way to control things).

Once/if compilation times become reasonable, more things will get ported.

## Testing

The original library had rather exhaustive testing, including e.g. checking all the color-conversions for successful round-trips (within a reasonable margin of error) over a very dense subset of possible values (~24 bits' worth). For spectral colors it also checked the approximations against a built-in table of known-good XYZ equivalents, and more-modest checks for the remaining physical effects.

This package isn't (yet) tested, but as a port of *that* package it's starting from a good place. Testing will still arrive, but only when/if fighting the compiler is no longer so painful.