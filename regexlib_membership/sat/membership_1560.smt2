;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Vv][Ii1]agr.*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0091vIagr\x1F\x16\x15\u00DE"
(define-fun Witness1 () String (str.++ "\u{91}" (str.++ "v" (str.++ "I" (str.++ "a" (str.++ "g" (str.++ "r" (str.++ "\u{1f}" (str.++ "\u{16}" (str.++ "\u{15}" (str.++ "\u{de}" "")))))))))))
;witness2: "v1agr\u00A51\x1EG\u009B"
(define-fun Witness2 () String (str.++ "v" (str.++ "1" (str.++ "a" (str.++ "g" (str.++ "r" (str.++ "\u{a5}" (str.++ "1" (str.++ "\u{1e}" (str.++ "G" (str.++ "\u{9b}" "")))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "V" "V") (re.range "v" "v"))(re.++ (re.union (re.range "1" "1")(re.union (re.range "I" "I") (re.range "i" "i")))(re.++ (str.to_re (str.++ "a" (str.++ "g" (str.++ "r" "")))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
