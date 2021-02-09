;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[iI][mM][gG]([^&gt;]*[^/&gt;]*[/&gt;]*[&gt;])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00EDM\u00E4&lt;imgO\x57/t}"
(define-fun Witness1 () String (seq.++ "\xed" (seq.++ "M" (seq.++ "\xe4" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "O" (seq.++ "\x05" (seq.++ "7" (seq.++ "/" (seq.++ "t" (seq.++ "}" "")))))))))))))))))
;witness2: "\x1D&lt;img~\x2/tr"
(define-fun Witness2 () String (seq.++ "\x1d" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "~" (seq.++ "\x02" (seq.++ "/" (seq.++ "t" (seq.++ "r" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "G" "G") (re.range "g" "g")) (re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff"))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ".")(re.union (re.range "0" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff")))))))(re.++ (re.* (re.union (re.range "&" "&")(re.union (re.range "/" "/")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t")))))) (re.union (re.range "&" "&")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
