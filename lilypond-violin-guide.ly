\version "2.24.0"
\language "english"


% ****************************************************************
% Helper functions
% ****************************************************************

#(define-markup-command (example layout props left_text right_text) (markup? markup?)
   (interpret-markup layout props
      (markup
          #:column (
              #:vspace 1
              #:fill-line (
                     (#:column (left_text))
                     (#:column ("➡"))
                     (#:column (right_text))
              ) ;; fill-line
              #:vspace 1
          ) ;; column
)))

% shortcut for the \typewriter command
#(define-markup-command (tw layout props text) (string?)
  (interpret-markup layout props (markup #:typewriter text)))

code = #(define-markup-command (code layout props s) (string?)
         (interpret-markup layout props (markup #:typewriter s)))

% 3 columns layout
#(define-markup-command (example layout props left_text right_text) (markup? markup?)
   (interpret-markup layout props
      (markup
          #:column (
              #:vspace 1
              #:fill-line (
                     (#:column (left_text))
                     (#:column ("➡"))
                     (#:column (right_text))
              ) ;; fill-line
              #:vspace 1
          ) ;; column
)))

% --- Helper: render music inside markup  ---
#(define-markup-command (writeMusic layout props music) (ly:music?)
  (let* ((score (ly:make-score music))
         (lydef (ly:output-def-clone $defaultlayout)))
    (ly:score-add-output-def! score lydef)
    (interpret-markup layout props (markup #:score score))))


#(define-markup-command (section-title layout props title) (markup?)
  (interpret-markup layout props
   (markup #:column (#:vspace 2
                    (#:fontsize 2 title)
                     #:vspace 1))))



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
\markup \section-title "NOTE DURATION & RHYTHM"    
% ================================================================
\markup \bold { "Write triplets"}  
\markup \fill-line {
  \column { 
    \score {
       \relative c' { \tuplet 3/2 { d8 e f }}
       \layout { }
    }     
  } 
  \column { "=>" }     \column { \typewriter "\\tuplet 3/2 { d8 e f }" }  
}


\markup \section-title "BOWING INDICATIONS"

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



\markup \section-title "Articulations"    
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
             \concat { \tw "\staccato" " or " \tw "-."}  }
}

\markup \vspace #2  

% ================================================================
\markup \section-title "FINGERINGS"
% ================================================================


% ================================================================
\markup \section-title "HARMONICS" 
% ================================================================
\markup "Natural"
\markup "Artificial"


% ================================================================
\markup \section-title "POSITIONS"
% ================================================================


% ================================================================
\markup \section-title "DOUBLE-STOPS"
% ================================================================
example_double_stops = \relative c'{ <a g' cs>2 <a fs' d'> }
\markup \example 
          \writeMusic {\example_double_stops}  
          { \typewriter \concat {"<a g' cs>2 <a fs' d'>"}}  

\markup \vspace #2  


% ================================================================
\markup \section-title "ORNAMENTS"
% ================================================================
\markup "Grace, Trill, mordent, turns, appoggiaturas"



% ================================================================
\markup \section-title  "GLISSANDO"
% ================================================================
\markup  "Continuous slide or expressive shift"
example_glissando =  { c4 \glissando g e \glissando c }  



\markup \bold { "LAYOUT TIPS"}  

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


\markup { "Here is an example of a score within markup"}


% ****************************************************************
% ly snippet:
% ****************************************************************
\markup {
  violin: \score { \new Staff { <g d' a' e''>1 }
                   \layout { indent=0 } } ,
  cello: \score { \new Staff { \clef "bass" <c, g, d a> }
                  \layout { indent=0 } }
}


\markup { "Here we add a score"}

soprano = \relative c' { c e g c }
alto = \relative c' { a c e g }
verse = \lyricmode { This is my song }

\score {
  \new Staff <<
    \partCombine \soprano \alto
    \new NullVoice = "aligner" \soprano
    \new Lyrics \lyricsto "aligner" \verse
  >>
  \layout {}
}


