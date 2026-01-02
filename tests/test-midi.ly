\version "2.24.4"

% #(define my-instrument-equalizer-alist '())
% 
% #(set! my-instrument-equalizer-alist
%   (append
%     '(
%       ("flute" . (0.7 . 0.9))
%       ("clarinet" . (0.3 . 0.6)))
%     my-instrument-equalizer-alist))
% 
% #(define (my-instrument-equalizer s)
%   (let ((entry (assoc s my-instrument-equalizer-alist)))
%     (if entry
%       (cdr entry))))



#(define instrument-eq-settings
  '(("flute"    . (0.7 . 0.9))
    ("clarinet" . (0.3 . 0.6))))

#(define (lookup-instrument-eq instrument-name)
  (assoc-ref instrument-eq-settings instrument-name))



\score {
  <<
    \new Staff {
      \key g \major
      \time 2/2
      \set Score.instrumentEqualizer = #lookup-instrument-eq
      \set Staff.midiInstrument = "flute"
      \new Voice \relative {
        r2 g''\mp g fis~
        4 g8 fis e2~
        4 d8 cis d2
      }
    }
    \new Staff {
      \key g \major
      \set Staff.midiInstrument = "clarinet"
      \new Voice \relative {
        b'1\p a2. b8 a
        g2. fis8 e
        fis2 r
      }
    }
  >>
  \layout { }
  \midi {  }
}