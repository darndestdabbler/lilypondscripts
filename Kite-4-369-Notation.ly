\version "2.24.2"
\include "ChromaticNotationBase.ly"


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Kite 4-3 Notation for Music
%% Dennis Mitchell, 2024-01-01
%% Properties:
%%   - notehead shape = kite
%%     -- alternates in hollowness (solid, hollow)
%%     -- alternates in orientation (down, down, up, up)
%%     -- alternates in color (purple, red, green)
%%   - notehead height = 4 semitones
%%   - staff space = 3 semitones
%%   - middle staff line is omitted
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
%% Requires:
%%   - Lilypond 2.24 or greater
%%   - ChromaticNotationBase.ly (same directory as this file)
%%
%% Suggestion: use \magnifyStaff #7/4 for bigger noteheads
%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           CONFIGURATIONS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define cnb:file-suffix "-Kite-4-369-Notation")
#(set! cnb:notation-label "Kite 4-369 Notation")
#(set! cnb:notation-footnote "*4-369 Notation: notehead height = 4 semitones; staff lines at +/- 3, 6 & 9 semitones")

#(set! cnb:semitones-per-staff-space 3)          
#(set! cnb:staff-line-positions '(-6 -4 -2  2 4 6 ))
#(set! cnb:ledger-positions '(-26 -22 -20 -18 -14 -12 -10 10 12 14 18 20 22 26))
#(set! cnb:multinote-padding -.5) 
#(set! cnb:false-hollow #t)

#(set! cnb:stem-attachment-sequence (vector
     `(
        (crotchet-up . (0 . .9))
        (crotchet-down . (0 . -.9))
        (minim-up . (-.365 . .9))
        (minim-down . (.365 . -.9))
     )
   ))

#(define cnb:notehead-shape-path '(
    (moveto 0 0.6667)
    (lineto 0.6667 0.3333)
    (lineto 0 -0.6667)
    (lineto -0.6667 0.3333)
    (lineto 0 0.6667)
    (closepath)))

#(define cnb:notehead-hollow-path '(
    (moveto 0.3333 0.3333)
    (lineto 0 -0.3333)
    (lineto -0.3333 0.3333)
    (lineto 0.3333 0.3333)
    (closepath)))

%#(define cnb:notehead-hollow-path '(
%    (moveto 0.3333 0.3333)
%    (lineto -0.3333 0.3333)
%    (lineto 0 -0.3333)
%    (lineto 0.3333 0.3333)
%    (closepath)))



%% starting with C natural, what color
%% sequence will the pitch classes have?
%% (vector count should be a factor of 12)
#(define cnb:notehead-color-sequence (vector     
    cnb:purple ;; semitone mod 3 = 0 (C, D#, F#, A), purplish
    cnb:red    ;; semitone mod 3 = 1 (C#, E, G, A#), redish
    cnb:green  ;; semitone mod 3 = 2 (D, F, G#, B), greenish
    ))

#(define cnb:notehead-shape-sequence (vector 
    cnb:notehead-shape-path ;; just one shape for this configuration
  ))

#(define cnb:notehead-hollow-sequence (vector 
    #f                      ;; even notes are solid
    cnb:notehead-hollow-path ;; odd notes are hollow
    ))

#(define cnb:notehead-rotation-sequence (vector
   180 ;; inverted (upside-down)  
     0 ;; non-inverted (right-side up)
     0 ;; non-inverted (right-side up)
   180 ;; inverted (upside-down)
   ))

#(define cnb:notehead-scaling-sequence (vector
     '(1 . 1)                                   
   ))


