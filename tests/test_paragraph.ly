\version "2.24.4"

\markup \vspace #2
\markup \bold "\markup { \wordwrap "
\markup { \wordwrap {
	Lorem ipsum dolor sit amet, \italic consectetur adipisicing elit, sed
	do eiusmod tempor incididunt ut labore et dolore magna aliqua.
	Ut enim ad minim veniam, quis nostrud exercitation ullamco
	laboris nisi ut aliquip ex ea commodo consequat.}
}


\markup \vspace #2
\markup \bold "\paragraph \markuplist"
paragraph = #(define-scheme-function (text) (markup-list?)
  #{ 
    \markup { \wordwrap #text } 
  #})
\paragraph \markuplist {
  "Such as " \italic "Ursstudien" " (EXAMPLE 1a) (violists might avoid "
    \italic "Ursstudien" " exercise 1B); "
    \italic "Dounis Daily Dozen" " exercise 1 (EXAMPLE 1b)."
}


% Paragraph: accept single markup or list; wrap using make-wordwrap-markup
#(define-markup-command (paraBlock layout props x) (scheme?)
  (let* ((items (if (markup-list? x) x (list x))))
    (interpret-markup layout props
      (make-override-markup
        '(baseline-skip . 2.8)
        (make-wordwrap-markup items)))))


% ── Markup commands that work with \paragraph { ... } syntax ────────────
 #(define-markup-command (paragraphM layout props items) (markup-list?)
   (interpret-markup layout props
     (make-override-markup
       '(baseline-skip . 2.8)
       (make-wordwrap-markup items))))

\markup \vspace #2
\markup \bold "\markup \paragraphM"

\markup \paragraphM {
    "Such as " \italic "Ursstudien" " (EXAMPLE 1a) (violists might avoid "
    \italic "Ursstudien" " exercise 1B); "
    \italic "Dounis Daily Dozen" " exercise 1 (EXAMPLE 1b)."
  }


\markup \vspace #2
\markup \bold "\markuplist { \paragraphJustified {}"

#(define-markup-list-command (paragraphJustified layout props args) (markup-list?)
  (interpret-markup-list layout props
   (make-justified-lines-markup-list (cons (make-hspace-markup 2) args))))

% Candide, Voltaire
\markuplist {
  \override-lines #'(baseline-skip . 2.5)
  {
    \paragraphJustified {
      Il y avait en Westphalie, dans le château de M. le baron de
      Thunder-ten-tronckh, un jeune garçon à qui la nature avait donné
      les mœurs les plus douces.  Sa physionomie annonçait son âme.
      Il avait le jugement assez droit, avec l'esprit le plus
      \concat { simple \hspace #.3 ; }
      c'est, je crois, pour cette raison qu'on le nommait Candide.  Les
      anciens domestiques de la maison soupçonnaient qu'il était fils
      de la sœur de monsieur le baron et d'un bon et honnête
      gentilhomme du voisinage, que cette demoiselle ne voulut jamais
      épouser parce qu'il n'avait pu prouver que soixante et onze
      quartiers, et que le reste de son arbre généalogique avait été
      perdu par l'injure du temps.
    }
    \vspace #.3
    \paragraphJustified {
      Monsieur le baron était un des plus puissants seigneurs de la
      Westphalie, car son château avait une porte et des fenêtres.  Sa
      grande salle même était ornée d'une tapisserie.  Tous les chiens
      de ses basses-cours composaient une meute dans le
      \concat { besoin \hspace #.3 ; }
      ses palefreniers étaient ses
      \concat { piqueurs \hspace #.3 ; }
      le vicaire du village était
      son grand-aumônier.  Ils l'appelaient tous monseigneur, et ils
      riaient quand il faisait des contes.
    }
  }
}

% ****************************************************************
% ly snippet:
% ****************************************************************
\markup {
  \wordwrap {
  Here is an example of a score within markup  asdf sadf sadf asdf on violin: 
  \score { \new Staff { <g d' a' e''>1 } },
  and another on cello: \score { \new Staff { \clef "bass" <c, g, d a> } }
}
}

