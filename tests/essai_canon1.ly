\version "2.18.2"
canon = \markup \column {"i" "n" " " "d" "i" "a"}
superius = \relative c''
  {\clef "petrucci-c1" \key f\major \time 2/2
  \set Staff.instrumentName = \markup {\override #'(font-name . "Foliar Initials")\magnify#7 {D}}
   \set Score.timing = ##f
   \set Score.defaultBarType = "empty"
   \override NoteHead #'style = #'petrucci
 r\breve r1^\signumcongruentiae g1 f g r bes a2 c2. bes4 bes1 a2 bes1 r1 a bes c bes2 a2. g4 g1 f2 g1 r1 bes1 \bar "" \break
  a2 g2. f4 f1 e2 f1 r1 bes1 c bes2 d1 c2 d1 r1 d2 d1 c r1 bes a2 c2. bes4 bes1 a2 bes1 r1 a1 bes c \bar "" \break
 bes2 a2. g4 g1 f2 g1 r2 c2 bes a2. g4 g1 f2 g2. bes4 a2 c bes a2. g4 g1 f2 g\longa \bar "||" \noBreak \hideNotes g1 g1 g1
  }
 
 \score
   {\superius
  \layout {
    line-width = 150
    ragged-last = ##t
      \set Staff.instrumentName = \markup {\override #'(font-name ."Acorn Initials")\magnify#4 {D}}
    \context {
      \Staff
      \consists Custos_engraver
      \override Custos #'style = #'mensural
      \override KeySignature #'font-size = #-2
      \override KeySignature #'X-offset = #-1.8
      \override TimeSignature #'style = #'mensural
      \override Rest #'style = #'mensural
    }
  }
   }