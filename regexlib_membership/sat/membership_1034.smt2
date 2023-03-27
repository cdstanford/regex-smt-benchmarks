;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0|1[0-9]{0,2}|2[0-9]{0,1}|2[0-4][0-9]|25[0-5]|[3-9][0-9]{0,1})\.){3}(0|1[0-9]{0,2}|2[0-9]{0,1}|2[0-4][0-9]|25[0-5]|[3-9][0-9]{0,1})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0.38.255.249"
(define-fun Witness1 () String (str.++ "0" (str.++ "." (str.++ "3" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "9" "")))))))))))))
;witness2: "0.242.252.239"
(define-fun Witness2 () String (str.++ "0" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "2" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "2" (str.++ "." (str.++ "2" (str.++ "3" (str.++ "9" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ (re.union (re.range "0" "0")(re.union (re.++ (re.range "1" "1") ((_ re.loop 0 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2") (re.opt (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")) (re.++ (re.range "3" "9") (re.opt (re.range "0" "9")))))))) (re.range "." ".")))(re.++ (re.union (re.range "0" "0")(re.union (re.++ (re.range "1" "1") ((_ re.loop 0 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2") (re.opt (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")) (re.++ (re.range "3" "9") (re.opt (re.range "0" "9")))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
