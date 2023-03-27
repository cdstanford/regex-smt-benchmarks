;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (")([0-9]*)(",")([0-9]*)("\))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"3\",\"8\")"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "3" (str.++ "\u{22}" (str.++ "," (str.++ "\u{22}" (str.++ "8" (str.++ "\u{22}" (str.++ ")" "")))))))))
;witness2: "\u00BF\u00CE\x0\"9\",\"988\")"
(define-fun Witness2 () String (str.++ "\u{bf}" (str.++ "\u{ce}" (str.++ "\u{00}" (str.++ "\u{22}" (str.++ "9" (str.++ "\u{22}" (str.++ "," (str.++ "\u{22}" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "\u{22}" (str.++ ")" ""))))))))))))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.range "0" "9"))(re.++ (str.to_re (str.++ "\u{22}" (str.++ "," (str.++ "\u{22}" ""))))(re.++ (re.* (re.range "0" "9")) (str.to_re (str.++ "\u{22}" (str.++ ")" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
