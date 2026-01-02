 \version "2.18.0"

stringNumberSpanner =
#(define-music-function (parser location StringNumber music)
   (markup? ly:music?)
   (define (add-event mus event)
     (let ((prop (if (music-is-of-type? mus 'rhythmic-event)
		     'articulations 'elements)))
       (set! (ly:music-property mus prop)
	     (append (ly:music-property mus prop) (list event)))))
   (let ((elts (extract-typed-music music '(rhythmic-event event-chord))))
     (if (pair? elts)
	 (begin
	   (add-event (first elts)
		      #{
			\tweak style #'solid
			\tweak font-size #-5
			\tweak bound-details.left.stencil-align-dir-y #CENTER
			\tweak bound-details.left.text
			   \markup { \circle \number $StringNumber }
			\startTextSpan
		      #})
	   (add-event (last elts) #{ \stopTextSpan #}))))
   music)

\relative c {
 \clef "treble_8"
 \textSpannerDown
 \stringNumberSpanner "5" { a8 b c d e f }
 \stringNumberSpanner "4" { g a bes4 a g2 }
}
