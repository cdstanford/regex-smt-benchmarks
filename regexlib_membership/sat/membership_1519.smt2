;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (&#200;|&#201;|&#202;|&#203;|&#232;|&#233;|&#234;|&#235;|&amp;#069;|&amp;#101;|&amp;#200;|&amp;#201;|&amp;#202;|&amp;#203;|&amp;Egrave;|&amp;Eacute;|&amp;Ecirc;|&amp;Euml;|&amp;#232;|&amp;#233;|&amp;#234;|&amp;#235;|&amp;egrave;|&amp;eacute;|&amp;ecirc;|&amp;euml;)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "7&#201;"
(define-fun Witness1 () String (str.++ "7" (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "1" (str.++ ";" ""))))))))
;witness2: "\u00D7&amp;euml;"
(define-fun Witness2 () String (str.++ "\u{d7}" (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "e" (str.++ "u" (str.++ "m" (str.++ "l" (str.++ ";" ""))))))))))))

(assert (= regexA (re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "0" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "1" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "2" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "3" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "2" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "3" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "4" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "5" (str.++ ";" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "0" (str.++ "6" (str.++ "9" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "1" (str.++ "0" (str.++ "1" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "0" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "1" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "2" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "0" (str.++ "3" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "E" (str.++ "g" (str.++ "r" (str.++ "a" (str.++ "v" (str.++ "e" (str.++ ";" "")))))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "E" (str.++ "a" (str.++ "c" (str.++ "u" (str.++ "t" (str.++ "e" (str.++ ";" "")))))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "E" (str.++ "c" (str.++ "i" (str.++ "r" (str.++ "c" (str.++ ";" ""))))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "E" (str.++ "u" (str.++ "m" (str.++ "l" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "2" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "3" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "4" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "5" (str.++ ";" "")))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "e" (str.++ "g" (str.++ "r" (str.++ "a" (str.++ "v" (str.++ "e" (str.++ ";" "")))))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "e" (str.++ "a" (str.++ "c" (str.++ "u" (str.++ "t" (str.++ "e" (str.++ ";" "")))))))))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "r" (str.++ "c" (str.++ ";" "")))))))))))) (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "e" (str.++ "u" (str.++ "m" (str.++ "l" (str.++ ";" ""))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
