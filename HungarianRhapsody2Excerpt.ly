\version "2.24.2"

#(define cnb:file-suffix "-ConventionalNotation")
#(define cnb:notation-label "Conventional Notation")
#(define cnb:notation-footnote "Conventional Notation")

\include  "Kite-4-369-Notation.ly"
%\include  "Oval-2-3579-Notation.ly"


\book {
  \bookOutputName #(string-append "HungarianRhapsody2Excerpt" cnb:file-suffix)
  \header {
    title="Excerpt from Hungarian Rhapsody 2 (345-348)"
    composer = "Franz Liszt"
  }

  \markup  { #cnb:notation-label \footnote "*" #cnb:notation-footnote }


%if explicitly setting paper indent, use this variable to ensure 
%that custom ledger lines are aligned properly 
#(set! cnb:indent  10)

  \paper {
    indent = #cnb:indent
    left-margin = #10
    right-margin = #10
    system-system-spacing =
      #'((basic-distance . 12) 
         (minimum-distance . 8)
         (padding . 8)
         (stretchability . 60)) % defaults: 12, 8, 1, 60
  }
  
  \new PianoStaff 
  \with {
    \override StaffGrouper.staff-staff-spacing = #'(
                              (basic-distance . 15)
                              (padding . 10))
  }
  <<
  \new Staff
  \with {
        \magnifyStaff #7/4
  
      }
  \relative 
      c 
      {
      \set Staff.printKeyCancellation = ##f
      \set Score.currentBarNumber = #345
      \clef treble
      \time 2/4 
      \key fis \major
      \ottava #1
     <cis'' eis cis'>8-. ^([ <d fis d'>8-.  <dis fisis dis'>8-.  <e gis e'>8-.  ]      
     <f a f'>8-.[ <e gis e'>8-. <dis! fisis dis'!>8-. <d \tweak Accidental.restore-first ##f fis! d'>8-. ])
     <dis! fisis dis'!>8-.^([ <e gis e'>8-. <eis gisis eis'>8-. <\tweak Accidental.restore-first ##f fis ais! fis'>8-. ]
     <g b g'>8-. ^[ <\tweak Accidental.restore-first ##f fis ais fis'>8-. <eis gisis eis'>8-.  <e \tweak Accidental.restore-first ##f gis e'>8-. ])
   }
   \new Dynamics {
     s2\f\< s\!     \> s\!     \< s\!     \> s\! 
   }
   \new Staff
  \with {
        \magnifyStaff #7/4
      }
      \relative 
      c
      {
      \set Staff.printKeyCancellation = ##f
      \clef bass
      \time 2/4 
      \key fis \major
     <cis cis'>8-.[ <bis bis'>8-. <b b'>8-. <ais! ais'!>8-.]
     <a a'>8-.[ <ais ais'>8-. <b! b'!>8-. <bis bis'>8-.]
     <b! b'!>8-.[ <ais! ais'!>8-. <gisis gisis'>8-. < \tweak Accidental.restore-first ##f gis! \tweak Accidental.restore-first ##f gis'!>8-.]
     <g g'>8-.[ < \tweak Accidental.restore-first ##f gis! \tweak Accidental.restore-first ##f gis'!>8-. <a a'>8-. <ais! ais'!>8-.]
      }
   
  >>
  
}