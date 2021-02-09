;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0]\d|[1][0-2])\/([0-2]\d|[3][0-1])\/([2][01]|[1][6-9])\d{2}(\s([0-1]\d|[2][0-3])(\:[0-5]\d){1,2})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "11/20/2088\u008520:18:41"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "1" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "\x85" (seq.++ "2" (seq.++ "0" (seq.++ ":" (seq.++ "1" (seq.++ "8" (seq.++ ":" (seq.++ "4" (seq.++ "1" ""))))))))))))))))))))
;witness2: "08/20/1995\u00A020:34"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "8" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "/" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "\xa0" (seq.++ "2" (seq.++ "0" (seq.++ ":" (seq.++ "3" (seq.++ "4" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "1")) (re.++ (re.range "1" "1") (re.range "6" "9")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))) ((_ re.loop 1 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
