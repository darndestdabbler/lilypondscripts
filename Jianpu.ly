\version "2.24.2"
#(use-modules (srfi srfi-9))

#(define cnb:file-suffix "-JianpuNotation")
#(define cnb:notation-label "Jianpu Notation")
#(define cnb:notation-footnote "*https://en.wikipedia.org/wiki/Numbered_musical_notation")
#(define cnb:default-magnify 6/4)
#(define cnb:indent 0)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            DIATONIC MAP
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Map to retrieve the jianpu diatonic step and alteration from
%%     (a) the note's pitch and (b) the key's tonic pitch
%% NOTE: outer index is function of tonic pitch/alter: (* 2 (+ tonic-semis-mod12 tonic-alter ))
%%       inner index is function of note's pitch: (modulo (- note-semis tonic-semis) 12)) 
%% NOTE: the outer dimension has some gaps; hence, #f
%% Alteration values:
%%     9: omit alteration symbol
%%     0: emit natural
%%     1: emit sharp
%%    -1: emit flat
#(define ji:diatonic-map (vector
   ;;C
   `((note-step  . ,(vector  1  1  2  2    3  4  4  5    5  6  6  7))    
                         ;;  C  C# D  D#   E  F  F# G    G# A  A# B
     (note-alter . ,(vector  9  1  9  1    9  9  1  9    1  9  1  9)))   
	 
   ;;D flat
   `((note-step  . ,(vector  1  1  2  2    3  4  4  5    5  6  6  7))    
                         ;;  Db D  Eb E    F  Gb G  Ab   A  Bb B  C
     (note-alter . ,(vector  9  0  9  0    9  9  0  9    0  9  0  9)))

   #f	

   ;;C sharp
   `((note-step  . ,(vector  1  2  2  3    3  4  5  5    6  6  7  7))    
                         ;;  C# D  D# E    E# F# G  G#   A  A# B  B#
     (note-alter . ,(vector  9  0  9  0    9  9  0  9    0  9  0  9)))   
	 
   ;;D
   `((note-step  . ,(vector  1  1  2  3    3  4  4  5    5  6  7  7))    
                         ;;  D  D# E  F    F# G  G# A    A# B  C  C#   
     (note-alter . ,(vector  9  1  9  0    9  9  1  9    1  9  0  9)))   
	 
   ;;E flat
   `((note-step  . ,(vector  1  1  2  3    3  4  4  5    5  6  7  7))    
                         ;;  Eb E  F  Gb   G  Ab A  Bb   B  C  Db D
     (note-alter . ,(vector  9  0  9 -1    9  9  0  9    0  9 -1  9)))	

   #f	
   #f

   ;;E
   `((note-step  . ,(vector  1  2  2  3    3  4  4  5    6  6  7  7))    
                         ;;  E  F  F# G    G# A  A# B    C  C# D  D#   
     (note-alter . ,(vector  9  0  9  0    9  9  1  9    0  9  0  9))) 

   #f
   
   ;;F
   `((note-step  . ,(vector  1  2  2  3    3  4  4  5    6  6  7  7))    
                         ;;  F  Gb G  Ab   A  Bb B  C    Db D  Eb E
     (note-alter . ,(vector  9 -1  9 -1    9  9  0  9   -1  9 -1  9))) 
	 
   ;;G flat	 
   `((note-step  . ,(vector  1  1  2  2    3  3  4  5    5  6  6  7))    
                         ;;  Gb G  Ab A    Bb Cb C  Db   D  Eb E  F
     (note-alter . ,(vector  9  0  9  0    9  9  0  9    0  9  0  9)))   
	 
   #f	

   ;;F sharp
   `((note-step  . ,(vector  1  2  2  3    3  4  5  5    6  6  7  7))    
                         ;;  F# G  G# A    A# B  C  C#   D  D# E  E#     
     (note-alter . ,(vector  9  0  9  0    9  9  0  9    0  9  0  9)))
	 
   ;;G
   `((note-step  . ,(vector  1  1  2  2    3  4  4  5    5  6  7  7))    
                         ;;  G  G# A  A#   B  C  C# D    D# E  F  F#      
     (note-alter . ,(vector  9  1  9  1    9  9  1  9    1  9  0  9)))   

   ;;A flat
   `((note-step  . ,(vector  1  1  2  2    3  4  4  5    5  6  7  7))    
                         ;;  Ab A  Bb B    C  Db D  Eb   E  F  Gb G  
     (note-alter . ,(vector  9  0  9  0    9  9  0  9    0  9 -1  9)))		
   
   #f	
   #f	

   ;;A
   `((note-step  . ,(vector  1  1  2  3    3  4  4  5    6  6  7  7))    
                         ;;  A  A# B  C    C# D  D# E    F  F# G  G#       
     (note-alter . ,(vector  9  1  9  0    9  9  1  9    0  9  0  9)))   

   ;;B flat
   `((note-step  . ,(vector  1  1  2  3    3  4  4  5    6  6  7  7))    
                         ;;  Bb B  C  Db   D  Eb E  F    Gb G  Ab A      
     (note-alter . ,(vector  9  0  9 -1    9  9  0  9   -1  9 -1  9)))	

   #f	
   
   ;;C flat
   `((note-step  . ,(vector  1  1  2  2    3  4  4  5    5  6  6  7))  
                         ;;  Cb C  Db D    Eb Fb F  Gb   G  Ab A  Bb   
     (note-alter . ,(vector  9  0  9  0    9  9  0  9    0  9  0  9)))

   ;;B
   `((note-step  . ,(vector  1  2  2  3    3  4  5  5    6  6  7  7))    
                         ;;  B  C  C# D    D# E  F  F#   G  G# A  A#        
     (note-alter . ,(vector  9  0  9  0    9  9  0  9    0  9  0  9)))      
   ))  	


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     SYMBOL PATHS AND VECTORS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define ji:flat-path '(
  (moveto 0.172 0.6497)
  (lineto 0.1688 0.4395)
  (lineto 0.1688 0.4045)
  (curveto 0.1688 0.3344 0.172 0.2643 0.1815 0.1943)
  (curveto 0.3248 0.3153 0.4777 0.449 0.4777 0.6369)
  (curveto 0.4777 0.742 0.4331 0.8503 0.3408 0.8503)
  (curveto 0.242 0.8503 0.1752 0.7548 0.172 0.6497)
  (closepath)
  (moveto 0.0382 0.0796)
  (lineto 0 1.9745)
  (curveto 0.0255 1.9904 0.0573 2 0.086 2)
  (curveto 0.1146 2 0.1465 1.9904 0.172 1.9745)
  (lineto 0.1497 0.8758)
  (curveto 0.2293 0.9427 0.3344 0.9841 0.4395 0.9841)
  (curveto 0.6051 0.9841 0.7229 0.8312 0.7229 0.6592)
  (curveto 0.7229 0.4045 0.449 0.2866 0.2548 0.121)
  (curveto 0.207 0.0796 0.1783 0 0.1115 0)
  (curveto 0.0701 0 0.0382 0.035 0.0382 0.0796)
  (closepath)))
#(define ji:natural-path '(
  (moveto 0 1.9817)
  (curveto 0.0209 1.9921 0.0445 2 0.0654 2)
  (curveto 0.0864 2 0.1073 1.9921 0.1283 1.9817)
  (lineto 0.123 1.5026)
  (lineto 0.4005 1.555)
  (lineto 0.4084 1.555)
  (curveto 0.4346 1.555 0.4555 1.5366 0.4555 1.5105)
  (lineto 0.4738 0.0183)
  (curveto 0.4529 0.0079 0.4293 0 0.4084 0)
  (curveto 0.3874 0 0.3665 0.0079 0.3455 0.0183)
  (lineto 0.3508 0.4974)
  (lineto 0.0733 0.445)
  (lineto 0.0654 0.445)
  (curveto 0.0393 0.445 0.0183 0.4634 0.0183 0.4895)
  (closepath)
  (moveto 0.3613 1.2932)
  (lineto 0.1204 1.2487)
  (lineto 0.1126 0.7068)
  (lineto 0.3534 0.7513)
  (closepath)))
#(define ji:sharp-path '(
  (moveto 0 1.3173)
  (curveto 0 1.3387 0.0133 1.3573 0.0347 1.3653)
  (lineto 0.1573 1.4107)
  (lineto 0.1573 1.832)
  (curveto 0.1573 1.8587 0.1787 1.8827 0.2053 1.8827)
  (curveto 0.232 1.8827 0.256 1.8587 0.256 1.832)
  (lineto 0.256 1.448)
  (lineto 0.4773 1.528)
  (lineto 0.4773 1.9493)
  (curveto 0.4773 1.976 0.5013 2 0.528 2)
  (curveto 0.5547 2 0.576 1.976 0.576 1.9493)
  (lineto 0.576 1.5627)
  (lineto 0.6613 1.5947)
  (curveto 0.6667 1.5973 0.6747 1.5973 0.68 1.5973)
  (curveto 0.7093 1.5973 0.7333 1.5733 0.7333 1.544)
  (lineto 0.7333 1.384)
  (curveto 0.7333 1.3627 0.72 1.3413 0.6987 1.3333)
  (lineto 0.576 1.2907)
  (lineto 0.576 0.864)
  (lineto 0.6613 0.8933)
  (curveto 0.6667 0.896 0.6747 0.896 0.68 0.896)
  (curveto 0.7093 0.896 0.7333 0.872 0.7333 0.8427)
  (lineto 0.7333 0.6827)
  (curveto 0.7333 0.6613 0.72 0.6427 0.6987 0.6347)
  (lineto 0.576 0.5893)
  (lineto 0.576 0.168)
  (curveto 0.576 0.1413 0.5547 0.1173 0.528 0.1173)
  (curveto 0.5013 0.1173 0.4773 0.1413 0.4773 0.168)
  (lineto 0.4773 0.5547)
  (lineto 0.256 0.472)
  (lineto 0.256 0.0507)
  (curveto 0.256 0.024 0.232 0 0.2053 0)
  (curveto 0.1787 0 0.1573 0.024 0.1573 0.0507)
  (lineto 0.1573 0.4373)
  (lineto 0.072 0.4053)
  (curveto 0.0667 0.4027 0.0587 0.4027 0.0533 0.4027)
  (curveto 0.024 0.4027 0 0.4267 0 0.456)
  (lineto 0 0.616)
  (curveto 0 0.6373 0.0133 0.6587 0.0347 0.6667)
  (lineto 0.1573 0.7093)
  (lineto 0.1573 1.136)
  (lineto 0.072 1.1067)
  (curveto 0.0667 1.104 0.0587 1.104 0.0533 1.104)
  (curveto 0.024 1.104 0 1.128 0 1.1573)
  (closepath)
  (moveto 0.4773 1.2533)
  (lineto 0.256 1.1733)
  (lineto 0.256 0.7467)
  (lineto 0.4773 0.8267)
  (closepath)))
#(define ji:octave-path '(
  (moveto 0 0)
  (lineto 0.2165 0.375)
  (lineto 0.433 0.75)
  (lineto 0.6495 0.375)
  (lineto 0.866 0)
  (lineto 0.433 0)
  (closepath)
  ;(moveto 0.2165 0.1252)
  ;(lineto 0.6491 0.1252)
  ;(lineto 0.433 0.5002)
  ;(lineto 0.433 0.5)
  ;(closepath))
   ))
#(define ji:zero-path '(
  (moveto 0.5565 1.3984)
  (curveto 0.4597 1.3984 0.346 1.3065 0.346 0.7185)
  (curveto 0.346 0.5129 0.3484 0.1016 0.5468 0.1016)
  (curveto 0.6435 0.1016 0.7548 0.2347 0.7548 0.8153)
  (curveto 0.7548 1.2435 0.6508 1.3984 0.5565 1.3984)
  (closepath)
  (moveto 0.5444 0)
  (curveto 0.1911 0 0 0.3484 0 0.7452)
  (curveto 0 1.229 0.2444 1.5 0.5565 1.5)
  (curveto 0.8008 1.5 1.0984 1.3379 1.0984 0.7669)
  (curveto 1.0984 0.1911 0.7839 0 0.5444 0)
  (closepath)))
#(define ji:one-path '(
  (moveto 0.674 0.3039)
  (curveto 0.674 0.1005 0.7917 0.0907 0.9265 0.0833)
  (curveto 0.951 0.0686 0.951 0.0147 0.9265 0)
  (curveto 0.7255 0.0025 0.6152 0.0049 0.5172 0.0049)
  (curveto 0.4191 0.0049 0.1029 0 0.1029 0)
  (curveto 0.0784 0.0147 0.0784 0.0686 0.1029 0.0833)
  (curveto 0.2377 0.0907 0.3554 0.1005 0.3554 0.3039)
  (lineto 0.3554 1.0711)
  (curveto 0.3554 1.1936 0.3407 1.2034 0.3088 1.2034)
  (curveto 0.2745 1.2034 0.1863 1.1985 0.0539 1.1422)
  (curveto 0.0196 1.1667 0.0025 1.2059 0 1.2475)
  (curveto 0.2132 1.3358 0.3799 1.3946 0.5294 1.4632)
  (curveto 0.5858 1.4902 0.6275 1.5 0.652 1.5)
  (curveto 0.674 1.5 0.6936 1.4902 0.6936 1.4583)
  (curveto 0.6936 1.4583 0.674 1.3186 0.674 1.1887)
  (closepath)))
#(define ji:two-path '(
  (moveto 0.027 1.1164)
  (curveto 0.027 1.2689 0.1967 1.5 0.5484 1.5)
  (curveto 0.6934 1.5 0.8238 1.4508 0.9123 1.3672)
  (curveto 0.9836 1.3008 1.018 1.2098 1.018 1.1041)
  (curveto 1.018 0.8754 0.9197 0.8164 0.627 0.5459)
  (lineto 0.482 0.4131)
  (curveto 0.4008 0.3393 0.3762 0.273 0.3689 0.1943)
  (lineto 0.6885 0.1943)
  (curveto 0.7992 0.1943 0.8705 0.2607 0.9246 0.4279)
  (curveto 0.9811 0.4279 1.0033 0.418 1.0352 0.4033)
  (curveto 1.018 0.2631 0.9885 0.0934 0.959 0)
  (lineto 0.0098 0)
  (lineto 0 0.0787)
  (curveto 0.0074 0.1451 0.0492 0.2139 0.3541 0.5041)
  (lineto 0.5631 0.7033)
  (curveto 0.6934 0.8262 0.7033 0.932 0.7033 1.0967)
  (curveto 0.7033 1.1828 0.6762 1.2664 0.6393 1.3131)
  (curveto 0.5926 1.3697 0.5434 1.3992 0.4918 1.3992)
  (curveto 0.3738 1.3992 0.2877 1.2861 0.2877 1.2295)
  (curveto 0.2877 1.2025 0.2951 1.1828 0.3025 1.1656)
  (curveto 0.3098 1.1434 0.3148 1.1262 0.3148 1.1139)
  (curveto 0.3148 1.0377 0.2434 0.9836 0.1721 0.9836)
  (curveto 0.0836 0.9836 0.027 1.0549 0.027 1.1164)
  (closepath)))
#(define ji:three-path '(
  (moveto 0.4887 1.3984)
  (curveto 0.4065 1.3984 0.3048 1.3911 0.2782 1.2435)
  (curveto 0.2637 1.1661 0.2347 1.1105 0.1282 1.1105)
  (curveto 0.0484 1.1105 0.0363 1.1661 0.0363 1.2)
  (curveto 0.0363 1.2315 0.0532 1.2968 0.104 1.3452)
  (curveto 0.1815 1.4153 0.2831 1.5 0.5347 1.5)
  (curveto 0.8685 1.5 0.9266 1.3379 0.9266 1.2315)
  (curveto 0.9266 1.1371 0.8831 1.0621 0.825 0.9968)
  (curveto 0.7887 0.9556 0.7403 0.9218 0.7016 0.9024)
  (curveto 0.9048 0.8879 1.0185 0.7355 1.0185 0.5613)
  (curveto 1.0185 0.4234 0.9677 0.3121 0.8952 0.225)
  (curveto 0.7742 0.0798 0.5806 0 0.4137 0)
  (curveto 0.2952 0 0.1669 0.0315 0.0798 0.075)
  (curveto 0.0266 0.1016 0 0.1379 0 0.1887)
  (curveto 0 0.2298 0.0435 0.2927 0.1185 0.2927)
  (curveto 0.2081 0.2927 0.2492 0.2395 0.2758 0.2032)
  (curveto 0.3073 0.1621 0.3581 0.1016 0.4524 0.1016)
  (curveto 0.5419 0.1016 0.7065 0.1621 0.7065 0.4403)
  (curveto 0.7065 0.7306 0.7718 0.7669 0.404 0.7669)
  (curveto 0.3677 0.7669 0.3387 0.7621 0.2879 0.7476)
  (curveto 0.2734 0.7645 0.2685 0.7935 0.2685 0.8177)
  (curveto 0.2685 0.8274 0.2685 0.8347 0.271 0.8444)
  (curveto 0.496 0.8952 0.6411 1.0427 0.6411 1.2266)
  (curveto 0.6411 1.3403 0.5903 1.3984 0.4887 1.3984)
  (closepath)))
#(define ji:four-path '(
  (moveto 0.5877 1.2369)
  (curveto 0.4574 1.0598 0.2582 0.7254 0.1352 0.5189)
  (lineto 0.5877 0.5189)
  (closepath)
  (moveto 1.1336 0.5189)
  (curveto 1.1607 0.5189 1.1705 0.5041 1.1705 0.4795)
  (curveto 1.1705 0.45 1.1336 0.4033 1.0992 0.4033)
  (lineto 0.8926 0.4033)
  (lineto 0.8926 0.3049)
  (curveto 0.8926 0.1008 0.9861 0.091 1.1213 0.0836)
  (curveto 1.1459 0.0689 1.1459 0.0148 1.1213 0)
  (curveto 0.9197 0.0025 0.841 0.0049 0.7426 0.0049)
  (curveto 0.6443 0.0049 0.359 0 0.359 0)
  (curveto 0.3344 0.0148 0.3344 0.0689 0.359 0.0836)
  (curveto 0.4943 0.091 0.5877 0.1008 0.5877 0.3049)
  (lineto 0.5877 0.4033)
  (lineto 0.1525 0.4033)
  (curveto 0.0934 0.4033 0.0836 0.4082 0.0713 0.4205)
  (lineto 0.0344 0.4648)
  (curveto 0.0197 0.4918 0 0.5115 0 0.5213)
  (curveto 0 0.5287 0.0123 0.5459 0.0172 0.5533)
  (curveto 0.2213 0.8582 0.4844 1.2811 0.6713 1.5049)
  (lineto 0.8926 1.5049)
  (lineto 0.8926 0.5189)
  (closepath)))
#(define ji:five-path '(
  (moveto 0.6525 0.4767)
  (curveto 0.6525 0.7175 0.5658 0.8379 0.4526 0.8379)
  (curveto 0.3323 0.8379 0.2889 0.821 0.1132 0.756)
  (lineto 0.0819 0.7753)
  (lineto 0.1782 1.4928)
  (curveto 0.3154 1.4831 0.3925 1.4687 0.4912 1.4687)
  (curveto 0.6356 1.4687 0.7247 1.4831 0.9005 1.5)
  (lineto 0.9559 1.4687)
  (lineto 0.9101 1.2616)
  (curveto 0.7632 1.252 0.7199 1.2472 0.6332 1.2472)
  (curveto 0.5321 1.2472 0.3612 1.252 0.2841 1.2592)
  (curveto 0.2697 1.1822 0.248 1.0666 0.2384 0.9414)
  (curveto 0.2961 0.9559 0.4478 0.9727 0.5225 0.9727)
  (curveto 0.8066 0.9727 0.9799 0.7921 0.9799 0.5514)
  (curveto 0.9799 0.2624 0.7705 0 0.4502 0)
  (curveto 0.3347 0 0.1902 0.0193 0.0963 0.0674)
  (curveto 0.0361 0.0987 0 0.1541 0 0.195)
  (curveto 0 0.248 0.0361 0.3082 0.1228 0.3082)
  (curveto 0.2119 0.3082 0.2721 0.2624 0.3034 0.2143)
  (curveto 0.3419 0.1541 0.3876 0.1059 0.4358 0.1059)
  (curveto 0.5682 0.1059 0.6525 0.2408 0.6525 0.4767)
  (closepath)))
#(define ji:six-path '(
  (moveto 0.3073 0.7234)
  (curveto 0.3048 0.6968 0.3048 0.6363 0.3048 0.6097)
  (curveto 0.3048 0.1887 0.4379 0.0944 0.5589 0.0944)
  (curveto 0.646 0.0944 0.7234 0.2129 0.7234 0.4742)
  (curveto 0.7234 0.6194 0.6266 0.7863 0.4863 0.7863)
  (curveto 0.4427 0.7863 0.4016 0.7815 0.3073 0.7234)
  (closepath)
  (moveto 0.9823 1.4008)
  (curveto 0.8444 1.3935 0.6774 1.3718 0.5347 1.2556)
  (curveto 0.421 1.1637 0.3387 0.9992 0.3218 0.825)
  (curveto 0.4089 0.871 0.5105 0.9 0.5685 0.9073)
  (curveto 0.9653 0.9 1.0476 0.6363 1.0476 0.5177)
  (curveto 1.0476 0.3048 0.9073 0 0.5298 0)
  (curveto 0.2855 0 0 0.1016 0 0.6194)
  (curveto 0 0.8516 0.0774 1.1056 0.2613 1.2653)
  (curveto 0.4452 1.425 0.6266 1.4903 0.9677 1.5)
  (curveto 0.9871 1.4758 0.9895 1.4298 0.9823 1.4008)
  (closepath)))
#(define ji:seven-path '(
  (moveto 0.2971 1.222)
  (curveto 0.2181 1.222 0.1366 1.2053 0.0839 1.0136)
  (lineto 0 1.0208)
  (curveto 0.0192 1.1454 0.0455 1.3778 0.0479 1.4928)
  (curveto 0.0479 1.5 0.0503 1.5 0.0575 1.5)
  (curveto 0.1006 1.4904 0.1054 1.4665 0.1869 1.4665)
  (lineto 0.9896 1.4665)
  (lineto 1.004 1.4449)
  (curveto 0.6949 0.7931 0.5655 0.4337 0.405 0.024)
  (lineto 0.1605 0)
  (lineto 0.1462 0.0288)
  (curveto 0.3331 0.3738 0.6062 0.8962 0.7644 1.222)
  (closepath)))
#(define ji:note-degree-vector (vector
 `(
    (path . ,ji:zero-path)
    (width . 1.1)
    (height . 1.5))
 `(
    (path . ,ji:one-path)
    (width . .94)
    (height . 1.5))
 `(
    (path . ,ji:two-path)
    (width . 1.04)
    (height . 1.5))
 `(
    (path . ,ji:three-path)
    (width . 1.02)
    (height . 1.5)) 
 `(
    (path . ,ji:four-path)
    (width . 1.17)
    (height . 1.5)) 
 `(
    (path . ,ji:five-path)
    (width . .98)
    (height . 1.5)) 
 `(
    (path . ,ji:six-path)
    (width . 1.05)
    (height . 1.5)) 
 `(
    (path . ,ji:seven-path)
    (width . 1.0)
    (height . 1.5)) 
 ))
#(define ji:note-alteration-vector (vector
 `(
    (path . ,ji:flat-path)
    (width . .72)
    (height . 2)
    (target-height . 2))
 `(
    (path . ,ji:natural-path)
    (width . .47)
    (height . 2)
    (target-height . 2.5))
 `(
    (path . ,ji:sharp-path)
    (width . .73)
    (height . 2)
    (target-height . 2.5))
 `( 
    (path . #f)
    (width . 0)
    (height . 2)
    (target-height . 0))
 ))
#(define ji:note-octave-symbol `(
    (path . ,ji:octave-path)
    (width . .79)
    (height . .75)))

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       GENERAL CONFIGURATIONS 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define ji:diatonic-degree-markup-scaling '(1 . 1))
#(define ji:diatonic-alteration-markup-scaling '(1 . 1))
#(define ji:note-octave-markup-scaling '(1 . 1))
#(define ji:note-degree-stencil-target-height 1.5)

#(define ji:note-octave-stencil-target-height .5)
#(define ji:note-div-dur-stencil-beam-spacing .5)

#(define ji:note-div-dur-stencil-beam-thickness 2)
#(define ji:note-add-dur-stencil-dash-length 2/3)
#(define ji:note-add-dur-stencil-dash-spacing .5)
#(define ji:note-add-dur-stencil-dash-thickness 3)
#(define ji:note-add-dur-stencil-dot-spacing .5)
#(define ji:note-dot-size .2)
#(define ji:note-alteration-padding .25)
#(define ji:note-octave-padding 1/3)
#(define ji:note-div-dur-padding 1/3)
#(define ji:note-add-dur-padding .5)
#(define ji:voice-index-y-offset (list -5 5))

#(define ji:mag 1)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  VOICE REGISTRATION (2-VOICE STAFFS) 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define ji:voice-registration '())
#(define (ji:get-add-voice-registration staff-id voice-id) 
  (define (ji:equals-voice-id? x) (equal? x voice-id))   
  (let* (                
    (staff-voice-list 
     (or (assoc-ref ji:voice-registration staff-id) ;;get registered staff-id, if present
         (and (set! ji:voice-registration (append ji:voice-registration (acons staff-id (list voice-id) '()))) #f) ;;otherwise, add record and prevent short-circuit
         (assoc-ref ji:voice-registration staff-id))) ;;finally get registered staff-id    
    (voice-index 
     (or (list-index ji:equals-voice-id? staff-voice-list) ;;get voice-index, if present
         (and (set! staff-voice-list (append staff-voice-list (list voice-id))) #f) ;;otherwise, add record and prevent short-circuit
         (list-index ji:equals-voice-id? staff-voice-list))) ;;finally, get voice-index 
    )
    voice-index))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         UTILITY PROCEDURES
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:log2 x) (/ (log x) (log 2)))
#(define (ji:round2 x n)
   (/ (round (* (expt 10 n) x)) (expt 10 n)))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     CACHES AND CACHE RECORD TYPES
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% individual records stored in the caches defomed below
#(define-record-type <ji:stencil-rec> 
   (ji:make-stencil-rec stencil y-offset)
   ji:stencil-rec?

   (stencil        ji:stencil-rec-get-stencil)
   (y-offset       ji:stencil-rec-get-y-offset)
   )


#(define-record-type <ji:stencil-combine-rec> 
   (ji:make-stencil-combine-rec stencil axis direction padding)
   ji:stencil-combine-rec?

   (stencil        ji:stencil-combine-rec-get-stencil)
   (axis           ji:stencil-combine-rec-get-axis)
   (direction      ji:stencil-combine-rec-get-direction)
   (padding        ji:stencil-combine-rec-get-padding)
   )


% NOTE: this purposely uses a list, rather than a record-type, 
% for the key so that keys with the same values are treated as the same keys
#(define (ji:get-note-stencil-cache-key grob context)
    (let* (
            (note-event 	(ly:grob-property grob 'cause))
            (note-pitch 	(ly:event-property note-event 'pitch))
            (note-dur-prop 	(ly:event-property note-event 'duration))
            (note-dur 		(duration-length note-dur-prop))
            (tonic-pitch 	(ly:context-property context 'tonic))    
            (middle-c-position 	(ly:context-property context 'middleCPosition)))            
     
        (list note-pitch note-dur tonic-pitch middle-c-position)))


% a cache of stencils for notes
% uses (list note-pitch note-dur tonic-pitch) as key
#(define ji:note-stencil-rec-cache (make-hash-table 5000))

% a cache of stencils for rests
% uses dur as key
#(define ji:rest-stencil-rec-cache (make-hash-table 50))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     MARKUP->STENCIL PROCEDURES
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:get-note-degree-stencil-combine-rec grob note-degree-entry)
   (let* (
            (note-degree-path         (assq-ref note-degree-entry 'path))
            (note-degree-path-height  (assq-ref note-degree-entry 'height)))

      (ji:make-stencil-combine-rec
        (grob-interpret-markup grob   
          (markup 
            #:override `(filled . ,1) 
            #:scale `(1 . ,(/ ji:note-degree-stencil-target-height note-degree-path-height))
            #:path 0 note-degree-path))
        0 1 0)))


#(define (ji:get-rest-base-stencil-combine-rec grob)
  (let* (
          (vctr    (vector-ref ji:note-degree-vector 0))
          (path    (assq-ref vctr 'path))
          (height  (assq-ref vctr 'height)))   

      (ji:make-stencil-combine-rec          
        (grob-interpret-markup grob   
          (markup 
            #:override `(filled . ,1) 
            #:scale `(1 . ,(/ ji:note-degree-stencil-target-height height))
            #:path 0 path))
        0 1 0)))


#(define (ji:get-note-alteration-stencil-combine-rec grob note-alteration-entry note-degree-stencil)
   (let* (
            (note-alteration-path                 (assq-ref note-alteration-entry 'path))
            (note-alteration-path-height          (assq-ref note-alteration-entry 'height))
            (note-alteration-path-target-height   (assq-ref note-alteration-entry 'target-height))
            (note-extent-y (ly:stencil-extent note-degree-stencil 1))
            (note-height (- (cdr note-extent-y) (car note-extent-y)))
            (y-offset (* -1 (/ (- note-alteration-path-target-height note-height) 2))))
      (ji:make-stencil-combine-rec          
        (grob-interpret-markup grob   
          (if (not note-alteration-path) (markup "")
          (markup 
            #:override  `(filled . ,1) 
            #:scale     `(1 . ,(/ note-alteration-path-target-height note-alteration-path-height))
            #:translate `(0 . ,y-offset)
            #:path 0 note-alteration-path)))
        0 -1 ji:note-alteration-padding)))


#(define (ji:get-note-div-dur-stencil-combine-rec grob note-log2dur note-degree-stencil)
  (let* (
          (cumulative-stencil #f)
          (current-stencil #f)
          (stencil-extent-x (ly:stencil-extent note-degree-stencil 0)))
   
    (if (> note-log2dur 2)
      (for-each (lambda (i)
         (set! current-stencil (grob-interpret-markup grob                                                        
           (markup 
              #:override `((thickness . ,ji:note-div-dur-stencil-beam-thickness))
              #:translate `(,(car stencil-extent-x) . ,(* i ji:note-div-dur-stencil-beam-spacing))
              #:draw-line `(,(- (cdr stencil-extent-x) (car stencil-extent-x)) . 0))))
                  
         (set! cumulative-stencil 
           (if (not cumulative-stencil) current-stencil
             (ly:stencil-add cumulative-stencil current-stencil)))       
                
      ) (iota (- note-log2dur 2) 0)))

    (ji:make-stencil-combine-rec cumulative-stencil 1 -1 ji:note-div-dur-padding)))


#(define ji:numer-dot-map '((1 . 0) (3 . 1)  (7 . 2)  (15 . 3) (29 . 4)))

#(define (ji:dot-count note-dur)
  (let* ( 
          (x note-dur)
          (note-dur2 (begin (while (> x 1/2) (set! x (- x 1/4))) x)) 
          (numer (numerator note-dur2)))
    (assq-ref ji:numer-dot-map numer)))

#(define (ji:get-note-add-dur-stencil-combine-rec grob note-dur note-degree-stencil)
  (let* (
          (dash-count (if (< note-dur 1/4) 0 (floor (/ (- note-dur 1/4) 1/4))))
          (dot-count  (ji:dot-count  note-dur))
          (note-extent-y (ly:stencil-extent note-degree-stencil 1))
          (note-height (- (cdr note-extent-y) (car note-extent-y)))
          (y-offset (/ note-height 2))
          (cumulative-dash-stencil #f)
          (cumulative-dot-stencil #f)
          (current-stencil #f))
   
      ;; dashes
      (for-each (lambda (i)
  
        (set! current-stencil (grob-interpret-markup grob                                                        
           (markup 
              #:override `((thickness . ,ji:note-add-dur-stencil-dash-thickness))
              #:translate `(,(* i ji:note-add-dur-stencil-dash-spacing) . ,y-offset)
              #:draw-line `(,ji:note-add-dur-stencil-dash-length . 0))))
                  
        (set! cumulative-dash-stencil 
          (if (not cumulative-dash-stencil) current-stencil
             (ly:stencil-add cumulative-dash-stencil current-stencil)))       
                
      ) (iota dash-count 0))
  
      ;; dots
      (for-each (lambda (i)
  
        (set! current-stencil (grob-interpret-markup grob                                                        
           (markup 
              #:override `((thickness . ,ji:note-add-dur-stencil-dash-thickness))
              #:translate `(,(* i ji:note-add-dur-stencil-dot-spacing) . ,y-offset)
              #:draw-circle ji:note-dot-size 0 #t)))
                  
        (set! cumulative-dot-stencil 
          (if (not cumulative-dot-stencil) current-stencil
             (ly:stencil-add cumulative-dot-stencil current-stencil)))       
                
      ) (iota dot-count 0))
  
    (ji:make-stencil-combine-rec 
         (ly:stencil-combine-at-edge cumulative-dash-stencil 
               0 1 cumulative-dot-stencil ji:note-add-dur-padding) 
           0 1 ji:note-add-dur-padding)))

#(define (ji:get-note-high-octave-stencil-combine-rec grob note-relative-octave note-degree-stencil)
   (let* (
            (octave-path              (assq-ref ji:note-octave-symbol 'path))
            (octave-path-height       (assq-ref ji:note-octave-symbol 'height))
            (octave-path-width        (assq-ref ji:note-octave-symbol 'width))
            (scale                    (/ ji:note-octave-stencil-target-height octave-path-height))
            (scaled-width             (* scale octave-path-width))
            (note-extent-x (ly:stencil-extent note-degree-stencil 0))
            (note-width (- (cdr note-extent-x) (car note-extent-x)))
            (x-offset (/ (- note-width scaled-width ) 2))
            (cumulative-stencil       #f)
            (current-stencil          #f))

      (if (> note-relative-octave 0)
        (for-each (lambda (i)
           (set! current-stencil (grob-interpret-markup grob
                                                        
             (markup 
                #:override `(filled . ,1) 
                #:translate `(,x-offset . ,(* i ji:note-div-dur-stencil-beam-spacing))
                #:scale `(,scale . ,scale)
                #:path 0 octave-path)))
                    
           (set! cumulative-stencil 
             (if (not cumulative-stencil) current-stencil
               (ly:stencil-add cumulative-stencil current-stencil)))
                  
        ) (iota note-relative-octave 0)))

    (ji:make-stencil-combine-rec cumulative-stencil 1 1 ji:note-octave-padding)))

#(define (ji:get-note-low-octave-stencil-combine-rec grob note-relative-octave note-degree-stencil)
   (let* (
            (octave-path              (assq-ref ji:note-octave-symbol 'path))
            (octave-path-height       (assq-ref ji:note-octave-symbol 'height))
            (octave-path-width        (assq-ref ji:note-octave-symbol 'width))
            (scale                    (/ ji:note-octave-stencil-target-height octave-path-height))
            (scaled-width             (* scale octave-path-width))
            (note-extent-x (ly:stencil-extent note-degree-stencil 0))
            (note-width (- (cdr note-extent-x) (car note-extent-x)))
            (x-offset (/ (- note-width scaled-width ) 2))
            (cumulative-stencil       #f)
            (current-stencil          #f))

      (if (< note-relative-octave 0)
        (for-each (lambda (i)
           (set! current-stencil (grob-interpret-markup grob
                                                        
             (markup 
                #:override `(filled . ,1) 
                #:translate `(,x-offset . ,(* i ji:note-div-dur-stencil-beam-spacing))
                #:scale `(,scale . ,scale)
                #:rotate 180 
                #:path 0 octave-path)))
                    
           (set! cumulative-stencil 
             (if (not cumulative-stencil) current-stencil
               (ly:stencil-add cumulative-stencil current-stencil)))
                  
        ) (iota (abs note-relative-octave) 0)))

    (ji:make-stencil-combine-rec cumulative-stencil 1 -1 ji:note-octave-padding)))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         COMBINE STENCILS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:combine-stencils stencil-combine-rec-list)
   (let* (
          (cumulative-stencil '())
          (cumulative-y-offset 0))
     
      (for-each (lambda(r)
        (let* (
                (stencil          (ji:stencil-combine-rec-get-stencil r ))
                (axis             (ji:stencil-combine-rec-get-axis r ))
                (direction        (ji:stencil-combine-rec-get-direction r ))
                (padding          (ji:stencil-combine-rec-get-padding r ))
                (stencil-extent-y #f)
                (stencil-height   #f)) 
        
          (if stencil               
            (begin 
        
              (set! stencil-extent-y (ly:stencil-extent stencil 1))
              (set! stencil-height   (abs (- (cdr stencil-extent-y) (car stencil-extent-y)))) 
                
              (set! cumulative-y-offset 
                (if (eq? axis 1) 
                    (* .5 direction (+ stencil-height padding))
                    0))
              
              
              (set! cumulative-stencil 
                    (ly:stencil-combine-at-edge cumulative-stencil axis direction stencil padding)))))
                          
        ) stencil-combine-rec-list)
    
      (ji:make-stencil-rec (ly:stencil-scale cumulative-stencil ji:mag ji:mag) cumulative-y-offset)
    ))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       CONSTRUCT NOTE STENCIL
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:new-note-stencil-rec note-stencil-cache-key grob)
  (let* (
          (note-pitch               (first  note-stencil-cache-key))
          (note-dur                 (second note-stencil-cache-key))
          (tonic-pitch              (third  note-stencil-cache-key))
          (middle-c-position        (fourth note-stencil-cache-key))
          
          (tonic-semis              (ly:pitch-semitones tonic-pitch))
          (tonic-semis-mod12        (modulo tonic-semis 12))
          (tonic-alter              (ly:pitch-alteration tonic-pitch))
          (tonic-index              (* 2 (+ tonic-semis-mod12 tonic-alter )))
          
          (note-semis               (ly:pitch-semitones note-pitch))
          (note-log2dur             (- (ji:log2 (denominator note-dur)) (floor (/ (numerator note-dur) 2)))) 
          (note-index               (modulo (- note-semis tonic-semis) 12))
          
          (mag 			    (magstep (ly:grob-property grob 'font-size 0.0)))

          (diatonic-map-entry       (vector-ref ji:diatonic-map tonic-index))
          (note-degree              (vector-ref (assq-ref diatonic-map-entry 'note-step) note-index))
          (note-alteration          (vector-ref (assq-ref diatonic-map-entry 'note-alter) note-index))
          (note-relative-octave     (floor (/ (+ (- note-semis 2) (* 2 middle-c-position)) 12)))
          
          (note-degree-entry        (vector-ref ji:note-degree-vector note-degree))                
          (note-alteration-entry    (vector-ref ji:note-alteration-vector (if (eq? note-alteration 9) 3 (+ note-alteration 1))))
      
          (note-degree-stencil-combine-rec      (ji:get-note-degree-stencil-combine-rec grob note-degree-entry))              
          (note-degree-stencil                  (ji:stencil-combine-rec-get-stencil note-degree-stencil-combine-rec))          
          (note-high-octave-stencil-combine-rec (ji:get-note-high-octave-stencil-combine-rec grob note-relative-octave note-degree-stencil))
          (note-div-dur-stencil-combine-rec     (ji:get-note-div-dur-stencil-combine-rec grob note-log2dur note-degree-stencil))   
          (note-low-octave-stencil-combine-rec  (ji:get-note-low-octave-stencil-combine-rec grob note-relative-octave note-degree-stencil))
          (note-alteration-stencil-combine-rec  (ji:get-note-alteration-stencil-combine-rec grob note-alteration-entry note-degree-stencil))
          (note-add-dur-stencil-combine-rec     (ji:get-note-add-dur-stencil-combine-rec grob note-dur note-degree-stencil)))


      (set! ji:mag mag)

      ;; return combined stencils
      (ji:combine-stencils (list 
           note-degree-stencil-combine-rec    
           note-high-octave-stencil-combine-rec
           note-div-dur-stencil-combine-rec
           note-low-octave-stencil-combine-rec
           note-alteration-stencil-combine-rec
           note-add-dur-stencil-combine-rec))))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  GET NOTE STENCIL FROM CACHE OR NEW
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:get-note-stencil-rec grob context)
  (let* ( 
          (note-stencil-cache-key (ji:get-note-stencil-cache-key grob context))
          (note-stencil-rec (hashq-ref ji:note-stencil-rec-cache note-stencil-cache-key)))
   
    (if (not note-stencil-rec)
      (begin 
        (set! note-stencil-rec (ji:new-note-stencil-rec note-stencil-cache-key grob))
        (hash-set! ji:note-stencil-rec-cache note-stencil-cache-key note-stencil-rec)))
     
     note-stencil-rec
   ))


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       CONSTRUCT REST STENCIL
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:new-rest-stencil-rec dur grob)
  (let* (
          (log2dur (- (ji:log2 (denominator note-dur)) (floor (/ (numerator note-dur) 2)))) 
      
      (rest-base-stencil-combine-rec       
         (ji:get-rest-base-stencil-combine-rec grob))      
      (note-div-dur-stencil-combine-rec    
         (ji:get-note-div-dur-stencil-combine-rec grob log2dur rest-base-stencil))   
      (note-add-dur-stencil-combine-rec    
         (ji:get-note-add-dur-stencil-combine-rec grob dur)))

      ;; return combined stencils
      (ji:combine-stencils (list 
           rest-base-stencil-combine-rec    
           note-div-dur-stencil-combine-rec
           note-add-dur-stencil-combine-rec))))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  GET REST STENCIL FROM CACHE OR NEW
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:get-rest-stencil-rec grob)
  (let* ( 
          (rest-event (ly:grob-property grob 'cause))
          (dur-prop (ly:event-property rest-event 'duration))
          (dur (duration-length dur-prop))
          (rest-stencil-rec (hashq-ref rest-stencil-cache dur)))
   
    (if (not rest-stencil-rec)
      (begin 
        (set! rest-stencil-rec (ji:new-rest-stencil-rec dur grob))
        (hash-set! ji:rest-stencil-rec-cache dur rest-stencil-rec)))
     
     rest-stencil-rec))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          NOTEHEAD ENGRAVER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define ji-notehead-engraver
  (lambda (context)
    (make-engraver
      (acknowledgers
        ((note-head-interface engraver grob source-engraver)
            (let* (
                    (note-stencil-rec (ji:get-note-stencil-rec grob context))
                    (note-degree-stencil (ji:stencil-rec-get-stencil note-stencil-rec))
                    (y-offset (- (ji:stencil-rec-get-y-offset note-stencil-rec) .75))
                    
                    (note-extent-y (ly:stencil-extent note-degree-stencil 1))
                    (note-height (- (cdr note-extent-y) (car note-extent-y)))


                    (staff-id (or (ly:context-id context) "default"))            
                    (voice-context (ly:translator-context source-engraver))
                    (voice-id (or (ly:context-id voice-context) "default"))
                    (voice-index (ji:get-add-voice-registration staff-id voice-id))
                    (voice-count (or (length ji:voice-registration) 0))
                    ;(x (begin 
                    ;  (display "ji-rest-engraver.voice-id:")(display voice-id) (newline) 
                    ;  (display "ji:rest-engraver.voice-index:") (display voice-index)(newline)                     
                    ;  (display "ji:voice-index-y-offset:") (display ji:voice-index-y-offset)(newline)(newline)                     
                   ; 1))           
                    (voice-index-y-offset 0));(if (eq? 0 voice-count) 0 (list-ref ji:voice-index-y-offset voice-index))))


                (set! (ly:grob-property grob 'stencil) 
                    (ji:stencil-rec-get-stencil note-stencil-rec))            
                (set! (ly:grob-property grob 'Y-offset)
                    (+ voice-index-y-offset y-offset))))))))
            


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          REST ENGRAVER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define ji-rest-engraver
  (lambda (context)
    (make-engraver
      (acknowledgers
        ((rest-interface engraver grob source-engraver)
            (let* (
                    (rest-stencil-rec (ji:get-rest-stencil-rec grob))
                    (staff-id (or (ly:context-id context) "default"))            
                    (voice-context (ly:translator-context source-engraver))
                    (voice-id (or (ly:context-id voice-context) "default"))
                    (voice-index (ji:get-add-voice-registration staff-id voice-id))
                    (voice-count (or (length ji:voice-registration) 0))
                    (voice-index-y-offset (if (eq? 0 voice-count) 0 (list-ref ji:voice-index-y-offset voice-index))))

                (set! (ly:grob-property grob 'stencil) 
                    (ji:stencil-rec-get-stencil rest-stencil-rec))            
                (set! (ly:grob-property grob 'Y-offset)
                    (+ voice-index-y-offset (ji:stencil-rec-get-y-offset rest-stencil-rec)))))))))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         BEAM TRANSFORMER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:beam-min-x beaming)
   (let* (
     (min-x 9999999))
     
     (for-each (lambda (current-beam)
       (let* (
         (curr-x 0))
         (set! curr-x (car (assq-ref current-beam 'horizontal)))
         (if (< curr-x min-x)
             (set! min-x curr-x)))
     ) beaming )
     min-x ))


#(define (ji:beam-transformer grob orig)
   (let* (
          ;(x (begin (display "ji:beam-transformer")(newline) 1))           
          (xex (ly:stencil-extent orig X))
          (x-parent (ly:grob-parent grob X))        
          (y-parent (ly:grob-parent grob Y))
          (mag (magstep (ly:grob-property x-parent 'font-size 0.0)))  
          (logdur (ly:grob-property x-parent 'duration-log))
          (beaming (ly:beam::calc-beam-segments grob))
          (beam-min-x (ji:beam-min-x beaming))
          (cumulative-stencil #f)
          (current-stencil #f)
          (thickness ji:note-div-dur-stencil-beam-thickness)
          (y-offset (- (* -.05 thickness) .75 ji:note-div-dur-padding))) 

      (if (> logdur 2)
        (for-each (lambda (i)
           (let* (
                   (current-beam (list-ref beaming i))
                   (beam-x-extent (assq-ref current-beam 'horizontal)) 
                   (beam-start (/ (- (car beam-x-extent) beam-min-x) ji:mag))
                   (beam-length (/ (- (cdr beam-x-extent) (car beam-x-extent)) ji:mag))
                   (current-stencil (grob-interpret-markup grob                                                        
                     (markup 
                        #:override `((thickness . ,thickness))
                        #:translate `(,beam-start . ,(+ (* -.5 i) y-offset))
                        #:draw-line `(,beam-length . 0)))))
           
               (set! cumulative-stencil 
                 (if (not cumulative-stencil) current-stencil
                   (ly:stencil-add cumulative-stencil current-stencil))))      
                                 
          ) (iota (length beaming) 0)))
                          
      (ly:stencil-translate (ly:stencil-scale cumulative-stencil ji:mag ji:mag) (cons 0 (* .75 (- ji:mag 1))))))



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         SLUR TRANSFORMER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:slur-transformer grob orig)

  (let* (
          (height (ly:slur::pure-height grob 0 100))
          (cp-first  (first  orig))
          (cp-second (second orig))
          (cp-third  (third  orig))
          (cp-fourth (fourth orig))
          (width     (- (car cp-fourth) (car cp-first)))
          (summit    (+ (* .6011 (log width)) (max (car height) (cdr height))))
          (new-cp (list (cons (car cp-first) (car height)) 
                       (cons (car cp-second) summit)
                       (cons (car cp-third)  summit)
                       (cons (car cp-fourth) (cdr height)))))                   
     new-cp 
   ))
   
   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         TIE TRANSFORMER
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (ji:tie-transformer grob orig)

  (let* (
          (parent-x (ly:grob-parent grob X))
          (parent-y-extent (ly:grob-property parent-x 'Y-extent))
          (parent-height-from-center (cdr parent-y-extent))
          (layout (ly:grob-layout grob))
          (h (ly:output-def-lookup layout 'height))
          (cp-first  (first  orig))
          (cp-second (second orig))
          (cp-third  (third  orig))
          (cp-fourth (fourth orig))
          (width     (- (car cp-fourth) (car cp-first)))
          (summit    (+ (* .6011 (log width)) parent-height-from-center))
          (new-cp (list (cons (car cp-first) parent-height-from-center) 
                       (cons (car cp-second) summit)
                       (cons (car cp-third)  summit)
                       (cons (car cp-fourth) parent-height-from-center))))
    
    (display parent-x)(newline)
    (display parent-height-from-center)(newline)(newline)
    
     new-cp 
   ))



\layout {
  \context {
    \Staff
    
    \consists \ji-notehead-engraver
    \consists \ji-rest-engraver
       
    \override StaffSymbol.line-positions = #'(-6 6)
    \override StaffSymbol.ledger-positions = #'(0)

    \override Stem.direction = #DOWN
    \override Stem.Y-extent = #'(0 . 0)
    \override NoteHead.stem-attachment = #'(0 . 0)

    \override Stem.stencil = ##f
    \override Flag.stencil = ##f 
    \override StaffSymbol.stencil = ##f
    \override KeySignature.stencil = ##f
    \override Dots.stencil = ##f
    \override Accidental.stencil = ##f


    \override Beam.stencil =  #(grob-transformer 'stencil (
          lambda (grob orig) (ji:beam-transformer grob orig)))
        
    \override Slur.control-points =  #(grob-transformer 'control-points (
          lambda (grob orig) (ji:slur-transformer grob orig)))
  
    \override Tie.control-points =  #(grob-transformer 'control-points (
          lambda (grob orig) (ji:tie-transformer grob orig)))

  
  }
}  

