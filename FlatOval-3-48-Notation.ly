\version "2.24.2"

\include "ChromaticNotationBase.ly"


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% FlatOval 3-4 Notation for Music
%% Dennis Mitchell, 2024-01-01
%% Requires:
%% Properties:
%%   - notehead shape = hexagon
%%     -- alternates in fill (solid, hollow)
%%   - notehead height = 3 semitones
%%   - staff space = 4 semitones
%%   - notehead is repeated (with overlap) for half (2x) and whole (4x) notes
%%   - dozenal clef notation (from ChromaticNotationBase.ly)
%%     -- treble clef = 50
%%     -- soprano & mezzo-soprano clefs = 46 
%%     -- alto clef = 40
%%     -- tenor & baritone clefs = 36
%%     -- bass clef = 30
%%   - notehead key signature (from ChromaticNotationBase.ly)
%%     -- first notehead stack is a 7th chord of the key's root
%%        --- minor 7th for Aeolian (minor), Dorian & Phrygian keys 
%%        --- major 7th for Ionian (major) and Lydian keys
%%        --- dominant 7th for Mixolydian keys
%%        --- half-diminished 7th for Locrian keys
%%     -- second notehead stack is a 7th chord of the key's second note
%%        --- minor 7th for Ionian (major), Dorian, & Mixolydian keys
%%        --- major 7th for Phrygian and Locrian keys
%%        --- dominant 7th for Lydian keys
%%        --- half-diminished 7th for Aeolian (minor) keys
%%   - Lilypond 2.24 or greater
%%   - ChromaticNotationBase.ly (same directory as this file)
%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           STAFF CONFIGS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define cnb:file-suffix "-FlatOval-3-48-Notation")
#(set! cnb:notation-label "Flat Oval 3-48 Notation (Similar to Clairnote DN by Paul Morris)")
#(set! cnb:notation-footnote "*3-48 Notation: notehead height = 2 semitones; staff lines at +/- 4 & 8 semitones")

#(set! cnb:semitones-per-staff-space 4)          
#(set! cnb:staff-line-positions '(-4 -2  2 4 ))
#(set! cnb:ledger-positions '(-22 -20 -16 -14 -10 -8 8 10 14 16 20 22))
#(set! cnb:multinote-padding -.25)
#(set! cnb:false-hollow #t)


#(set! cnb:stem-attachment-sequence (vector
     `(
        (crotchet-up . (1 . 0))
        (crotchet-down . (-1 . 0))
        (minim-up . (1 . 0))
        (minim-down . (-1 . 0))
     )
   ))

#(define cnb:notehead-path '(
    (moveto 0 -0.375)
    (curveto 0.2985 -0.375 0.541 -0.2113 0.539 0)
    (curveto 0.375 -0.3388 0.539 -0.0413 0.539 0)
    (curveto 0.539 0.205 0.2948 0.375 0.0097 0.375)
    (curveto -0.299 0.375 -0.539 0.21 -0.539 0)
    (curveto -0.539 -0.205 -0.299 -0.375 0 -0.375)
    (closepath)))
#(define cnb:notehead-hollow-path '(
    (moveto -0.0861 -0.1493)
    (curveto 0.086 -0.25 0.2623 -0.2613 0.3434 -0.1983)
    (curveto 0.3585 -0.0963 0.2585 0.0513 0.0861 0.1493)
    (curveto -0.084 0.25 -0.2603 0.2688 -0.3434 0.1983)
    (curveto -0.3565 0.0988 -0.2603 -0.0475 -0.0861 -0.1493)
    (closepath)))

%% starting with C natural, what color
%% sequence will the pitch classes have?
%% (vector count should be a factor of 12)
#(define cnb:notehead-color-sequence (vector     
    black
    ))

#(define cnb:notehead-shape-sequence (vector 
    cnb:notehead-path
  ))

#(define cnb:notehead-hollow-sequence (vector 
    #f
    cnb:notehead-hollow-path 
    ))

#(define cnb:notehead-rotation-sequence (vector
     180 ;; non-inverted (right-side up)
   ))

#(define cnb:notehead-scaling-sequence (vector
     '(1 . 1)                                   
   ))




