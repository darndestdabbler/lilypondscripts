# Lilypond Scripts
## Overview
This repository includes scripts for engraving chromatic music notation with [Lilypond Software](https://lilypond.org/).  The files consist of base script (ChromaticNotationBase.ly), several sample configuration scripts, and sample music files that utilize the chromatic music notation.

_SPECIAL NOTE: The scripts are intended to facilitate exploration of chromatic music notation.  They are not feature-complete scripts. They have been tested with only a handful of simple music scores._

## Features
* Noteheads that can be configured with repeating patterns for
  * Size (height in semitones and scalable width)
  * Shape (vector path)
  * Fill (solid vs. hollow -- with false-hollow/white-overlay option)
  * Rotation
  * Color (with optional color-blind-safe colors and monochrome theming)
  * Stem attachment location
* Staff lines and ledger lines that can be configured individually for
  * Position (like regular Lilypond configurations)
  * Thickness
  * Style (solid vs. dashed -- with flexibly dash configuration)
  * Color
  * (Ledger lines have an additional optional configuration that makes their visibility contingent on the presence of particular notes)
* Key signatures that arrange real noteheads (and ledgers when appropriate) into two seventh-chords-like stacks
* Dozenal numeric clef based on scientific notation
* Caching of stencils to improve processing for larger scores

## Suggestions
* Have/develop a working knowledge of the lilypond software and perhaps tools like Frescobaldi
* Have/develop a working knowledge of the Guile 2.2 Scheme programming language
* Explore the [Music Notation Project](https://musicnotation.org/), which presents various alternative chromatic music notations in a systematic way.  The site also has some simpler [lilypond scripts](https://musicnotation.org/wiki/software/lilypond/).
* Check out some other sites with chromatic music notation, for example:
  * [Clairnote](https://clairnote.org/software/)
  * [Dodeka Music](https://www.dodekamusic.com/)
  * [Muto Method](https://muto-method.com/)

## Instructions
* Reference (via "\include") one of the configuration script files in your lilypond music script file
  * Kite-4-369-Notation.ly (my favorite so far)
  * Dozenal-4-369-Notation.ly (numbered noteheads with dek and el for the last two numbers)
  * Dozenal-3-48-Notation.ly (numbered noteheads with dek and el for the last two numbers -- more compact)
  * FlatOval-3-48-Notation.ly (similar to Clairnote DN)
  * Semibreve-2-06-Notation.ly (this script demonstrates custom staff and ledger lines; and yes, one of the ledgers is purposely omitted)
  * Jianpu.ly (not a chromatic notation; see [Wikipedia Numbered Music Notation](https://en.wikipedia.org/wiki/Numbered_musical_notation))
  * ChromaticNotationBase.ly (has a default chromatic notation with two groupings of four staff lines)
* Create and reference your own configuration script (make sure that script references ChromaticNotationBase.ly)

## Disclaimer
_I am a dabbler. I am not an expert in Lilypond, the Scheme programming language, or music theory. I'm not even a musician. That said, please feel free to use and adapt the scripts as you see fit or to build something better._
