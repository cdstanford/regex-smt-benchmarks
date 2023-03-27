;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([+]|00)39)?((3[1-6][0-9]))(\d{7})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3682073192"
(define-fun Witness1 () String (str.++ "3" (str.++ "6" (str.++ "8" (str.++ "2" (str.++ "0" (str.++ "7" (str.++ "3" (str.++ "1" (str.++ "9" (str.++ "2" "")))))))))))
;witness2: "00393483298487"
(define-fun Witness2 () String (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "3" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "7" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.range "+" "+") (str.to_re (str.++ "0" (str.++ "0" "")))) (str.to_re (str.++ "3" (str.++ "9" "")))))(re.++ (re.++ (re.range "3" "3")(re.++ (re.range "1" "6") (re.range "0" "9")))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
