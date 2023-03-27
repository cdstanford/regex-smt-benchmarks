;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = url=\"([^\[\]\"]*)\"
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "X3url=\"\""
(define-fun Witness1 () String (str.++ "X" (str.++ "3" (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" "")))))))))
;witness2: "url=\"|q\"N"
(define-fun Witness2 () String (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "=" (str.++ "\u{22}" (str.++ "|" (str.++ "q" (str.++ "\u{22}" (str.++ "N" ""))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "=" (str.++ "\u{22}" ""))))))(re.++ (re.* (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}"))))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
