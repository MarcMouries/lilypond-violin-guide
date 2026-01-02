% file: include-pattern_tune_(Dm).ly
\version "2.24.4"
\include "./include-pattern_tune.ly"

% what's an easy way to store the metadata for transposition?

targetKey = d

\score {
  \new Staff {
    \transpose \originalKey \targetKey { \music }
  }
  \layout { }
}
