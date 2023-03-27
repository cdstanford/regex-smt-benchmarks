;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{2}.?\d{3}.?\d{3}/?\d{4}-?\d{2}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "62*988\u008B753/8898-46"
(define-fun Witness1 () String (str.++ "6" (str.++ "2" (str.++ "*" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "\u{8b}" (str.++ "7" (str.++ "5" (str.++ "3" (str.++ "/" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "4" (str.++ "6" "")))))))))))))))))))
;witness2: "\u00AD\u00CEZo89756,699/3729647\u00A7"
(define-fun Witness2 () String (str.++ "\u{ad}" (str.++ "\u{ce}" (str.++ "Z" (str.++ "o" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "5" (str.++ "6" (str.++ "," (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "/" (str.++ "3" (str.++ "7" (str.++ "2" (str.++ "9" (str.++ "6" (str.++ "4" (str.++ "7" (str.++ "\u{a7}" "")))))))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "/" "/"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 2 2) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
