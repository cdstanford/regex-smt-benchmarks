;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[iI][fF][rR][aA][mM][eE]([^&gt;]*[^/&gt;]*[/&gt;]*[&gt;])
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;IFRAMEt"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "I" (str.++ "F" (str.++ "R" (str.++ "A" (str.++ "M" (str.++ "E" (str.++ "t" ""))))))))))))
;witness2: "\u00EA&lt;IfrAmEp\u00A0\u0091{\u00CF\u00DE\u008D\u00D9g\u0088"
(define-fun Witness2 () String (str.++ "\u{ea}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "I" (str.++ "f" (str.++ "r" (str.++ "A" (str.++ "m" (str.++ "E" (str.++ "p" (str.++ "\u{a0}" (str.++ "\u{91}" (str.++ "{" (str.++ "\u{cf}" (str.++ "\u{de}" (str.++ "\u{8d}" (str.++ "\u{d9}" (str.++ "g" (str.++ "\u{88}" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "F" "F") (re.range "f" "f"))(re.++ (re.union (re.range "R" "R") (re.range "r" "r"))(re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "E" "E") (re.range "e" "e")) (re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}"))))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ".")(re.union (re.range "0" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}")))))))(re.++ (re.* (re.union (re.range "&" "&")(re.union (re.range "/" "/")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t")))))) (re.union (re.range "&" "&")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
