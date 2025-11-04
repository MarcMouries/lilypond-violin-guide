\version "2.24.0"
\language "english"


% ****************************************************************
% Helper functions
% ****************************************************************

% shortcut for the \typewriter command
#(define-markup-command (code layout props text) (string?)
  (interpret-markup layout props (markup #:typewriter text)))

% 3 columns layout
#(define-markup-command (example layout props left right_text) (markup? markup?)
   (interpret-markup layout props
      (markup
          #:column (
              #:vspace 1
              #:fill-line (
                     (#:column (left))
                     (#:column ("➡"))
                     (#:column (right_text))
              ) ;; fill-line
              #:vspace 1
          ) ;; column
)))


% --- Render music inside markup  ---
#(define-markup-command (writeMusic layout props music) (ly:music?)
  (let* ((score (ly:make-score music))
         (lydef (ly:output-def-clone $defaultlayout)))
    (ly:score-add-output-def! score lydef)
    (interpret-markup layout props (markup #:score score))))

% --- Render music inside markup (no time / clef / key / bar numbers) ---
#(define-markup-command (writeMusicNoTime layout props music) (ly:music?)
  (let* ((score (ly:make-score
                  #{
                    \new Staff \with {
                      \remove "Time_signature_engraver"
                      %\remove "Bar_number_engraver"
                      %\remove "Clef_engraver"
                      \remove "Key_engraver"
                    } { #music }
                  #}))
         (lydef (ly:output-def-clone $defaultlayout)))
    (ly:score-add-output-def! score lydef)
    (interpret-markup layout props (markup #:score score))))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MACROS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SECTION TITLE
#(define-markup-command (sectionTitle layout props title_text) (markup?)
  (interpret-markup layout props
   (markup #:column (#:vspace 1.5
                    (#:fontsize 2 #:bold #:smallCaps  title_text)
                     #:vspace 0.75))))



\paper {
  indent = 0\mm
  %line-width = 200\mm
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  %line-width = #(- line-width (* mm  3.000000) (* mm 1))
  %line-width = 180\mm - 2.0 * 1\cm
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  %line-width = #(- line-width (* mm  3.000000) (* mm 1))
     tagline = ##f 

}

% ================================================================
% Title
% ================================================================
\markup \vspace #2  
\markup {
      \fill-line {
        ""  % Left
          \column {
            \center-align \fontsize #3 \bold      "How to Write Music for Violin with Lilypond"
            \vspace #1 
            \center-align \fontsize #1 \italic    "Marc Mouries"
          }
          "" %% Right
        }
        
      }
      
% ================================================================
\markup \sectionTitle "NOTE DURATION & RHYTHM"    
% ================================================================

example_duration = \relative c' { \cadenzaOn  c1 c2 c4 c8 c16 c32  }
\markup \example 
          \writeMusicNoTime {\example_duration}  
          { \typewriter \concat {"c1 " "c2 " "c4" "c8 " "c16 " "c32 "}}  

\markup \bold { "Triplets"}  
\markup \fill-line {
  \column { 
    \writeMusicNoTime{ \relative c' { \tuplet 3/2 { d8 e f } \tupletDown \tuplet 3/2 { d8 e f }}}   
    { \line {\fontsize #-2 {\italic {"We can use" \typewriter "\\tupletDown" " to..."}}}}
  } 
  \column { "=>" } \column { \typewriter \fontsize #-1 "\\tuplet 3/2 { d8 e f } " }  
}





\markup \sectionTitle "BOWING INDICATIONS"

example_bowing = \relative c' { c2\downbow e\upbow  }
\markup \fill-line {
  \column { \score { \example_bowing }} 
  \column { "=>" }
  \column { \typewriter \concat {"c2" \bold "\downbow" " e2" \bold "\upbow"}}  
}


example_bowing = \relative c' { c2\downbow e\upbow  }
\markup \example 
          \writeMusic {\example_bowing}  
          { \typewriter \concat {"c2" \bold "\downbow" " e2" \bold "\upbow"}}  



\markup \sectionTitle "Articulations"    
example_accent = \relative c''{f^\accent e,_\accent b'-\accent}
\markup \fill-line {
  \column { \score { \example_accent }} 
  \column { "=>" }
  \column { \typewriter \concat {"f" \bold "^\accent" " e," \bold "_\accent" " b'" \bold "-\accent"}
            \typewriter \concat {"\accent" " or " \typewriter " ->"}  }
}

\markup \vspace #2  

example_staccato = \relative c''{f-. e,-. b'-.}
\markup \fill-line {
  \column { \score { \example_staccato }} 
  \column { "=>" }
  \column { \typewriter \concat {"f" \bold "^\staccato" " e," \bold "-." " b'" \bold "-." " e2"}
             \concat { \code "\staccato" " or " \code "-."}  }
}

\markup \vspace #2  

% ================================================================
\markup \sectionTitle "FINGERINGS"
% ================================================================
example_finger = \relative c' { c4-1 d-2 e-3 f-4 }
\markup \example 
          \writeMusic {\example_finger}  
          { \typewriter "{ c4-1 d-2 e-3 f-4 }"}



% String numbers (1=E, 2=A, 3=D, 4=G by convention)
example_string = \relative c' { c4-\1 d-\2 e-\3 f-\4 }
\markup \example
   \writeMusic {\example_string }
  "\\relative c' { c4-\\1 d-\\2 e-\\3 f-\\4 }"

% ================================================================
\markup \sectionTitle "HARMONICS" 
% ================================================================
\markup \bold "Flageolet"
example_flageolet_harmonic = { a'4-4\flageolet }
\markup \example
   \writeMusic {\example_flageolet_harmonic}
  
  
  { \code "a-4\flageolet" }

\markup \bold  "Natural"
example_natural_harmonic = { a'4-4\harmonic }
\markup \example
  \writeMusic {\example_natural_harmonic}
  { \code "a-4\harmonic" }

\markup \bold  "Artificial"
example_artificial_harmonic = { <e'_1 a'\harmonic>4-4 } 
\markup \example
  \writeMusic {\example_artificial_harmonic}
  { \code "<e_1 a'\harmonic>4-4>" }



% ================================================================
\markup \sectionTitle "POSITIONS"
% ================================================================


% ================================================================
\markup \sectionTitle "DOUBLE-STOPS"
% ================================================================
example_double_stops = \relative c'{ <a g' cs>2 <a fs' d'> }
\markup \example 
          \writeMusic {\example_double_stops}  
          { \typewriter \concat {"<a g' cs>2 <a fs' d'>"}}  

% ================================================================
\markup \sectionTitle "ORNAMENTS"
% ================================================================
\markup "Grace, Trill, mordent, turns, appoggiaturas"



% ================================================================
\markup \sectionTitle  "GLISSANDO"
% ================================================================
\markup  "Continuous slide or expressive shift"
example_glissando =  { c4 \glissando g e \glissando c }  


% ================================================================
\markup \sectionTitle  "LAYOUT TIPS"
% ================================================================

\markup \vspace #2  
\markup \bold { "How to remove first score indentation?"}  
\markup \fill-line {
  \column { 
    \score {
       %% NONE
       s1
    }     
  } 
  \column { "=>" }
  \column {
    \typewriter "\\layout { indent = 0\in}"
  }
}


\markup \vspace #1
\markup \bold { "Add vertical space" }
\markup \fill-line {
  \column {
    \column {
      "A"
      \vspace #1
      "B"
    }
  }
    \column { "=>" }
  \column {
    \typewriter "\\markup \"A\""
    \typewriter "\\markup \\vspace #1"
    \typewriter "\\markup \"B\""
  }
}







\markup \vspace #2  
\markup \bold { "MIDI TIPS"} 
\markup \vspace #2  
\markup \bold { "Set the MIDI instrument to Violin"}  
\markup \fill-line {
  \column { 
    \score {
       %% NONE
       s1
    }     
  } 
  \column { "=>" }     \column { \typewriter "\set Staff.midiInstrument = \"violin\"" }  
}



\markup \vspace #2  
\markup \bold { "Set the tempo of the score in the MIDI"}  
  \markuplist {
   \typewriter "
\score {
  ...music...
   \midi {
     \context {
       \Score
       tempoWholesPerMinute = #(ly:make-moment 72 4)
       }
     }
}
"}

\markup \vspace #2  




