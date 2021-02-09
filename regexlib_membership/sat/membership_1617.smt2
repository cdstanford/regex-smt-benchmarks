;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)? ?(AM|am|PM|pm)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "12/9/22996:08:32pm"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "9" (seq.++ "/" (seq.++ "2" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ ":" (seq.++ "0" (seq.++ "8" (seq.++ ":" (seq.++ "3" (seq.++ "2" (seq.++ "p" (seq.++ "m" "")))))))))))))))))))
;witness2: "10/22/288520:29:45"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "0" (seq.++ "/" (seq.++ "2" (seq.++ "2" (seq.++ "/" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "5" (seq.++ "2" (seq.++ "0" (seq.++ ":" (seq.++ "2" (seq.++ "9" (seq.++ ":" (seq.++ "4" (seq.++ "5" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.opt (re.range "0" "2")) (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.range "1" "2") ((_ re.loop 3 3) (re.range "0" "9"))))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" ""))) (str.to_re (seq.++ "p" (seq.++ "m" ""))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
