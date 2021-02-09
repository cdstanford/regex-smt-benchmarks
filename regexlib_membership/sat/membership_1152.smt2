;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[iI][fF][rR][aA][mM][eE]([^&gt;]*[^/&gt;]*[/&gt;]*[&gt;])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;IFRAMEt"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "I" (seq.++ "F" (seq.++ "R" (seq.++ "A" (seq.++ "M" (seq.++ "E" (seq.++ "t" ""))))))))))))
;witness2: "\u00EA&lt;IfrAmEp\u00A0\u0091{\u00CF\u00DE\u008D\u00D9g\u0088"
(define-fun Witness2 () String (seq.++ "\xea" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "I" (seq.++ "f" (seq.++ "r" (seq.++ "A" (seq.++ "m" (seq.++ "E" (seq.++ "p" (seq.++ "\xa0" (seq.++ "\x91" (seq.++ "{" (seq.++ "\xcf" (seq.++ "\xde" (seq.++ "\x8d" (seq.++ "\xd9" (seq.++ "g" (seq.++ "\x88" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "F" "F") (re.range "f" "f"))(re.++ (re.union (re.range "R" "R") (re.range "r" "r"))(re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "E" "E") (re.range "e" "e")) (re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff"))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ".")(re.union (re.range "0" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff")))))))(re.++ (re.* (re.union (re.range "&" "&")(re.union (re.range "/" "/")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t")))))) (re.union (re.range "&" "&")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
