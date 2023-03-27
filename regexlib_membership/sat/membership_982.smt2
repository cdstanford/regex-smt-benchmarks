;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{1,2}((,)|(,25)|(,50)|(,5)|(,75)|(,0)|(,00))?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "91,00"
(define-fun Witness1 () String (str.++ "9" (str.++ "1" (str.++ "," (str.++ "0" (str.++ "0" ""))))))
;witness2: "2,0"
(define-fun Witness2 () String (str.++ "2" (str.++ "," (str.++ "0" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "," ",")(re.union (str.to_re (str.++ "," (str.++ "2" (str.++ "5" ""))))(re.union (str.to_re (str.++ "," (str.++ "5" (str.++ "0" ""))))(re.union (str.to_re (str.++ "," (str.++ "5" "")))(re.union (str.to_re (str.++ "," (str.++ "7" (str.++ "5" ""))))(re.union (str.to_re (str.++ "," (str.++ "0" ""))) (str.to_re (str.++ "," (str.++ "0" (str.++ "0" ""))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
