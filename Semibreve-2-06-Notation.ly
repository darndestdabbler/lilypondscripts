\version "2.24.2"

\include "ChromaticNotationBase.ly"


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Semibreve 2-6 Notation for Music
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

#(define cnb:file-suffix "-Semibreve-2-06-Notation")
#(set! cnb:notation-label "Semibreve 2-06 Notation")
#(set! cnb:notation-footnote "*2-06 Notation: notehead height = 2 semitones; staff lines at 0 & +/-6 semitones")


#(set! cnb:semitones-per-staff-space 2)     
#(set! cnb:default-magnify 6/4)

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
    (moveto 0 -0.25)
    (curveto 0.2493 -0.25 0.4524 -0.1383 0.4524 0)
    (curveto 0.4524 0.1383 0.2493 0.25 0 0.25)
    (curveto -0.2499 0.25 -0.4524 0.1383 -0.4524 0)
    (curveto -0.4524 -0.1383 -0.2499 -0.25 0 -0.25)
    (closepath)))
#(define cnb:notehead-hollow-path '(
    (moveto -0.1257 -0.1864)
    (curveto -0.0633 -0.2292 0.0742 -0.2017 0.144 -0.0971)
    (curveto 0.2134 0.0075 0.1893 0.1442 0.1258 0.1865)
    (curveto 0.0626 0.23 -0.0741 0.2017 -0.1439 0.0972)
    (curveto -0.2141 -0.0058 -0.1883 -0.1425 -0.1257 -0.1864)
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
     '(2 . 2)                                   
   ))

#(set! cnb:staff-and-ledger-lines (list
 `(
    (offset . -48)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -47 -48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . -45)
    (type . ledger-line)
    (for-notehead-positions . ,(list -44 -46))	
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . -42.375)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -29 -48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -41.625)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -41 -48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -39)
    (type . ledger-line)
    (for-notehead-positions . ,(list -38 -40))
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . -36)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -35 -48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . -33)
    (type . ledger-line)
    (for-notehead-positions . ,(list -32 -34))		
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . -30.375)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -29 -48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -29.625)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -29 -48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -27)
    (type . ledger-line)
    (for-notehead-positions . ,(list -26 -28))
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . -24)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -23 -48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . -21)
    (type . ledger-line)
    (for-notehead-positions . ,(list -20 -22))		
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . -18.375)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -17 -48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -17.625)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -17 -48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -15)
    (type . ledger-line)
    (for-notehead-positions . ,(list -14 -16))
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . -12)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence -11 -48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . -9)
    (type . ledger-line)
    (for-notehead-positions . ,(list -8 -10))
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . -6.375)
    (type . staff-line)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -5.625)
    (type . staff-line)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . -3)
    (type . ledger-line)
    (for-notehead-positions . ,(list -2 -4))
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 0)
    (type . staff-line)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . 3)
    (type . ledger-line)
    (for-notehead-positions . ,(list 2 4))
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 5.625)
    (type . staff-line)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 6.375)
    (type . staff-line)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 9)
    (type . ledger-line)
    (for-notehead-positions . ,(list 8 10))
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 12)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 11 48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . 15)
    (type . ledger-line)
    (for-notehead-positions . ,(list 14 16))	
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 17.625)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 17 48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 18.375)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 17 48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 21)
    (type . ledger-line)
    (for-notehead-positions . ,(list 20 22))		
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 24)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 23 48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . 27)
    (type . ledger-line)
    (for-notehead-positions . ,(list 26 28))	
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 29.625)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 29 48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 30.375)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 29 48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 33)
    (type . ledger-line)
    (for-notehead-positions . ,(list 32 34))		
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 36)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 35 48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
 `(
    (offset . 39)
    (type . ledger-line)
    (for-notehead-positions . ,(list 38 40))	
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 41.625)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 41 48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 42.375)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 29 48))	
    (length-factor . 1.5)
    (thickness . 1)
    (color . ,cnb:skyblue))
 `(
    (offset . 45)
    (type . ledger-line)
    (for-notehead-positions . ,(list 44 46))	
    (color . ,cnb:bluegreen)
    (thickness . 3))
 `(
    (offset . 48)
    (type . ledger-line)
    (for-notehead-positions . ,(cnb:sequence 47 48))	
    (length-factor . 1.5)
    (dash .
       ((on . .20)  (off . .20)))
    (color . ,cnb:rose))
))

#(cnb:populate-ledger-hashes)

%#(cnb:display-hash-table cnb:ledgers-by-notehead-position)#(newline)
%#(display (cnb:get-ledger-positions))

\layout {
  \context {
    \Staff
         \override StaffSymbol.line-positions = #(lambda (grob) (cnb:staff-line-positions-from-line-def grob))
         \override StaffSymbol.stencil =  #(grob-transformer 'stencil (lambda (grob orig) (cnb:custom-staff-symbol grob orig)))        
         \override StaffSymbol.ledger-positions-function = #(cnb:custom-ledger-positions)
         \override LedgerLineSpanner.stencil =  #(grob-transformer 'stencil (lambda (grob orig) (cnb:custom-ledger-line grob orig)))         
  }
}  
