\version "2.24.2"

\include "ChromaticNotationBase.ly"


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Oval 2-3579 Notation for Music
%% Dennis Mitchell, 2024-01-01
%% Requires:
%% Properties:
%%   - notehead shape = traditional oval
%%     -- alternates in fill (solid, hollow)
%%   - notehead height = 2 semitones
%%   - staff space = 2 semitones
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

#(define cnb:file-suffix "-Oval-2-3579-Notation")
#(define cnb:notation-label "Oval 2-3579 Notation")
#(define cnb:notation-footnote "*2-3579 Notation: notehead height = 2 semitones; staff lines at +/- 3, 5, 7, & 9 semitones")
#(define cnb:semitones-per-staff-space 2)   

#(define cnb:default-magnify 7/4)

#(define cnb:false-hollow #f)

#(define cnb:multinote-padding -.5) 
#(define cnb:collision-threshold 2)


#(define cnb:notehead-shape-path '(
    (moveto -0.6667 -0.2269)
    (curveto -0.6667 -0.5271 -0.4512 -0.6667 -0.2242 -0.6667)
    (curveto -0.0553 -0.6667 0.1077 -0.6038 0.2475 -0.4991)
    (curveto 0.4396 -0.3595 0.6667 -0.1152 0.6667 0.2269)
    (curveto 0.6667 0.5271 0.4512 0.6667 0.2242 0.6667)
    (curveto 0.0553 0.6667 -0.1077 0.6038 -0.2475 0.4991)
    (curveto -0.4396 0.3595 -0.6667 0.1152 -0.6667 -0.2269)
    (closepath)))

#(define cnb:notehead-hollow-path '(
    (moveto 0.5269 0.3665)
    (curveto 0.5793 0.2548 0.556 0.1152 0.4571 0.0454)
    (lineto -0.2649 -0.4503)
    (curveto -0.3581 -0.5131 -0.4745 -0.4782 -0.5269 -0.3665)
    (curveto -0.5793 -0.2548 -0.5502 -0.1152 -0.4571 -0.0454)
    (lineto 0.2649 0.4503)
    (curveto 0.3697 0.5201 0.4745 0.4782 0.5269 0.3665)
    (closepath)))


%% starting with C natural, what color
%% sequence will the pitch classes have?
%% (vector count should be a factor of 12)
#(define cnb:notehead-color-sequence (vector     
       cnb:black))

#(define cnb:notehead-shape-sequence (vector 
    cnb:notehead-shape-path)) % just one shape for this configuration

#(define cnb:notehead-hollow-sequence (vector 
    '()                      ;; even notes are solid
    cnb:notehead-hollow-path)) % odd notes are hollow

#(define cnb:notehead-rotation-sequence (vector
     0)) % non-inverted (right-side up)  

#(define cnb:notehead-scaling-sequence (vector
     '(0.75 . 0.75)))

#(define cnb:stem-attachment-sequence (vector
     `(
        (crotchet-up . (1 . 0))
        (crotchet-down . (-1 . 0))
        (minim-up . (1 . 0))
        (minim-down . (-1 . 0)))))


#(set! cnb:staff-and-ledger-lines (list
 `((offset . -49)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list -49 -48)))	
 `((offset . -45)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -45)))	
 `((offset . -43)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -43)))	
 `((offset . -41)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -41)))
 `((offset . -39)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -38)))
 `((offset . -37)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list -37 -36)))	
 `((offset . -33)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -33)))	
 `((offset . -31)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -31)))	
 `((offset . -29)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -29)))
 `((offset . -27)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -26)))
 `((offset . -25)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list -25 -24)))	
 `((offset . -21)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -21)))	
 `((offset . -19)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -19)))	
 `((offset . -17)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -17)))
 `((offset . -15)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence -48 -14)))
 `((offset . -13)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list -13 -12)))	
 `((offset .  -9)(type . staff-line))
 `((offset .  -7)(type . staff-line))
 `((offset .  -5)(type . staff-line))
 `((offset .  -3)(type . staff-line))
 `((offset .  -1)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list -1 0)))
 `((offset .   3)(type . staff-line))
 `((offset .   5)(type . staff-line))
 `((offset .   7)(type . staff-line))
 `((offset .   9)(type . staff-line))
 `((offset .  11)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list 11 12)))	
 `((offset .  15)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 14 48)))	
 `((offset .  17)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 17 48)))	
 `((offset .  19)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 19 48)))
 `((offset .  21)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 21 48)))
 `((offset .  23)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list 23 24)))
 `((offset .  27)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 26 48)))	
 `((offset .  29)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 29 48)))	
 `((offset .  31)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 31 48)))
 `((offset .  33)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 33 48)))
 `((offset .  35)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list 35 36)))
 `((offset .  39)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 38 48)))	
 `((offset .  41)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 41 48)))	
 `((offset .  43)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 43 48)))
 `((offset .  45)(type . ledger-line)(for-notehead-positions . ,(cnb:sequence 45 48)))
 `((offset .  47)(type . ledger-line)(dash . ((on . .3)(off . .3)))(for-notehead-positions . ,(list 47 48)))
))

#(cnb:populate-ledger-hashes)

%#(cnb:display-hash-table cnb:ledgers-by-notehead-position)#(newline)


\layout {
  \context {
    \Staff
         \override StaffSymbol.line-positions = #(lambda (grob) (cnb:staff-line-positions-from-line-def grob))
         \override StaffSymbol.stencil =  #(grob-transformer 'stencil (lambda (grob orig) (cnb:custom-staff-symbol grob orig)))        
         \override StaffSymbol.ledger-positions-function = #(cnb:custom-ledger-positions)
         \override LedgerLineSpanner.stencil =  #(grob-transformer 'stencil (lambda (grob orig) (cnb:custom-ledger-line grob orig)))         
  }
}  





