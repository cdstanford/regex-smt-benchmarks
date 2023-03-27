;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)? ?(AM|am|PM|pm)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "12/9/22996:08:32pm"
(define-fun Witness1 () String (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "9" (str.++ "/" (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ ":" (str.++ "0" (str.++ "8" (str.++ ":" (str.++ "3" (str.++ "2" (str.++ "p" (str.++ "m" "")))))))))))))))))))
;witness2: "10/22/288520:29:45"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "/" (str.++ "2" (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "2" (str.++ "0" (str.++ ":" (str.++ "2" (str.++ "9" (str.++ ":" (str.++ "4" (str.++ "5" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.opt (re.range "0" "2")) (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.range "1" "2") ((_ re.loop 3 3) (re.range "0" "9"))))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" ""))) (str.to_re (str.++ "p" (str.++ "m" ""))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
