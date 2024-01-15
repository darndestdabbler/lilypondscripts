\version "2.24.2"
#(use-modules (srfi srfi-9))

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Chromatic Notation Base Library for Lilypond
%% Dennis Mitchell, 2024-01-01
%% Base Properties:
%%   - notehead is repeated (with overlap) for half (2x) and whole (4x) notes
%%   - dozenal clef notation
%%     -- treble clef = 50
%%     -- soprano & mezzo-soprano clefs = 46 
%%     -- alto clef = 40
%%     -- tenor & baritone clefs = 36
%%     -- bass clef = 30
%%   - notehead key signature 
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
%% Default Notehead Properties:
%%   - notehead shape = conventional oval shape
%%     -- alternates in hollowness (solid, hollow) --using standard glyphs
%%     -- alternates in orientation (down, down, up, up)
%%     -- alternates in color (purple, red, green)
%%   - notehead height = 2 semitones
%%   - staff space = 2 semitones
%%   - middle staff line is omitted
%% NOTE: This library is intended to be used with a "spec 
%%       file" that overrides various configuration settings.
%%       Examples:
%%         -- KiteNotation.ly
%%         -- DozenalNotation.ly
%%       The default notation style is Oval 2-2
%%
%% USAGE: Place this file in the same directory as the
%%        spec file and then "\include" the spec file in
%%        your Lilypond music file
%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           NOTEHEAD COLORS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


#(define cnb:purple     "#7d3fff")
#(define cnb:red        "#dc4538")
#(define cnb:green      "#0f9e59")

#(define cnb:blue       "#50b4e9")
#(define cnb:rose       "#cc79a7")
#(define cnb:black      "#000000")
#(define cnb:skyblue    "#50b4e9")
#(define cnb:bluegreen 	"#009e73")

#(define cnb:gold       "#ffd42a")


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           CONFIGURATIONS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define cnb:file-suffix "-Oval-2-3579-Notation")
#(define cnb:notation-label "Oval 2-3579 Notation")
#(define cnb:notation-footnote "*2-3579 Notation: notehead height = 2 semitones; staff lines at +/- 3, 5, 7, & 9 semitones")
#(define cnb:semitones-per-staff-space 2)   

#(define cnb:default-magnify 7/4)

#(define cnb:staff-line-positions '(-9 -7 -5 -3 3 5 7 9))
#(define cnb:ledger-positions '(-33 -31 -29 -27 -25 -21 -19 -17 -15 -13 -1 11 15 17 19 21 23 27 29 31 33 35))

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


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         UTILITY PROCEDURES
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (cnb:log2 x) (/ (log x) (log 2)))
#(define (cnb:round2 x n)
   (/ (round (* (expt 10 n) x)) (expt 10 n)))

#(define (cnb:notehead-color-modulus)    (vector-length cnb:notehead-color-sequence))
#(define (cnb:notehead-shape-modulus)    (vector-length cnb:notehead-shape-sequence))
#(define (cnb:notehead-hollow-modulus)   (vector-length cnb:notehead-hollow-sequence))
#(define (cnb:notehead-rotation-modulus) (vector-length cnb:notehead-rotation-sequence))
#(define (cnb:notehead-scaling-modulus)  (vector-length cnb:notehead-scaling-sequence))

%#(define (cnb:get-ledger-positions)
%   (if (eq? (cnb:custom-ledger-count) 0)
%      cnb:ledger-positions
%      (let* (
%              (lst (hash-table->alist cnb:ledgers-by-offset))
%              (prs (map (lambda (p) (assq-ref (cdr p) 'offset)) lst)))
%         prs)))

  
%% generate a markup list for the in-sequence combination 
%% of shape, hollow, and rotation options (per the above
%% sequence definitions
#(define (cnb:notehead-markup-sequence)
    (let* ((flat-list '()))
      (for-each (lambda (i)
          (let* (
                  (color 	(vector-ref cnb:notehead-color-sequence (modulo i (cnb:notehead-color-modulus)))) 
                  (shape 	(vector-ref cnb:notehead-shape-sequence (modulo i (cnb:notehead-shape-modulus)))) 
                  (hollow 	(vector-ref cnb:notehead-hollow-sequence (modulo i (cnb:notehead-hollow-modulus)))) 
                  (path 	(if (and hollow (not cnb:false-hollow)) (append shape hollow) shape))
                  (rotation 	(vector-ref cnb:notehead-rotation-sequence (modulo i (cnb:notehead-rotation-modulus))))
                  (scaling 	(vector-ref cnb:notehead-scaling-sequence (modulo i (cnb:notehead-scaling-modulus)))))
              
              (set! flat-list (append flat-list (list 
                (if (and hollow cnb:false-hollow)
                  (markup (#:overlay (
                    (markup 
                      #:with-color color
                      #:override `((filled . ,1)) 
                      #:rotate rotation
                      #:scale scaling
                      #:path 0 shape)
                    (markup                     
                      #:with-color white
                      #:override `((filled . ,1)) 
                      #:rotate rotation
                      #:scale scaling
                      #:path 0 hollow))))                                
                  (markup 
                    #:with-color color
                    #:override `((filled . ,1)) 
                    #:rotate rotation
                    #:scale scaling
                    #:path 0 path)))))                                
                )
        ) (iota 12 0))
      flat-list))


#(define cnb:notehead-markup-sequence-cache #f)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     CACHE AND CACHE KEY
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% NOTE: this purposely uses a list, rather than a record-type, 
% for the key so that keys with the same values are treated as the same keys
#(define (cnb:get-note-stencil-cache-key grob)
    (let* (
            (note-event 	(ly:grob-property grob 'cause))
            (note-pitch 	(ly:event-property note-event 'pitch))
            (note-semis 	(ly:pitch-semitones note-pitch))
            (note-semis-mod12 	(modulo note-semis 12))
            (note-dur-prop 	(ly:event-property note-event 'duration))
            (note-dur 		(duration-length note-dur-prop))
            (note-log2dur       (- (cnb:log2 (denominator note-dur)) (floor (/ (numerator note-dur) 2)))))
     
        (list note-semis-mod12 note-log2dur)))


% a cache of stencils for notes.
% uses (list note-pitch note-log2dur middle-c-position) as key
#(define cnb:note-stencil-cache (make-hash-table 60))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       CONSTRUCT NOTE STENCIL
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (cnb:new-note-stencil-rec note-stencil-cache-key grob)
  (let* (
          (markup-seq		(cnb:notehead-markup-sequence))
          (note-semis-mod12     (first    note-stencil-cache-key))
          (markup-base       	(list-ref markup-seq note-semis-mod12))
          (note-log2dur         (second   note-stencil-cache-key))
          (stencil   		(grob-interpret-markup grob markup-base))                              
          (mag 		   	(magstep (ly:grob-property grob 'font-size 0.0))))

      ;double the notehead markup (with horizontal offset) for minim (2), semi-breve (4), and breve (8)
      (for-each (lambda (i)
       (let* (
                (idx (- 1 i)))           
         (if (<= note-log2dur idx) (set! stencil (ly:stencil-combine-at-edge stencil 0 1 stencil cnb:multinote-padding))))
      ) (iota 3 0)) 
        
      (ly:stencil-scale stencil mag mag)))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  GET NOTE STENCIL FROM CACHE OR NEW
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (cnb:get-note-stencil-rec grob)
  (let* ( 
          (note-stencil-cache-key (cnb:get-note-stencil-cache-key grob))
          (note-stencil-rec (hashq-ref cnb:note-stencil-cache note-stencil-cache-key)))
   
      (if (not note-stencil-rec)
        (begin 
          (set! note-stencil-rec (cnb:new-note-stencil-rec note-stencil-cache-key grob))
          (hash-set! cnb:note-stencil-cache note-stencil-cache-key note-stencil-rec)))
     
       note-stencil-rec))

#(define (cnb:get-note-stencil-rec-for-keysig note-stencil-cache-key grob)
  (let* ( 
          (note-stencil-rec (hashq-ref cnb:note-stencil-cache note-stencil-cache-key)))
   
      (if (not note-stencil-rec)
        (begin 
          (set! note-stencil-rec (cnb:new-note-stencil-rec note-stencil-cache-key grob))
          (hash-set! cnb:note-stencil-cache note-stencil-cache-key note-stencil-rec)))
     
       note-stencil-rec))




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          NOTEHEAD ENGRAVER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define cnb-notehead-engraver
  (lambda (context)
    (make-engraver
      (acknowledgers
        ((note-head-interface engraver grob source-engraver)
          (let* (
                  (note-stencil-rec	(cnb:get-note-stencil-rec grob))
                  (note-event 		(ly:grob-property grob 'cause))
                  (note-pitch 		(ly:event-property note-event 'pitch))
                  (note-semis 		(ly:pitch-semitones note-pitch))
                  (staff 		(ly:context-grob-definition context 'StaffSymbol))
                  (staff-space 		(or (assq-ref staff 'staff-space) 1.0))
                  (middleCPosition 	(ly:context-property context 'middleCPosition)))
                        
              (set! (ly:grob-property grob 'Y-offset)
                    (* (+ note-semis (* 2 middleCPosition)) (/ 1 cnb:semitones-per-staff-space) staff-space))
              
              (set! (ly:grob-property grob 'stencil) 
                    note-stencil-rec)))))))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           STEM ATTACHMENT
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


#(define (cnb:stem-attachment-modulus)
   (vector-length cnb:stem-attachment-sequence))


#(define (cnb:stem-attachment grob)
    (let* (
            (stem 	(ly:grob-object grob 'stem))
            (stem-dir 	(ly:grob-property stem 'direction UP))
            (event 	(ly:grob-property grob 'cause))
            (pitch 	(ly:event-property event 'pitch))
            (semi 	(ly:pitch-semitones pitch))
            (logdur 	(note-head::calc-duration-log grob))  
            (index 	(modulo semi (cnb:stem-attachment-modulus)))
            (record 	(vector-ref cnb:stem-attachment-sequence index)))     
      
        (cond 
          ((eq? logdur 2)
           (if (eq? stem-dir UP) 
               (assq-ref record 'crotchet-up) 
               (assq-ref record 'crotchet-down)))
          (#t 
           (if (eq? stem-dir UP) 
               (assq-ref record 'minim-up) 
               (assq-ref record 'minim-down))))))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        CLEF SUPPORTING PROCS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Dozenal Clef
#(define (cnb:dozenal-clef middle-c-position ottava)
  (let* (
           (div-three (floor (/ (+ middle-c-position 1 (* -1 ottava)) 3)))
           (base-ten (- 40 (* div-three 5)))
           (mod-ten (modulo base-ten 10))
           (div-ten (floor (/ base-ten 10))))
    
     (+ (* div-ten 10) (* mod-ten 6/5))
    )
  )


% This is not used here, but it is helpful when using clef engraver 
% with predefined regular and change glyphs.  To get the correct
% clef glyph, use the firstClef context property and the proc below.
% (firstClef (ly:context-property context 'firstClef))            
% (adj-glyph-name (if firstClef (first-clef-glyph glyph-name))
#(define (first-clef-glyph clef-glyph)
   (let* (
          (is-change? (eq? 7 (string-suffix-length clef-glyph "_change"))))
     
       (if is-change? 
           (xsubstring clef-glyph 0 (- (string-length clef-glyph) 7))
           clef-glyph)))






%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      CLEF CACHE & ENGRAVER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define cnb:clef-stencil-cache '())

#(define (cnb:get-clef-stencil grob context)
    (let* ( 
            (middleCPosition 	  (ly:context-property context 'middleCPosition))
            (middleCOffset 	  (ly:context-property context 'middleCOffset))
            (ottava 		  (if (equal? middleCOffset '()) 0 middleCOffset)) 
            (clef-num 		  #f)
            (stencil 		  (assq-ref cnb:clef-stencil-cache (list middleCPosition ottava)))
            (mag 		  #f)
            (clef-left-digit 	  #f)
            (clef-right-digit 	  #f)
            (clef-left-markup 	  #f)
            (clef-right-markup 	  #f)
            (stencil-left 	  #f)
            (stencil-right 	  #f)
            (y-extent 		  #f)
            (height 		  #f)
            (scale-factor 	  #f)
            (stencil-left-scaled  #f)
            (stencil-right-scaled #f)
            )
      (if (not stencil)
          (begin 
            (set! clef-num 	       (cnb:dozenal-clef middleCPosition ottava))
            (set! mag 		       (magstep (ly:grob-property grob 'font-size 0.0)))
            (set! clef-left-digit      (floor (/ clef-num 10)))
            (set! clef-right-digit     (modulo clef-num 10))
            (set! clef-left-markup     (markup (#:bold (number->string clef-left-digit))))
            (set! clef-right-markup    (markup (#:bold (number->string clef-right-digit))))
            (set! stencil-left         (grob-interpret-markup grob clef-left-markup))
            (set! stencil-right        (grob-interpret-markup grob clef-right-markup))
            (set! y-extent             (ly:stencil-extent stencil-left 1))
            (set! height               (- (cdr y-extent) (car y-extent)))
            (set! scale-factor         (/ (* 3 mag) height))
            (set! stencil-left-scaled  (ly:stencil-scale stencil-left (* scale-factor 1/2) scale-factor))
            (set! stencil-right-scaled (ly:stencil-scale stencil-right (* scale-factor 1/2) (* scale-factor 2/3)))
            
            (set! stencil     
              (ly:stencil-combine-at-edge
               (ly:stencil-translate stencil-left-scaled (cons 0 (* -.5 mag)))
               0 1
               (ly:stencil-translate stencil-right-scaled (cons 0 0))
               0))
            
            (set! cnb:clef-stencil-cache (assq-set! cnb:clef-stencil-cache (list middleCPosition ottava) stencil))))

      stencil
   ))

#(define cnb-clef-engraver
  (lambda (context)
    (make-engraver
      (acknowledgers
        ((clef-interface engraver grob source-engraver)
          (let* (
                  (stencil (cnb:get-clef-stencil grob context))
                  (mag (magstep (ly:grob-property grob 'font-size 0.0))))
            
            (set! (ly:grob-property grob 'X-offset) (+ (* mag -.00001) 1) )
            (set! (ly:grob-property grob 'Y-offset) (* mag -1) )
            (set! (ly:grob-property grob 'stencil) stencil)))))))    
          
          


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       KEY SIG SUPPORTING PROCS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% calculate staff spaces per octave
% NOTE: keep as proc to allow overriding cnb-semitones-per-staff-space
#(define (cnb:spaces-per-octave) (/ 12 cnb:semitones-per-staff-space))



% calcuate all pitches for a key signature based upon the association list
% of accidentals (sharps or flats)
#(define (cnb:keysig-pitches alteration-alist tonic-pitch middle-c-position)
  (let* (
          (semi                   (ly:pitch-semitones tonic-pitch))
          (tonic-steps            (floor (ly:pitch-steps tonic-pitch)))
          (tonic-octave           (ly:pitch-octave tonic-pitch))
          (tonic-alteration       (ly:pitch-alteration tonic-pitch))
          (tonic-tones-asc        (+ tonic-steps 7))
          (octaves-above-middle-c (floor (/ (* -1 middle-c-position) 6)))
          (current-octave         (+ tonic-octave octaves-above-middle-c)))
      (map (lambda (t)
               (let* (
                       (tonic-index-tmp    (+ t tonic-tones-asc))                  
                       (from-tonic-index   (- tonic-index-tmp (if (> tonic-index-tmp 6) 7 0)))
                       (current-alteration (assq from-tonic-index alteration-alist)))  
                  (set! current-octave (+ current-octave (if (and (> t 0) (eq? 0 from-tonic-index)) 1 0)))
                  (ly:make-pitch current-octave from-tonic-index (if current-alteration (cdr current-alteration) 0)))
               ) '(0 1 2 3 4 5 6 7))))


#(define (cnb:notehead-ledgers y-offset y-extent mag custom-ledger-cnt)  
  (let* (
          (y-min             (/ (* 2 (+ y-offset (car y-extent))) mag))
          (y-max             (/ (* 2 (+ y-offset (cdr y-extent))) mag))
          (y-offset-demag    (inexact->exact (floor (/ (* 2 y-offset) mag))))
          (between?          (lambda (y) (and (>= y y-min) (<= y y-max))))
          (ledger-positions (if (eq? custom-ledger-cnt 0)
                                cnb:ledger-positions
                                (or (hashv-ref cnb:ledgers-by-notehead-position y-offset-demag) '())
                                ))
          (ledgers          (if (eq? custom-ledger-cnt 0)
                                (filter between? ledger-positions)
                                ledger-positions)))   
      (newline)
      (map (lambda (y)
          (* y mag 1/2)
         ) ledgers)))


% TODO: Modify for custom ledgers
#(define (cnb:add-ledgers notehead-stencil ledger-offsets x-offset grob mag custom-ledger-cnt)
     (let* (
             (stencil       notehead-stencil)
             (x-extent      (ly:stencil-extent stencil 0))
             (width         (- (cdr x-extent) (car x-extent)))
             (ledger-length (* width 4/3))
             (start         (-(car x-extent)(* width 1/6)))
             )
        (for-each (lambda (x)
           (let* (
                   (current-stencil #f))
             
                   (set! current-stencil                    
                      (if (eq? custom-ledger-cnt 0)                    
                       (grob-interpret-markup grob                                                        
                          (markup 
                             #:override `((thickness . ,(* 2 mag)))
                             #:translate `(,start . ,x)
                             #:draw-line `(,ledger-length . 0)))
                        (let* (
                                (entry (hashv-ref cnb:ledgers-by-offset (/ x mag)))   
                                (color (or (assq-ref entry 'color) black))
                                (dash      (assq-ref entry 'dash ))
                                (thickness (* mag (or (assq-ref entry 'thickness ) 2) ))
                                (len-factor (or (assq-ref entry 'length-factor) 1.0))
                                (adj-len (* ledger-length len-factor))
                                (adj-start (-(car x-extent)(* width 1/6 len-factor)))
                                )
                          
                            (grob-interpret-markup grob                                                                       
                                  (if (not dash)
                                    (markup  
                                      #:override `((thickness . ,thickness))
                                       #:translate `(,adj-start . ,x)
                                       #:with-color color
                                       #:draw-line `(,adj-len . 0))
                                    (markup  
                                      #:override `((thickness . ,thickness) (on . ,(assq-ref dash 'on )) (off . ,(assq-ref dash 'off )))
                                       #:translate `(,adj-start . ,x)
                                       #:with-color color
                                      #:draw-dashed-line `(,adj-len . 0)))
                                    ))))                                                     
               (set! stencil (ly:stencil-add current-stencil stencil)))
         ) ledger-offsets)
       
         stencil)
   
   )


% generate the markup list of noteheads for the key signature
#(define (cnb:keysig-markup-list keysig-pitches middleCPosition mag grob)
       ; start with a gold bar separator for the key signature section 
       (let* (
               (base-x-offset         (* mag 1))
               (cumulative-stencil    #f)
               (bar-stencil           #f)
               (bar-y-max             (cnb:spaces-per-octave))
               (bar-y-min             (* -1 (cnb:spaces-per-octave)))
               (custom-ledger-cnt     (cnb:custom-ledger-count))
               (x-offset              #f)
               (max-notehead-width    0)
               (max-notehead-x-offset 0))

          ; iterate over all the key signature pitches and add the associated notehead to the stencil with ledgers
          (for-each (lambda(i)
            (let* (             
                    (semi                 (ly:pitch-semitones (list-ref keysig-pitches i)))
                    (cnb-crotchet-stencil (cnb:get-note-stencil-rec-for-keysig (list (modulo semi 12) 2) grob))
                    (x-extent             (ly:stencil-extent cnb-crotchet-stencil 0))
                    (y-extent             (ly:stencil-extent cnb-crotchet-stencil 1))
                    (width                (- (cdr x-extent) (car x-extent)))
                    (x-offset             (+ base-x-offset (if (even? i) 0 width)))
                    (y-offset             (* (+ semi (* 2 middleCPosition)) (/ 1 cnb:semitones-per-staff-space) mag ))
                    (ledger-offsets       (cnb:notehead-ledgers y-offset y-extent mag custom-ledger-cnt))
                    (stencil              (ly:stencil-translate cnb-crotchet-stencil `(,x-offset . ,y-offset)))
                    (stencil-with-ledgers (cnb:add-ledgers stencil ledger-offsets x-offset grob mag custom-ledger-cnt))
                    )

              (if (> x-offset max-notehead-x-offset) (set! max-notehead-x-offset x-offset))
              (if (> width max-notehead-width) (set! max-notehead-width width))
              
              (set! cumulative-stencil 
                    (if (not cumulative-stencil) stencil-with-ledgers 
                          (ly:stencil-add cumulative-stencil stencil-with-ledgers)
                        )))
          ) (iota (length keysig-pitches) 0))


          ; ensure that the notehead is visible above the ledger
          (for-each (lambda(i)
            (let* (             
                    (semi                 (ly:pitch-semitones (list-ref keysig-pitches i)))
                    (cnb-crotchet-stencil (cnb:get-note-stencil-rec-for-keysig (list (modulo semi 12) 2) grob))
                    (x-extent             (ly:stencil-extent cnb-crotchet-stencil 0))
                    (y-extent             (ly:stencil-extent cnb-crotchet-stencil 1))
                    (width                (- (cdr x-extent) (car x-extent)))
                    (x-offset             (+ base-x-offset (if (even? i) 0 width)))
                    (y-offset             (* (+ semi (* 2 middleCPosition)) (/ 1 cnb:semitones-per-staff-space) mag ))
                    (stencil              (ly:stencil-translate cnb-crotchet-stencil `(,x-offset . ,y-offset))))
                            
              (set! cumulative-stencil 
                    (if (not cumulative-stencil) stencil 
                          (ly:stencil-add cumulative-stencil stencil)
                        )))
          ) (iota (length keysig-pitches) 0))


          (set! x-offset (- max-notehead-x-offset (/ max-notehead-width 2)))          
          (set! bar-stencil
            (ly:stencil-translate
              (ly:stencil-scale  
                  (grob-interpret-markup grob
                    (markup  
                      #:with-color cnb:gold
                      #:override `((thickness . 4))
                      #:translate `(0 . ,bar-y-min)
                      #:draw-line `(0 . ,(* 2 bar-y-max))))                  
                       mag mag) 
                         (cons x-offset 0)))


          (set! cumulative-stencil (ly:stencil-add bar-stencil cumulative-stencil))

       cumulative-stencil))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    KEY SIGNATURE CACHE & ENGRAVER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define cnb:key-signature-stencil-cache '())

#(define (cnb:get-key-signature-stencil grob context)
    (let* ( 
            (keySignature      (ly:context-property context 'keySignature))
            (stencil           (assq-ref cnb:key-signature-stencil-cache keySignature))
            (alteration-alist  #f)
            (context2          #f)
            (tonic-pitch       #f)
            (mag               #f)            
            (middleCPosition   #f)
            (keysig-pitches    #f)
            )
      (if (not stencil)
          (begin 
            (set! alteration-alist (ly:grob-property grob 'alteration-alist))
            (set! tonic-pitch      (ly:context-property context 'tonic))
            (set! mag              (magstep (ly:grob-property grob 'font-size 0.0)))            
            (set! middleCPosition  (ly:context-property context 'middleCPosition))
            (set! keysig-pitches   (cnb:keysig-pitches alteration-alist tonic-pitch middleCPosition))
            (set! stencil          (cnb:keysig-markup-list keysig-pitches middleCPosition mag grob))
            (set! cnb:key-signature-stencil-cache (assq-set! cnb:key-signature-stencil-cache keySignature stencil))    
            ))
      stencil
   ))

#(define cnb-key-signature-engraver
  (lambda (context)
    (make-engraver
      (acknowledgers
        ((key-signature-interface engraver grob source-engraver)
         (let* ((stencil (cnb:get-key-signature-stencil grob context)))
             (set! (ly:grob-property grob 'stencil) stencil)))))))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STAFF SYMBOL ENGRAVER AND TRANSFORMER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define cnb-staff-symbol-engraver
  (lambda (context)
    (make-engraver
      (acknowledgers
        ((staff-symbol-interface engraver grob source-engraver)
          (if (eq? (length (cnb:staff-lines)) 0)
            (begin
              (set! (ly:grob-property grob 'line-positions) cnb:staff-line-positions)
              (set! (ly:grob-property grob 'ledger-positions) cnb:ledger-positions)))
      )))))



#(define (cnb:sequence a b)
         (define (range first last)
           (if (> first last)
               '()
               (cons first (range (+ first 1) last))))
         (let (
             (min (if (< a b) a b))
             (max (if (>= a b) a b)))
            (range min max)
         ))

#(define (cnb:display-hash-table ht)
   (display (hash-table->alist ht))
)

#(define cnb:default-staff-line-thickness 2)
#(define cnb:default-staff-line-color "#000000")

#(define cnb:staff-and-ledger-lines '())


#(define (is-staff-def? x) (eq? (assq-ref x 'type) 'staff-line))
#(define (cnb:staff-lines) 
     (filter is-staff-def? cnb:staff-and-ledger-lines))


#(define cnb:ledgers-by-notehead-position (make-hash-table 100))
#(define cnb:ledgers-by-offset (make-hash-table 100)) 



#(define (cnb:add-if-not-exists lst x)
  (let* ( (appended lst))
    (cond
      ((eq? (length appended) 0)
        (set! appended (append lst (list x))))
      ((not(memq x lst))
        (set! appended (append lst (list x))))
      )
    appended
  ))

#(define (cnb:populate-ledger-hashes)
   (define (is-ledger-def? x) (eq? (assq-ref x 'type) 'ledger-line))
   (let* (
           (ledger-line-defs (filter is-ledger-def? cnb:staff-and-ledger-lines))
           )

     
     (for-each (lambda (def)
        (let (
              (offset (assq-ref def 'offset))
              (for-notehead-positions (assq-ref def 'for-notehead-positions)))
          (for-each (lambda (pos)
             (let* ((entry (hashq-ref cnb:ledgers-by-notehead-position pos)))
               (if (not entry)
                   (set! entry (list offset))
                   (set! entry (cnb:add-if-not-exists entry offset)))
               (hash-set! cnb:ledgers-by-notehead-position pos entry)
               )
          ) for-notehead-positions)
            (hash-set! cnb:ledgers-by-offset (* offset .5) def)
          )
           
     ) ledger-line-defs)))


#(define (cnb:custom-ledger-count) (hash-count (const #t) cnb:ledgers-by-notehead-position))

%note: notehead-position varies with magnification (/ mag)
#(define (cnb:custom-ledger-positions)
   '(lambda (staff-symbol notehead-pos)
       (let* ((ss (ly:grob-property staff-symbol 'staff-space))
              (mag                 (if (eq? ss '()) 1 ss)) 
              (positions (hashq-ref cnb:ledgers-by-notehead-position notehead-pos))
              )
       (if 
           (not positions)
           '()
           positions))))


#(define (cnb:custom-ledger-line grob orig)
   (if (not (ly:stencil? orig)) (grob-interpret-markup grob (markup "")) 
      (let*  (
          (note-heads (ly:grob-array->list(ly:grob-object grob 'note-heads)))
          (note-head (first note-heads))
          (expr (ly:stencil-expr orig))
          (mag (magstep (ly:grob-property note-head 'font-size 0.0)))
          (third-item (third expr))
          (stencils (if (eq? (car third-item) 'translate-stencil) (list third-item) (cdr (third expr))))
          (stencil-params 
           (map (lambda (s)
                  `(
                    (y-offset . ,(cdr (second s)))
                    (x-start . ,(second (third s)))
                    (x-end . ,(third (third s))))                             
                  ) stencils))
          (new-stencil #f)
          (nh-recs 
           (map (lambda (nh) 
                    (ly:grob-property nh 'Y-offset)
                    ) note-heads)))

          (for-each (lambda (x)
             (let* (
                     (y-offset (assq-ref x 'y-offset))
                     (entry (hashv-ref cnb:ledgers-by-offset (/ y-offset mag)))
                     (start (abs (assq-ref x 'x-start)))
                     (end (assq-ref x 'x-end))
                     (color (or (assq-ref entry 'color) black))
                     (dash      (assq-ref entry 'dash ))
                     (thickness (* mag (or (assq-ref entry 'thickness ) 2) ))
                     (len (- end start))
                     (len-factor (or (assq-ref entry 'length-factor) 1.0))
                     (adj-len (* len len-factor))
                     (adj-start (- start (/ (- adj-len len) 2)))
                     (stencil (grob-interpret-markup grob                                                                       
                        (if (not dash)
                          (markup  
                            #:override `((thickness . ,thickness))
                             #:translate `(,adj-start . ,y-offset)
                             #:with-color color
                             #:draw-line `(,adj-len . 0))
                          (markup  
                            #:override `((thickness . ,thickness) (on . ,(assq-ref dash 'on )) (off . ,(assq-ref dash 'off )))
                             #:translate `(,adj-start . ,y-offset)
                             #:with-color color
                            #:draw-dashed-line `(,adj-len . 0)))
                          )))
                      
             (set! new-stencil (if (not new-stencil) stencil (ly:stencil-add new-stencil stencil))))                      
            ) stencil-params)

      new-stencil
      )
      )) 


#(define (cnb:staff-line-positions-from-line-def grob)
   (let* ((ss (ly:grob-property grob 'staff-space)))
      (map (lambda(x)
          (assq-ref x 'offset)
          ) (cnb:staff-lines) ))) 

#(define cnb:default-staff-line-thickness 2)
#(define cnb:default-staff-line-color "#000000")

#(define (cnb:custom-staff-symbol grob orig)
  (let* (
          (lc                  (ly:grob-property grob 'line-count))
          (ss                  (ly:grob-property grob 'staff-space))
          (mag                 (if (eq? ss '()) 1 ss))
          (xex                 (ly:stencil-extent orig X))
          (cumulative-stencil  #f)
          (current-stencil     #f)
         )

        (for-each (lambda (i)
          (let* (
                  (line-def  (list-ref (cnb:staff-lines) i))       
                  (y-offset (* (assq-ref line-def 'offset ) mag .5))
                  (dash      (assq-ref line-def 'dash ))
                  (thickness (assq-ref line-def 'thickness ))
                  (color     (assq-ref line-def 'color )))
                
            (set! thickness (* (if (not thickness) cnb:default-staff-line-thickness thickness) mag))
            (set! color (if (not color) cnb:default-staff-line-color color))
            
                              
            (set! current-stencil 
                  (ly:stencil-in-color
                (grob-interpret-markup grob 
                  (if (not dash)
                    (markup  
                      #:override `((thickness . ,thickness))
                      #:translate `(0 . ,y-offset)
                      #:draw-line `(,(cdr xex) . 0))
                    (markup  
                      #:override `((thickness . ,thickness) (on . ,(assq-ref dash 'on )) (off . ,(assq-ref dash 'off )))
                      #:translate `(0 . ,y-offset)
                      #:draw-dashed-line `(,(cdr xex) . 0)))
                    )
                color))      
            (set! cumulative-stencil (if (not cumulative-stencil)
                  current-stencil (ly:stencil-add cumulative-stencil current-stencil)))
            ))

            (iota (length (cnb:staff-lines)) 0))
          cumulative-stencil))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  REGISTER ENGRAVERS & MISC. SETTINGS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\layout {
  \context {
    \Staff
    \consists \cnb-clef-engraver
    \consists \cnb-notehead-engraver
    \consists \cnb-key-signature-engraver
    \consists \cnb-staff-symbol-engraver

    \override Accidental.stencil = ##f
    \override NoteHead.stem-attachment = #(lambda (grob) (cnb:stem-attachment grob))
    \override Stem.no-stem-extend = ##t
    \override NoteHead.layer = #999     
    \override LedgerLineSpanner.layer = #998
    \override Stem.note-collision-threshold = #cnb:collision-threshold
    \override NoteCollision.note-collision-threshold = #cnb:collision-threshold 

  }
}  


\paper {
  indent = #0
  left-margin = #5
  right-margin = #5
  system-system-spacing =
    #'((basic-distance . 12) 
       (minimum-distance . 8)
       (padding . 4)
       (stretchability . 60)) % defaults: 12, 8, 1, 60
}


%\new Staff
%  \with {
%        \magnifyStaff #7/4
%      }
%
%\relative {
%   \clef treble
%   \key dis \major
%   \time 4/4
%    c'4 cis4 d4 dis4 | e4 f4 fis4 g4 | gis4 a4 ais4 b4 |  c4 cis4 d4 dis4 | e4 f4 fis4 g4 | gis4 a4 ais4 b4 
%
%   \fine
% }