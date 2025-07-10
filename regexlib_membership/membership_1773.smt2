;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xBi-4884-8-2"
(define-fun Witness1 () String (str.++ "\u{0b}" (str.++ "i" (str.++ "-" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "-" (str.++ "8" (str.++ "-" (str.++ "2" ""))))))))))))
;witness2: "8689-88-3\xAv\""
(define-fun Witness2 () String (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "3" (str.++ "\u{0a}" (str.++ "v" (str.++ "\u{22}" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 2) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
