% file: include-pattern_tune.ly
\version "2.24.4"
\header { title = "Song (Original Key)" }

#(define is-standalone #t)

originalKey = a
originalMode = #minor  % just # and the name

% Variable containing your music in the original key
music = \relative c' {
  \key \originalKey \originalMode
  a4 b c d | e2 e |
  f4 e d b | a1 |
}

% If 'is-standalone' is NOT defined, render the score block.
#(if (defined? 'is-standalone)
     (add-score #{
        \score {
          \new Staff { \music }
          \layout { }
        }
     #}))
