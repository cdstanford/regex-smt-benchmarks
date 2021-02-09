;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[iI][mM][gG]([^&gt;]*[^/&gt;])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;img%\x11"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "%" (seq.++ "\x11" ""))))))))))
;witness2: "&lt;ImG\u00D4"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "I" (seq.++ "m" (seq.++ "G" (seq.++ "\xd4" "")))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "G" "G") (re.range "g" "g")) (re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff")))))) (re.union (re.range "\x00" "%")(re.union (re.range "'" ".")(re.union (re.range "0" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
