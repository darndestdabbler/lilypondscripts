\version "2.24.2"

%\include "Kite-4-369-Notation.ly"
\include "Oval-2-3579-Notation.ly"
%\include "Dozenal-4-369-Notation.ly"
%\include "Dozenal-3-48-Notation.ly"
%\include "FlatOval-3-48-Notation.ly"   % **like Clairnote DN
%\include "Semibreve-2-06-Notation.ly"
%\include "ChromaticNotationBase.ly" % default produces Oval 2-3579 Notation
%\include "Jianpu.ly"

%compare to Clairnote (which is more fully implemented) ...
%https://github.com/PaulMorris/LilyPond-Clairnote
%clairnote-type = dn  % or = sn
%\include "clairnote.ly"

%% color-blind-friendly scheme
% #(define cnb:notehead-color-sequence #(     
%    cnb:blue  ;; semitone mod 3 = 0 (C, D#, F#, A), skyblue
%    cnb:rose  ;; semitone mod 3 = 1 (C#, E, G, A#), red-purple
%    cnb:black ;; semitone mod 3 = 2 (D, F, G#, B), black
%    ))

%% monochrome
% #(define cnb:notehead-color-sequence #(     
%    cnb-black ;; all semitones black
%    ))

\book {
  %comment out the next line while testing in Frescobaldi; otherwise, viewer can't find the file
  \bookOutputName #(string-append "JoyToTheWorld" cnb:file-suffix)
  \header {
    title="Joy to the World"
    composer = "Isaac Watts & Lowell Mason"    
  }

  \markup  { #cnb:notation-label \footnote "*" #cnb:notation-footnote }

  \paper {
    indent = 0  
    left-margin = #5
    right-margin = #5
    system-system-spacing =
      #'((basic-distance . 12) 
         (minimum-distance . 8)
         (padding . 4)
         (stretchability . 60)) % defaults: 12, 8, 1, 60
  }


  \new Staff
  \with {
        \magnifyStaff #cnb:default-magnify
      }
  \relative {
     \clef treble
     \key d \major
     \time 2/4
     d''4 cis8. b16 | a4. g8 | fis4 e | d4. a'8 |  b4. b8 | cis4. cis8 | \break
     d4. d8 | d( cis) b( a) | a8.( g16 fis8) d' | d( cis) b( a) | a8.( g16 fis8) fis | \break
     fis fis fis fis16( g) | a4. g16( fis) | e8 e e e16( fis) |  \break
     g4. fis16( e) | d8( d'4) b8 | a8.( g16 fis8) g8 | fis4 e | d2
     \fine
   }
   \addlyrics {
     \set fontSize = #0 
     Joy to the world! The Lord is come;
     Let Earth re- ceive her King;
     Let every __ _  heart __ pre- pare __ him __ room __ And
     hea- ven and nature sing And 
     hea- ven and nature sing And 
     heaven and heaven and na- ture sing.
   }
}