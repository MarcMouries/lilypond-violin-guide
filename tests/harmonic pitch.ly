\version "2.19.15"
\language "english"
\include "violin-functions.ly"

\layout {indent=0 }

harmonicsG = {
 % \override Staff.NoteColumn #'ignore-collision = ##t
 % \override NoteHead #'style = #'harmonic-mixed
  \new Voice  {
    << { <g_2 b \harmonic >  <g c'_3 \harmonic > <g d'_4 \harmonic > <g e'_3 \harmonic >}
        \\
       { \harmonicPitch  b''  
         \harmonicPitch  g'' 
         \harmonicPitch  d''  
         \harmonicPitch  b''}
    >>
  }
}



\score {
    \new Staff { \harmonicsG }
  \layout { }
}



% ****************************************************************
% HARMONICS 
% ****************************************************************
scaleHarmonics = \relative c' {
\autoBeamOff
<d _0  g -3\harmonic>4 <e -1  a -4\harmonic>
<fs-1  b -4\harmonic>  <g -1  c -4\harmonic>
}


\score {\new Staff { \scaleHarmonics }}


% ****************************************************************
% HARMONICS WITH PITCH
% ****************************************************************
scaleHarmonicsWithPitch = \relative c' {
\autoBeamOff
<<
  {
    \oneVoice
    \stemDown
    <d _0  g _3\harmonic>8 <e _1  a _4\harmonic>
    <fs-1  b _4\harmonic>  <g _1  c _4\harmonic>
  }
   \\
  {
    \stemUp
   % \oneVoice
   \harmonicPitch  d'8
   \harmonicPitch  e
   \harmonicPitch  f
   \harmonicPitch  g 
  }
>>
}


\score {\new Staff { \scaleHarmonicsWithPitch }}

%% http://lsr.di.unimi.it/LSR/Item?id=544

\relative c'' {
  \override Staff.NoteColumn.ignore-collision = ##t
  \override NoteHead.style = #'harmonic-mixed
  <<
    {
      \oneVoice
      <a_0 e'_2 \harmonic>4
      <a_0 d_1   \harmonic>4
    }
    \\
    {
      %\oneVoice
      \tiny
      \override Stem.stencil = ##f
      \override Flag.stencil = ##f
      <\parenthesize e''>
      <\parenthesize e>
    }
  >>
}


%% http://lsr.di.unimi.it/LSR/Item?id=485

har =
#(define-music-function ( note) (ly:music?)
  #{ 
    %\tweak style #'harmonic-mixed
     $note #})
 
%% Remark:
%% change to next line, during 2.20-upgrade
%% har = \tweak style #'harmonic-mixed \etc
  
{
 <c' \har c''>2 <c' \har c''>4 <c' \har c''>8 <c' \har c''>
}