;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((25[0-4]|(2[0-4]|1[0-9]|[1-9]?)[0-9]\.){3}(25[0-4]|(2[0-4]|1[0-9]|[1-9]?)[0-9]))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "83.4.6.28"
(define-fun Witness1 () String (str.++ "8" (str.++ "3" (str.++ "." (str.++ "4" (str.++ "." (str.++ "6" (str.++ "." (str.++ "2" (str.++ "8" ""))))))))))
;witness2: "254244.2.87"
(define-fun Witness2 () String (str.++ "2" (str.++ "5" (str.++ "4" (str.++ "2" (str.++ "4" (str.++ "4" (str.++ "." (str.++ "2" (str.++ "." (str.++ "8" (str.++ "7" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 3 3) (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "4")) (re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "4"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.opt (re.range "1" "9"))))(re.++ (re.range "0" "9") (re.range "." "."))))) (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "4")) (re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "4"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.opt (re.range "1" "9")))) (re.range "0" "9")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
