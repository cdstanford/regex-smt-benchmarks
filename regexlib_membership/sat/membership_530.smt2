;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(BG){0,1}([0-9]{9}|[0-9]{10})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9548181479"
(define-fun Witness1 () String (str.++ "9" (str.++ "5" (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "1" (str.++ "4" (str.++ "7" (str.++ "9" "")))))))))))
;witness2: "384721369"
(define-fun Witness2 () String (str.++ "3" (str.++ "8" (str.++ "4" (str.++ "7" (str.++ "2" (str.++ "1" (str.++ "3" (str.++ "6" (str.++ "9" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "B" (str.++ "G" ""))))(re.++ (re.union ((_ re.loop 9 9) (re.range "0" "9")) ((_ re.loop 10 10) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
