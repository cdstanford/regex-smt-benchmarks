;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (&#200;|&#201;|&#202;|&#203;|&#232;|&#233;|&#234;|&#235;|&amp;#069;|&amp;#101;|&amp;#200;|&amp;#201;|&amp;#202;|&amp;#203;|&amp;Egrave;|&amp;Eacute;|&amp;Ecirc;|&amp;Euml;|&amp;#232;|&amp;#233;|&amp;#234;|&amp;#235;|&amp;egrave;|&amp;eacute;|&amp;ecirc;|&amp;euml;)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "7&#201;"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "1" (seq.++ ";" ""))))))))
;witness2: "\u00D7&amp;euml;"
(define-fun Witness2 () String (seq.++ "\xd7" (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "e" (seq.++ "u" (seq.++ "m" (seq.++ "l" (seq.++ ";" ""))))))))))))

(assert (= regexA (re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "0" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "1" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "2" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "3" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "2" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "3" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "4" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "5" (seq.++ ";" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "0" (seq.++ "6" (seq.++ "9" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "1" (seq.++ "0" (seq.++ "1" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "0" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "1" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "2" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "0" (seq.++ "3" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "E" (seq.++ "g" (seq.++ "r" (seq.++ "a" (seq.++ "v" (seq.++ "e" (seq.++ ";" "")))))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "E" (seq.++ "a" (seq.++ "c" (seq.++ "u" (seq.++ "t" (seq.++ "e" (seq.++ ";" "")))))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "E" (seq.++ "c" (seq.++ "i" (seq.++ "r" (seq.++ "c" (seq.++ ";" ""))))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "E" (seq.++ "u" (seq.++ "m" (seq.++ "l" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "2" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "3" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "4" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "#" (seq.++ "2" (seq.++ "3" (seq.++ "5" (seq.++ ";" "")))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "e" (seq.++ "g" (seq.++ "r" (seq.++ "a" (seq.++ "v" (seq.++ "e" (seq.++ ";" "")))))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "e" (seq.++ "a" (seq.++ "c" (seq.++ "u" (seq.++ "t" (seq.++ "e" (seq.++ ";" "")))))))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "r" (seq.++ "c" (seq.++ ";" "")))))))))))) (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "e" (seq.++ "u" (seq.++ "m" (seq.++ "l" (seq.++ ";" ""))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
