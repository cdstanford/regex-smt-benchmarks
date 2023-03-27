;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(NL){0,1}[0-9]{9}B[0-9]{2}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "818588387B39"
(define-fun Witness1 () String (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "7" (str.++ "B" (str.++ "3" (str.++ "9" "")))))))))))))
;witness2: "593479889B99"
(define-fun Witness2 () String (str.++ "5" (str.++ "9" (str.++ "3" (str.++ "4" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "B" (str.++ "9" (str.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "N" (str.++ "L" ""))))(re.++ ((_ re.loop 9 9) (re.range "0" "9"))(re.++ (re.range "B" "B")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
