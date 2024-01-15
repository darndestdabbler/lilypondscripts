\version "2.24.2"

\include "Kite-4-369-Notation.ly"
%\include "Oval-2-3579-Notation.ly"
%\include "Dozenal-4-369-Notation.ly"
%\include "Dozenal-3-48-Notation.ly"
%\include "FlatOval-3-48-Notation.ly"   % **like Clairnote DN
%\include "Semibreve-2-06-Notation.ly"
%\include "ChromaticNotationBase.ly" % default produces Oval 2-024 Notation
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
  \bookOutputName #(string-append "Chromatic Progression" cnb:file-suffix)
  \header {
    title="Chromatic Progression"
  }

  \markup  { #cnb:notation-label \footnote "*" #cnb:notation-footnote }

  \paper {
    indent = #cnb:indent  
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
     \time 5/4
     \key c \major %% key needs to be explicitly set!
     \clef treble
      c4 cis4 d4 dis4 e4 | f4 fis4 g4 gis4 a4 | ais4 b4 c4 cis4 d4 | dis4 e4 f4 fis4 g4 | gis4 a4 ais4 b4 c4 | 
     \fine
   }

  \new Staff
    \with {
          \magnifyStaff #cnb:default-magnify
        }
  
  \relative {
    \time 5/4
     \key c \major %% key needs to be explicitly set!
     \clef treble
      c''4 cis4 d4 dis4 e4 | f4 fis4 g4 gis4 a4 | ais4 b4 c4 cis4 d4 | dis4 e4 f4 fis4 g4 | gis4 a4 ais4 b4 c4 | 
     \fine
   }

}
 