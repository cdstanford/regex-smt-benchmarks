;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]\:\\.*|^\\\\.*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\\%\u00F8"
(define-fun Witness1 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "%" (str.++ "\u{f8}" "")))))
;witness2: "\\"
(define-fun Witness2 () String (str.++ "\u{5c}" (str.++ "\u{5c}" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (str.to_re (str.++ ":" (str.++ "\u{5c}" ""))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "\u{5c}" (str.++ "\u{5c}" ""))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
