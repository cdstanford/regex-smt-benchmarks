;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\D{0,2}[0]{0,3}[1]{0,1}\D{0,2}([2-9])(\d{2})\D{0,2}(\d{3})\D{0,2}(\d{3})\D{0,2}(\d{1})\D{0,2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0\u00D19395983805o\u0086"
(define-fun Witness1 () String (str.++ "0" (str.++ "\u{d1}" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "0" (str.++ "5" (str.++ "o" (str.++ "\u{86}" "")))))))))))))))
;witness2: "b\x6849K=888\u00F9749^0"
(define-fun Witness2 () String (str.++ "b" (str.++ "\u{06}" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "K" (str.++ "=" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "\u{f9}" (str.++ "7" (str.++ "4" (str.++ "9" (str.++ "^" (str.++ "0" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 2) (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 0 3) (re.range "0" "0"))(re.++ (re.opt (re.range "1" "1"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 0 2) (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
