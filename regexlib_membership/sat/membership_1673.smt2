;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[iI][mM][gG]([^&gt;]*[^/&gt;])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;img%\x11"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ "%" (str.++ "\u{11}" ""))))))))))
;witness2: "&lt;ImG\u00D4"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "I" (str.++ "m" (str.++ "G" (str.++ "\u{d4}" "")))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "G" "G") (re.range "g" "g")) (re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}")))))) (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ".")(re.union (re.range "0" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
