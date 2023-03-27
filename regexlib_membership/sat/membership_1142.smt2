;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-9]{5})*-([0-9]{4}))|([0-9]{5})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "19807-4449\u00ED"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "7" (str.++ "-" (str.++ "4" (str.++ "4" (str.++ "4" (str.++ "9" (str.++ "\u{ed}" ""))))))))))))
;witness2: "-3269\x7~y"
(define-fun Witness2 () String (str.++ "-" (str.++ "3" (str.++ "2" (str.++ "6" (str.++ "9" (str.++ "\u{07}" (str.++ "~" (str.++ "y" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.* ((_ re.loop 5 5) (re.range "0" "9")))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))) (re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
