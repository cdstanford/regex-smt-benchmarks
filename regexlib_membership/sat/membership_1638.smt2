;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "20:52"
(define-fun Witness1 () String (str.++ "2" (str.++ "0" (str.++ ":" (str.++ "5" (str.++ "2" ""))))))
;witness2: "13:49:38"
(define-fun Witness2 () String (str.++ "1" (str.++ "3" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ ":" (str.++ "3" (str.++ "8" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ ((_ re.loop 0 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))) (re.++ (re.range " " " ")(re.++ (re.union (re.range "A" "A") (re.range "P" "P")) (re.range "M" "M"))))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ ((_ re.loop 0 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
