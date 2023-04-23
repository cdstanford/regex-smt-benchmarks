;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(a-z|A-Z|0-9)*[^#$%^&*()']*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "A-Z0-9"
(define-fun Witness1 () String (str.++ "A" (str.++ "-" (str.++ "Z" (str.++ "0" (str.++ "-" (str.++ "9" "")))))))
;witness2: "0-9a-za-zA-Za-z0-9A-ZA-ZA-Z0-9a-zA-ZA-Za-za-z"
(define-fun Witness2 () String (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "A" (str.++ "-" (str.++ "Z" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "A" (str.++ "-" (str.++ "Z" (str.++ "A" (str.++ "-" (str.++ "Z" (str.++ "A" (str.++ "-" (str.++ "Z" (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "A" (str.++ "-" (str.++ "Z" (str.++ "A" (str.++ "-" (str.++ "Z" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "a" (str.++ "-" (str.++ "z" ""))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (str.to_re (str.++ "a" (str.++ "-" (str.++ "z" ""))))(re.union (str.to_re (str.++ "A" (str.++ "-" (str.++ "Z" "")))) (str.to_re (str.++ "0" (str.++ "-" (str.++ "9" "")))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{22}")(re.union (re.range "+" "]") (re.range "_" "\u{ff}")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
