;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(CY){0,1}[0-9]{8}[A-Z]$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "CY81367419N"
(define-fun Witness1 () String (str.++ "C" (str.++ "Y" (str.++ "8" (str.++ "1" (str.++ "3" (str.++ "6" (str.++ "7" (str.++ "4" (str.++ "1" (str.++ "9" (str.++ "N" ""))))))))))))
;witness2: "19485996Z"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "Z" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "C" (str.++ "Y" ""))))(re.++ ((_ re.loop 8 8) (re.range "0" "9"))(re.++ (re.range "A" "Z") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
